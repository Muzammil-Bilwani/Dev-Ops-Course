# 🚀 Learning GitHub Actions CI/CD (From Basics to Intermediate)

This guide will take you step by step into **GitHub Actions (CI/CD)**. Each section is a small “piece” of learning you can try, and at the end we’ll combine everything into a full pipeline.  

---

## 0) What is YAML?

**YAML** is just a config format.  
- **Key & value:**  
  ```yaml
  name: Build
  ```
- **Lists:**  
  ```yaml
  steps:
    - name: Checkout
    - name: Test
  ```
- **Indentation matters** (use spaces, not tabs).  
- **Comments** with `#`.

---

## 1) Core Idea of GitHub Actions

- A **workflow** = a YAML file in `.github/workflows/`.
- Workflows run on **runners** (VMs provided by GitHub or your own machine).
- Workflows have:
  - **Triggers (`on`)** → when to run (push, pull_request, schedule, manual).  
  - **Jobs** → run in parallel by default.  
  - **Steps** → executed top to bottom inside a job.  
  - **Actions** → reusable steps (e.g., `actions/checkout@v4`).  
  - **run** → shell commands.  

---

## 2) First Workflow (Hello World)

Create `.github/workflows/hello.yml`:

```yaml
name: Hello CI

on:
  push:
    branches: [ main ]
  workflow_dispatch: {} # run manually from Actions tab

jobs:
  hello:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Say hello
        run: echo "Hello from GitHub Actions!"
```

Push to `main` → check **Actions** tab. 🎉

---

## 3) Runners 101

- **GitHub-hosted runner:**  
  `runs-on: ubuntu-latest` (also `windows-latest`, `macos-latest`).  

- **Self-hosted runner:**  
  Install agent on your own machine/VM.  
  ```yaml
  runs-on: [self-hosted, linux, x64]
  ```

⚠️ Self-hosted runners must be secured — they have repo & secrets access.

---

## 4) Simple Node.js CI

```yaml
name: Node CI

on:
  pull_request:
  push:
    branches: [ main ]

jobs:
  ci:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Node
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'

      - name: Install deps
        run: npm ci

      - name: Lint
        run: npm run lint --if-present

      - name: Test
        run: npm test -- --ci --reporters=default
```

---

## 5) Artifacts (Save Outputs)

Upload things like build bundles or coverage:

```yaml
      - name: Build app
        run: npm run build --if-present

      - name: Upload build
        uses: actions/upload-artifact@v4
        with:
          name: web-dist
          path: dist/
```

---

## 6) Matrix Builds (Multiple Versions)

```yaml
jobs:
  test-matrix:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest]
        node: [18, 20]
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node }}
          cache: npm
      - run: npm ci
      - run: npm test -- --ci
```

---

## 7) Secrets and Environment Variables

- Add **secrets** in Repo → Settings → Secrets → Actions.  
- Use in workflow:  
  ```yaml
  env:
    NPM_TOKEN: ${{ secrets.NPM_TOKEN }}
  ```

Example: Publish to npm on tag:

```yaml
on:
  push:
    tags: ['v*.*.*']

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          registry-url: 'https://registry.npmjs.org'
      - run: npm ci
      - run: npm publish
        env:
          NODE_AUTH_TOKEN: ${{ secrets.NPM_TOKEN }}
```

---

## 8) Deploy Example (GitHub Pages)

```yaml
name: Deploy Pages

on:
  push:
    branches: [ main ]

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: '20', cache: 'npm' }
      - run: npm ci && npm run build
      - uses: actions/upload-pages-artifact@v3
        with:
          path: ./dist

  deploy:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/deploy-pages@v4
```

---

## 9) Docker Build & Push (to GitHub Container Registry)

```yaml
name: Build & Push Image

on:
  push:
    branches: [ main ]

jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Log in to GHCR
        run: echo ${{ github.token }} | docker login ghcr.io -u ${{ github.actor }} --password-stdin

      - name: Build image
        run: |
          IMAGE=ghcr.io/${{ github.repository }}:sha-${{ github.sha }}
          docker build -t $IMAGE .
          echo "IMAGE=$IMAGE" >> $GITHUB_ENV

      - name: Push image
        run: docker push $IMAGE
```

---

## 10) Advanced Features

- **Environments with approvals:** require manual approval before prod deploy.  
- **Concurrency:**  
  ```yaml
  concurrency:
    group: ci-${{ github.ref }}
    cancel-in-progress: true
  ```  
- **Permissions:** limit what workflows can access.  

---

## 11) Self-Hosted Runner (Basics)

1. Go to repo → Settings → Actions → Runners → New self-hosted runner.  
2. Install agent with `./config.sh`.  
3. Run with `./run.sh`.  
4. Use in workflow:  
   ```yaml
   runs-on: [self-hosted, linux]
   ```

---

## 12) Debugging Tips

- Check **raw logs** in each step.  
- Add debug logs:  
  ```yaml
  run: echo "::debug::Debug info"
  ```  
- Re-run failed jobs.  
- Use conditions:  
  ```yaml
  if: github.event_name == 'push'
  ```

---

## Putting It All Together (Node + Docker CI/CD)

```yaml
name: CI/CD (Node + Docker)

on:
  push:
    branches: [ main ]
  pull_request:
  workflow_dispatch:
  push:
    tags: ['v*.*.*']

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: npm
      - run: npm ci
      - run: npm test

  docker:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: echo ${{ github.token }} | docker login ghcr.io -u ${{ github.actor }} --password-stdin
      - run: |
          IMAGE=ghcr.io/${{ github.repository }}:sha-${{ github.sha }}
          docker build -t $IMAGE .
          docker push $IMAGE
```

---

## 🎓 Roadmap to Practice

1. Make a Hello workflow.  
2. Add Node.js CI (install, test).  
3. Use cache and artifacts.  
4. Try matrix builds.  
5. Add secrets and env.  
6. Add a deploy job (Pages, Docker, server).  
7. Protect deploys with approvals.  
8. Try a self-hosted runner.  
