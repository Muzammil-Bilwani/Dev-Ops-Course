# DevOps Foundations — Theme Guide

This project is a set of static HTML course pages for the BanoQabil DevOps Foundations course.
Each topic lives in its own subfolder (e.g. `linux/`, `git/`, `docker/`) with an `index.html`.
The root `index.html` is the home page with topic tiles linking to each subfolder.

---

## Design System

### Fonts
- **Display / UI**: `Space Grotesk` (weights 400, 600, 700) — headings, body, labels
- **Code / mono**: `JetBrains Mono` (weights 400, 700) — terminals, tags, badges, numbers

Load both from Google Fonts:
```html
<link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;700&family=Syne:wght@400;600;800&display=swap" rel="stylesheet">
```

### Color Palette (CSS variables)
```css
:root {
  --bg:      #0d1117;   /* Page background */
  --surface: #161b22;   /* Cards, modules */
  --surface2:#1c2128;   /* Hover states, nested surfaces */
  --border:  #30363d;   /* All borders */
  --green:   #39d353;   /* Primary accent — prompts, badges, success */
  --cyan:    #58a6ff;   /* Info, links, assignments */
  --orange:  #f78166;   /* Warnings, errors */
  --yellow:  #e3b341;   /* Highlights, in-progress */
  --purple:  #bc8cff;   /* Secondary accent */
  --text:    #e6edf3;   /* Primary text */
  --muted:   #8b949e;   /* Secondary text, labels */
}
```

### Grid Background
Applied to `body::before` on every page:
```css
body::before {
  content: '';
  position: fixed;
  inset: 0;
  background-image:
    linear-gradient(rgba(57,211,83,0.03) 1px, transparent 1px),
    linear-gradient(90deg, rgba(57,211,83,0.03) 1px, transparent 1px);
  background-size: 40px 40px;
  pointer-events: none;
  z-index: 0;
}
```

---

## Page Layout

### Header
- Max-width `1100px`, centered, `padding: 60px 40px 40px`
- Green pill `.badge` → `font-family: JetBrains Mono`, `font-size: 12px`
- `h1` with `clamp(2rem, 5vw, 3.5rem)`, `font-weight: 800`; accent word in `color: var(--green)`
- `.subtitle` in `var(--muted)`, `font-size: 1.1rem`

### Main Content
- Max-width `1100px`, `padding: 0 40px 80px`
- `position: relative; z-index: 1` to sit above the grid background

### Responsive breakpoint
At `max-width: 600px` (topic pages) or `700px` (home): reduce horizontal padding to `20px`.

---

## Components

### Terminal Block
```html
<div class="terminal">
  <div class="terminal-bar">
    <div class="dot red"></div>
    <div class="dot yellow"></div>
    <div class="dot green"></div>
    <div class="terminal-label">bash — filename.sh</div>
  </div>
  <div class="terminal-body">
    <div><span class="prompt">$ </span><span class="cmd">command here</span></div>
    <div><span class="output">output here</span></div>
    <div><span class="comment"># comment</span></div>
  </div>
</div>
```

Terminal color classes:
- `.prompt` → `var(--green)` — the `$` prefix
- `.cmd` → `var(--text)` — the command
- `.comment` → `var(--muted)` — `# comments`
- `.output` → `#8b949e` — command output
- `.highlight` → `var(--yellow)` — important values
- `.error-color` → `var(--orange)` — errors / warnings
- `.info` → `var(--cyan)` — informational output

Terminal background: `#010409`. Terminal bar: `var(--surface2)`.
Dots: red `#ff5f57`, yellow `#febc2e`, green `#28c840`.

### Module / Accordion (topic pages)
Each topic has numbered collapsible modules:
```html
<div class="module" id="m1">
  <div class="module-header" onclick="toggle('m1')">
    <div class="module-num">01</div>
    <div class="module-title-wrap">
      <div class="module-title">Title</div>
      <div class="module-desc">Short description</div>
    </div>
    <div class="module-arrow">▾</div>
  </div>
  <div class="module-body"> ... </div>
</div>
```
Toggle JS:
```js
function toggle(id) {
  document.getElementById(id).classList.toggle('open');
}
```

### Tag Pills
```html
<div class="tags">
  <span class="tag green">label</span>
  <span class="tag blue">label</span>
  <span class="tag orange">label</span>
  <span class="tag purple">label</span>
  <span class="tag yellow">label</span>
</div>
```

### Key Points Grid
```html
<div class="key-points">
  <div class="key-point">
    <div class="kp-icon">🔑</div>
    <div class="kp-title">Title</div>
    <div class="kp-desc">Description</div>
  </div>
</div>
```
Grid: `repeat(auto-fill, minmax(220px, 1fr))`, gap `12px`.

### Assignment Box
```html
<div class="assignment-box">
  <h4>📋 Assignment Requirements</h4>
  <ul>
    <li>Requirement one</li>
  </ul>
</div>
```
Border: `rgba(88,166,255,0.2)`, background: `rgba(88,166,255,0.05)`, heading color: `var(--cyan)`.

### Practice Questions Block
Add a `.practice-block` at the **end of every module body** (after key-points / tags / terminal). Each module should ship 3–6 questions; **roughly 25% include a `<details>` answer**, the rest are open-ended for in-class discussion. Use `.pq-hint` (italic, muted) to nudge students toward the right resource without giving the answer.

```html
<div class="practice-block">
  <h4>🎯 Practice Questions</h4>

  <!-- Open-ended question (no answer) -->
  <div class="practice-q">
    <div class="pq-num">Q1.</div>
    <div class="pq-content">
      <div class="pq-text">Question text with inline <code>code</code> as needed.</div>
      <div class="pq-hint">💡 Optional hint — a search term or concept.</div>
    </div>
  </div>

  <!-- ~25% of questions: include a <details> answer -->
  <div class="practice-q">
    <div class="pq-num">Q2.</div>
    <div class="pq-content">
      <div class="pq-text">Question text...</div>
      <details class="pq-answer">
        <summary>Show Answer</summary>
        <div class="pq-answer-body">
          Answer with <code>commands</code> and brief reasoning.
        </div>
      </details>
    </div>
  </div>
</div>
```

Styling: purple-tinted box (`rgba(188,140,255,0.05)` bg, `rgba(188,140,255,0.2)` border). Answer reveal uses native `<details>` — no JS needed. Answer body has a green left border (`var(--green)`) and dark `#010409` background to match terminals.

---

## SEO

Every topic page **must** include the following in `<head>`. Replace placeholders per topic.

```html
<title>{{Topic}} for DevOps — Beginner to Practical Course | BanoQabil DevOps Foundations</title>
<meta name="description" content="{{1–2 sentences describing what the page teaches and what's hands-on. Mention the project/assignment by name.}}">
<meta name="keywords" content="{{topic}} for devops, {{topic}} tutorial, {{topic}} beginner course, devops foundations, banoqabil, ...">
<meta name="author" content="BanoQabil DevOps Foundations">
<meta name="robots" content="index, follow, max-image-preview:large">
<meta name="theme-color" content="#0d1117">

<meta property="og:type" content="article">
<meta property="og:title" content="{{Topic}} for DevOps — Beginner to Practical Course">
<meta property="og:description" content="{{Same one-line summary}}">
<meta property="og:site_name" content="BanoQabil DevOps Foundations">
<meta property="og:locale" content="en_US">

<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="{{Topic}} for DevOps — Beginner to Practical Course">
<meta name="twitter:description" content="{{Short summary}}">

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Course",
  "name": "{{Topic}} for DevOps — Foundations",
  "description": "{{2–3 sentence description}}",
  "provider": { "@type": "EducationalOrganization", "name": "BanoQabil" },
  "educationalLevel": "Beginner",
  "inLanguage": "en",
  "teaches": [ "{{Skill 1}}", "{{Skill 2}}", "..." ],
  "hasCourseInstance": {
    "@type": "CourseInstance",
    "courseMode": "online",
    "courseWorkload": "PT8H"
  }
}
</script>
```

**Rules:**
- **Do not invent absolute URLs** (no `og:url`, no `canonical`) until the site is hosted at a known domain. Adding wrong URLs hurts SEO more than omitting them.
- Keep the `<title>` under 60 characters where possible; descriptions under 160.
- The `teaches` array in JSON-LD should list 6–10 concrete skills the page covers — Google uses this for rich-result eligibility.
- Each module should have a real-world "Practical:" example terminal block. Search engines and students both reward concrete code over abstract explanation.

### Badge (header pill)
```html
<div class="badge">$ some-shell-command</div>
```
Green tinted, monospace, small pill used as a page-level label.

---

## Animation

Cards and modules fade in on load:
```css
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(16px); }
  to   { opacity: 1; transform: translateY(0); }
}
```
Stagger via `animation-delay` on `:nth-child(n)` — increment by `0.05s` per item.

---

## Topic Card (home page only)

Each topic on `index.html` uses `.topic-card` with a CSS custom property for its accent color:
```html
<a class="topic-card" href="linux/index.html" style="--card-color: #39d353">
```
The `--card-color` drives the hover border, top stripe, and arrow color.

Status badges:
- `.card-status.available` — green
- `.card-status.coming-soon` — muted
- `.card-status.in-progress` — yellow
- `.card-status.bonus` — yellow-tinted (`color: var(--yellow)`, `border: rgba(227,179,65,0.4)`, `background: rgba(227,179,65,0.08)`). Use for stretch topics that sit *outside* the official BanoQabil curriculum (e.g. Kubernetes). Bonus tiles also stay `.disabled` until a lighter page is built.

Disabled (not yet built) cards get `.disabled` class — `opacity: 0.5`, `pointer-events: none`.

---

## Topic Accent Colors (use consistently)

| Topic                 | Color     | Hex       |
|-----------------------|-----------|-----------|
| DevOps Mindset        | Yellow    | `#e3b341` |
| Git                   | Orange    | `#f78166` |
| Linux                 | Green     | `#39d353` |
| AI-assisted DevOps    | Purple    | `#bc8cff` |
| AWS                   | Yellow    | `#e3b341` |
| Networking (DNS/CDN)  | Yellow    | `#e3b341` |
| Serverless            | Cyan      | `#58a6ff` |
| Terraform             | Purple    | `#bc8cff` |
| CI/CD                 | Purple    | `#bc8cff` |
| Docker                | Cyan      | `#58a6ff` |
| Monitoring            | Orange    | `#f78166` |
| DevSecOps             | Orange    | `#f78166` |
| Freelancing           | Green     | `#39d353` |
| Capstone              | Green     | `#39d353` |
| Kubernetes (Bonus)    | Cyan      | `#58a6ff` |

---

## Curriculum → Tile Mapping

The home grid mirrors the official **BanoQabil DevOps Foundations** 12-week, 16-module syllabus 1:1. Each curriculum module has a single home tile and a single `<topic>/index.html`. Module 10 (CI/CD fundamentals) and Module 11 (GitHub Actions in depth) are merged into one `cicd/` page; Modules 5 (AWS core) and 6 (Static + dynamic deployment) are merged into one `aws/` page. The `screencapture-banoqabil-pk-courses-devops-foundations-*.pdf` in the project root is the source of truth — re-render it via Quartz if you ever need to re-extract the bullets.

| Curriculum module               | Tile path             |
|---------------------------------|-----------------------|
| M1 — DevOps Mindset & Career    | `mindset/index.html`  |
| M2 — Git & GitHub for teams     | external (`gitgoahead.muzammilbilwani.com`) |
| M3 — Linux essentials           | `linux/index.html`    |
| M4 — AI-assisted DevOps         | `ai/index.html`       |
| M5 + M6 — AWS Core + deployment | `aws/index.html`      |
| M7 — DNS, CDN & HTTPS           | `networking/index.html` |
| M8 — Serverless                 | `serverless/index.html` |
| M9 — Terraform / IaC            | `terraform/index.html` |
| M10 + M11 — CI/CD + GH Actions  | `cicd/index.html`     |
| M12 — Docker & Containers       | `docker/index.html`   |
| M13 — Monitoring & Observability | `monitoring/index.html` |
| M14 — DevSecOps                 | `security/index.html` |
| M15 — Freelancing               | `freelancing/index.html` |
| M16 — Capstone                  | `capstone/index.html` |
| —  Kubernetes (Bonus)           | `kubernetes/index.html` (out-of-syllabus stretch) |

When BanoQabil updates the curriculum, refresh the PDF, re-extract bullets, and update this mapping + the affected page module lists. Do **not** silently invent modules — the curriculum drives the structure.

---

## File Structure

```
dev-ops/
├── index.html              ← Home page (15 topic tiles: 14 main + 1 bonus)
├── CLAUDE.md               ← This file
├── linux/index.html        ← built
├── docker/index.html       ← built
├── cicd/index.html         ← built
├── mindset/                ← M1 — pending
├── ai/                     ← M4 — pending
├── aws/                    ← M5+M6 — pending
├── networking/             ← M7 — pending
├── serverless/             ← M8 — pending
├── terraform/              ← M9 — pending
├── monitoring/             ← M13 — pending
├── security/               ← M14 — pending
├── freelancing/            ← M15 — pending
├── capstone/               ← M16 — pending
└── kubernetes/             ← bonus — pending
```

Each `topic/index.html` should have a "← Back" link to `../index.html` in the header.
