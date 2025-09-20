# 🚀 Introduction to Docker

## 1. Why Containers?

Before Docker, applications were deployed directly on servers. This caused problems:

- **Works on my machine issue** → An app ran locally but broke in production.
- **Conflicts** → Two apps required different versions of the same library.
- **Heavy VMs** → Virtual machines solved some issues but were slow and consumed a lot of resources.

👉 **Containers solve this**:

- Lightweight (share the host OS kernel).
- Portable (run anywhere).
- Isolated (each container has its own environment).

---

## 2. Docker Concepts

- **Image** → A snapshot/blueprint of an app (like a recipe).
- **Container** → A running instance of an image (like a dish made from the recipe).
- **Dockerfile** → Instructions to build an image.
- **Docker Hub** → A public repository to share images.

---

## 3. Docker Syntax Basics

- Check Docker version:
  ```bash
  docker --version
  ```
- Run your first container (hello world):
  ```bash
  docker run hello-world
  ```
- List running containers:
  ```bash
  docker ps
  ```
- Stop a container:
  ```bash
  docker stop <container_id>
  ```
- Remove a container:
  ```bash
  docker rm <container_id>
  ```

---

## 4. Building Dockerfiles

A **Dockerfile** defines how to build an image. Example with **Node.js** app:

### Step 1: Create a simple Node app (`app.js`)

```js
const http = require("http");

const server = http.createServer((req, res) => {
  res.end("Hello from Docker!");
});

server.listen(3000, () => {
  console.log("Server running on port 3000");
});
```

### Step 2: Create a `package.json`

```json
{
  "name": "docker-demo",
  "version": "1.0.0",
  "main": "app.js",
  "scripts": {
    "start": "node app.js"
  }
}
```

### Step 3: Write a `Dockerfile`

```dockerfile
# Use official Node.js image
FROM node:18

# Set working directory
WORKDIR /usr/src/app

# Copy package.json and install deps
COPY package*.json ./
RUN npm install

# Copy app files
COPY . .

# Expose port
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
```

---

## 5. Running Containers

Build and run your container:

```bash
# Build image
docker build -t docker-demo .

# Run container
docker run -p 4000:3000 docker-demo
```

👉 Open [http://localhost:4000](http://localhost:4000) and you’ll see:

```
Hello from Docker!
```

---

## 6. Hands-on: Your First Dockerized App

1. Install Docker.
2. Create a small Node.js (or Python) app.
3. Write a `Dockerfile`.
4. Build the image.
5. Run it with port mapping.
6. Share image on Docker Hub (optional).
