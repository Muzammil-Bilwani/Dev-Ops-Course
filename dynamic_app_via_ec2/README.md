# Server-Side Deployment Guide (EC2 • Node.js • Manual via SSH/Git • NGINX)

> This step-by-step guide takes you from zero to production on **AWS EC2** with a **Node.js** app, deployed manually (via **SSH** or **git clone**), fronted by **NGINX** with HTTPS. It includes concise definitions of key terms as we go.

---

## 📚 Quick Glossary (terms used in this guide)

- **EC2 (Elastic Compute Cloud):** AWS virtual server you rent by the hour.
- **SSH (Secure Shell):** Encrypted way to log into your server from your laptop/terminal.
- **Security Group:** Virtual firewall attached to your EC2 that controls inbound/outbound traffic.
- **Elastic IP:** Static public IP you can assign to your instance (won’t change on reboot).
- **NVM:** Node Version Manager—install/manage Node versions.
- **PM2:** Popular Node.js **process manager** that keeps your app alive and supports zero-downtime reloads.
- **Reverse Proxy:** A front server (NGINX) that forwards requests to your app on an internal port.
- **Systemd:** Linux init system to run services on boot (alternative to PM2).
- **Certbot/Let’s Encrypt:** Automated, free TLS certificates for HTTPS.
- **Environment variables (.env):** Config values (like `PORT`, API keys) kept out of code.

---

## 0) Prerequisites

- AWS account + IAM user with EC2 access
- A domain (optional but recommended), e.g. `timetotravelto.online`
- A local terminal with SSH (macOS/Linux) or PuTTY (Windows)
- Your Node.js app (example assumes it listens on `PORT=3000`)

---

## 1) Create an EC2 Instance

1. **Launch Instance**

   - AMI: **Ubuntu 22.04 LTS** (recommended for simplicity)
     > _On Amazon Linux 2023, swap `apt` with `yum`/`dnf` in commands below._
   - Type: `t3.micro` (free-tier eligible) or larger as needed
   - Key pair: create/download `.pem`
   - **Security Group (inbound):**
     - `22/tcp` (SSH) — _temporarily open to your IP only_
     - `80/tcp` (HTTP)
     - `443/tcp` (HTTPS)

2. **(Optional) Allocate Elastic IP** and associate to the instance.

3. **Note the Public IP / DNS** — you’ll SSH with this.

---

## 2) Point Domain to the Server (DNS)

- In your DNS provider, create an **A record**:
  - `@  →  <Elastic IP>`
  - `www →  <Elastic IP>` (optional)
    > DNS can take minutes to propagate.

---

## 3) Connect via SSH

```bash
# set correct permissions
chmod 400 your-key.pem

# connect (replace user & ip/dns)
ssh -i your-key.pem ubuntu@YOUR_EC2_PUBLIC_IP
```

> **User:** `ubuntu` on Ubuntu; `ec2-user` on Amazon Linux.

---

## 4) First-Time Server Setup

```bash
# Update system
sudo apt update && sudo apt -y upgrade

# Basic tools
sudo apt -y install git curl build-essential ufw

# Optional: create a non-root deploy user
sudo adduser deploy
sudo usermod -aG sudo deploy
# Copy SSH key to deploy user for passwordless login
sudo rsync --archive --chown=deploy:deploy ~/.ssh /home/deploy

# Firewall (UFW): allow SSH, HTTP, HTTPS
sudo ufw allow OpenSSH
sudo ufw allow 80
sudo ufw allow 443
sudo ufw --force enable
sudo ufw status
```

---

## 5) Install Node.js (via NVM)

```bash
# login as deploy (optional but recommended)
sudo su - deploy

# Install NVM + LTS Node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
# load nvm in current shell
export NVM_DIR="$HOME/.nvm"; . "$NVM_DIR/nvm.sh"
nvm install --lts
node -v
npm -v

# Enable corepack (for pnpm/yarn if needed)
npm i -g npm@latest pm2
```

> **Term — PM2:** Keeps your Node app running, restarts on crash, and supports zero-downtime reloads.

---

## 6) Get Your App onto the Server (Manual Options)

### Option A — Upload via SCP (or SFTP)

From your local machine:

```bash
# from the folder containing your project
scp -i your-key.pem -r . ubuntu@YOUR_EC2_PUBLIC_IP:/home/deploy/app
```

### Option B — Clone from Git (recommended for future updates)

On the server:

```bash
sudo su - deploy
mkdir -p ~/apps && cd ~/apps
git clone https://github.com/your/repo.git app
cd app

# Install dependencies
npm ci   # or: npm install

# Build (if applicable)
npm run build
```

> **Tip:** Add a **read-only deploy key** to your repo for private clones.

---

## 7) Configure Environment Variables

Create an `.env` (or export vars via shell). Example:

```bash
cd ~/apps/app
cat > .env << 'EOF'
NODE_ENV=production
PORT=3000
# Add your app-specific secrets/keys here
EOF
```

> Never commit `.env` with secrets. Keep it on the server or in a secret manager.

---

## 8) Run the App with PM2 (recommended)

```bash
# Start (adjust entry file)
pm2 start "npm run start" --name timetotravelto
# or: pm2 start server.js --name timetotravelto --time

# Save process list and enable startup on boot
pm2 save
pm2 startup systemd -u deploy --hp /home/deploy
# follow the printed command (sudo ...) once, then:
pm2 save

# Check
pm2 status
pm2 logs timetotravelto
```

> **Zero-downtime reload:** `pm2 reload timetotravelto`

### (Alternative) Run via systemd (no PM2)

Create a unit file:

```bash
sudo tee /etc/systemd/system/timetotravelto.service > /dev/null << 'EOF'
[Unit]
Description=TimeToTravelTo Node App
After=network.target

[Service]
Environment=NODE_ENV=production
Environment=PORT=3000
User=deploy
WorkingDirectory=/home/deploy/apps/app
ExecStart=/bin/bash -lc 'export NVM_DIR="/home/deploy/.nvm"; . "$NVM_DIR/nvm.sh"; node server.js'
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable timetotravelto
sudo systemctl start timetotravelto
sudo systemctl status timetotravelto
```

---

## 9) Install & Configure NGINX (Reverse Proxy)

```bash
sudo apt -y install nginx
sudo systemctl enable nginx
sudo systemctl start nginx
```

Create a server block:

```bash
sudo tee /etc/nginx/sites-available/timetotravelto.conf > /dev/null << 'EOF'
server {
  listen 80;
  listen [::]:80;
  server_name timetotravelto.online www.timetotravelto.online;

  # Real IP / Proxy headers
  location / {
    proxy_pass http://127.0.0.1:3000;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_read_timeout 60s;
    proxy_send_timeout 60s;
  }

  # Static asset caching (if you serve via Node or a /public dir)
  location ~* \.(?:css|js|jpg|jpeg|gif|png|svg|ico|webp|woff2?)$ {
    expires 7d;
    access_log off;
  }

  # Gzip
  gzip on;
  gzip_types text/plain text/css application/json application/javascript application/xml+rss application/xml application/x-font-ttf application/vnd.ms-fontobject image/svg+xml;
  gzip_min_length 1024;
}
EOF

sudo ln -s /etc/nginx/sites-available/timetotravelto.conf /etc/nginx/sites-enabled/timetotravelto.conf
sudo nginx -t
sudo systemctl reload nginx
```

> **Term — Reverse Proxy:** NGINX accepts requests on ports 80/443 and forwards them to your app on `127.0.0.1:3000`.

---

## 10) Add HTTPS with Let’s Encrypt (Certbot)

```bash
sudo apt -y install certbot python3-certbot-nginx
sudo certbot --nginx -d timetotravelto.online -d www.timetotravelto.online
# Answer prompts; choose redirect (force HTTPS)
sudo systemctl status certbot.timer   # auto-renewal
sudo certbot renew --dry-run
```

> **Tip:** Ensure ports **80/443** are open in the EC2 **Security Group** and UFW.

---

## 11) Manual Deploy Workflow (SSH / Git)

### Deploy updates with Git

```bash
ssh -i your-key.pem deploy@YOUR_EC2_PUBLIC_IP
cd ~/apps/app
git pull origin main
npm ci        # or: npm install
npm run build # if applicable

# Restart app
pm2 reload timetotravelto   # zero-downtime
# or: sudo systemctl restart timetotravelto
```

### Quick deploy script (server-side)

```bash
cat > ~/deploy.sh << 'EOF'
#!/usr/bin/env bash
set -e
APP_DIR="/home/deploy/apps/app"
cd "$APP_DIR"
git fetch --all
git reset --hard origin/main
npm ci
npm run build || true
pm2 reload timetotravelto
EOF
chmod +x ~/deploy.sh
```

Then just:

```bash
ssh -i your-key.pem deploy@YOUR_EC2_PUBLIC_IP "~/deploy.sh"
```

### Deploy via SCP (no Git)

```bash
# from local (rebuild on server)
scp -i your-key.pem -r . deploy@YOUR_EC2_PUBLIC_IP:/home/deploy/apps/app
ssh -i your-key.pem deploy@YOUR_EC2_PUBLIC_IP "cd ~/apps/app && npm ci && npm run build && pm2 reload timetotravelto"
```

---

## 12) Logs, Metrics & Backups

- **App logs (PM2):**
  ```bash
  pm2 logs timetotravelto
  pm2 monit
  ```
- **NGINX logs:**
  - Access: `/var/log/nginx/access.log`
  - Error: `/var/log/nginx/error.log`
- **Log rotation:** Ubuntu includes `logrotate` by default; PM2 also rotates (`pm2 install pm2-logrotate`).
- **Basic monitoring:**
  - `htop`, `iostat`, `vmstat`, `pm2 monit`
  - (Advanced) Install **CloudWatch Agent** to push system/app logs to AWS.
- **Backups:**
  - App code (Git is your backup)
  - `/etc/nginx/` configs and SSL:  
    `sudo tar czf nginx-backup.tgz /etc/nginx /etc/letsencrypt`

---

## 13) Hardening & Production Tips (Advanced)

- **SSH hardening:**
  - Use keys only; disable password auth:
    ```bash
    sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
    sudo systemctl reload ssh
    ```
  - Optionally change SSH port (update Security Group & UFW if you do).
- **Least privilege:** Run Node as non-root (`deploy` user).
- **Resource limits:** PM2 cluster mode (multi-core):
  ```bash
  pm2 start server.js -i max --name timetotravelto
  ```
- **Environment secrets:** Keep `.env` outside Git. For multiple environments, use different files or AWS SSM Parameter Store.
- **Zero-downtime deploys:** `pm2 reload` or blue/green with two app dirs and symlink swap.
- **Health checks:** Add `/healthz` in your app; configure an ALB/ELB later if you need autoscaling.
- **Compression/Brotli:** You can add Brotli with `nginx-module-brotli` (advanced).
- **Static files:** Serve from NGINX directly for performance; point `root` to a build folder and `try_files` before proxying.

---

## 14) Quick Troubleshooting

- **Site not loading?**
  - `curl -I http://localhost:3000` (on server) — app alive?
  - `sudo nginx -t && sudo systemctl reload nginx` — config valid?
  - Security Group/Firewall allow 80/443?
- **502/504 errors:** App crashed or wrong port. Check `pm2 logs`.
- **Certbot failed:** DNS not propagated or port 80 blocked.
- **Permission denied (publickey):** Wrong key or wrong user (`ubuntu` vs `ec2-user`).

---

## 15) Minimal Example: Node App (Express)

```js
// server.js
import express from "express";
import dotenv from "dotenv";
dotenv.config();

const app = express();
const port = process.env.PORT || 3000;

app.get("/healthz", (_, res) => res.json({ ok: true }));
app.get("/", (_, res) => res.send("TimeToTravelTo is live!"));

app.listen(port, () => {
  console.log(`Server listening on http://localhost:${port}`);
});
```

`package.json`:

```json
{
  "name": "timetotravelto",
  "type": "module",
  "scripts": {
    "start": "node server.js",
    "build": "echo \"no build\""
  },
  "dependencies": {
    "dotenv": "^16.4.5",
    "express": "^4.19.2"
  }
}
```
