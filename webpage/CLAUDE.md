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

Status badges: `.card-status.available` (green), `.card-status.coming-soon` (muted), `.card-status.in-progress` (yellow).

Disabled (not yet built) cards get `.disabled` class — `opacity: 0.5`, `pointer-events: none`.

---

## Topic Accent Colors (use consistently)

| Topic       | Color     | Hex       |
|-------------|-----------|-----------|
| Linux       | Green     | `#39d353` |
| Git         | Orange    | `#f78166` |
| Docker      | Cyan      | `#58a6ff` |
| AWS         | Yellow    | `#e3b341` |
| CI/CD       | Purple    | `#bc8cff` |
| Kubernetes  | Cyan      | `#58a6ff` |
| Terraform   | Purple    | `#bc8cff` |
| Monitoring  | Orange    | `#f78166` |
| Networking  | Yellow    | `#e3b341` |
| Security    | Orange    | `#f78166` |

---

## File Structure

```
dev-ops/
├── index.html          ← Home page (topic tiles)
├── CLAUDE.md           ← This file
├── linux/
│   └── index.html
├── git/
│   └── index.html
├── docker/
│   └── index.html
└── ...
```

Each `topic/index.html` should have a "← Back" link to `../index.html` in the header.
