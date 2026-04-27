# Maxime's Marvelous Todolist

**[https://lesdouillets.github.io/Maxime_ToDo/todos.html](https://lesdouillets.github.io/Maxime_ToDo/todos.html)**

A personal task manager that lives inside [Cursor](https://cursor.sh). You talk to it in the Cursor chat, it organises your tasks into a single interactive HTML dashboard you open in your browser — no server, no accounts, no dependencies.

---

## Setup

### 1. Copy the skill files

Place both files in your Cursor skills folder (create it if it doesn't exist):

```
~/.cursor/skills/todo-agent/SKILL.md
~/.cursor/skills/todo-agent/generate_html.py
```

### 2. Create your working folder

Create the folder where your data and dashboard will live:

```
~/Documents/Cursor/todo-agent/
```

If you want to use a different path, edit the 3 path references near the top of `SKILL.md`.

### 3. Create an empty todo list

Create a file called `todos.json` in your working folder with this content:

```json
{ "todos": [] }
```

### 4. Open the dashboard

After adding your first task (see below), open `todos.html` in Chrome or Safari. That's it.

---

## Adding tasks

Type directly in the Cursor chat — or in the dashboard's command bar.

### Mark a task as urgent

Either prefix with `!` or include the word `urgent` anywhere in the input. The flag is stripped from the saved title.

```
Fix the production bug
! Hotfix the login crash
urgent Send investor recap
```

Both of the urgent examples above produce a task with the `Urgent` badge.

### With a deadline

The deadline is parsed automatically and stripped from the title:

```
Prepare strategy workshop by friday
Submit report before 17/04
! Fix onboarding bug in 3 days
Archive old projects within a week
```

**Recognised deadline patterns:**

| What you type | Result |
|---|---|
| `06/03` or `17/04` | That exact date (DD/MM) |
| `today` | Today |
| `tomorrow` | Tomorrow |
| `by friday` / `before tuesday` | The coming occurrence of that weekday |
| `next week` / `this week` | The coming Monday |
| `in 3 days` / `within 7 days` | Today + N days |
| `in a week` / `within a week` | Today + 7 days |
| `in 2 weeks` | Today + 14 days |
| `by march 6th` / `6th march` | That calendar date |

> **Urgent items without a deadline automatically get a deadline of tomorrow.**

### With @mentions

Tag people involved in the task using `@Name`. Their names appear as coloured chips under the task title in the dashboard, and are stripped from the title text:

```
Review spec @Marie @Antoine by friday
! Fix login bug @Backend
```

### With a dependency

Signal that the task is blocked by someone using natural language. A chip is shown under the title:

```
Write release notes waiting for Thomas
Book venue blocked by budget approval
```

Recognised signals: `waiting for`, `blocked by`, `depends on`.

---

## Using the HTML dashboard

Open `todos.html` in your browser after the first task is added.

### Connecting to GitHub

The first time you open the page, click **"Set GitHub token"** in the banner at the top and paste a GitHub Personal Access Token with repo write access. The page remembers the token — future visits reconnect automatically.

> The page is **read-only until connected**. Once connected, all changes are written back to `todos.json` on GitHub in real time.

### The board

- A single sorted list of tasks
- **Urgent** items appear first, then by **deadline** (closest first), then by creation date
- A **"Due Today"** strip at the top of the page highlights everything due today
- **Overdue** tasks show a red left border and an OVERDUE tag

### Interacting with tasks

| Action | How |
|---|---|
| **Mark as done** | Click the circular ✓ button (top-right of card) |
| **Restore a done task** | Click ↩ Restore in the "Recently done" section |
| **Delete permanently** | Click `Delete` then confirm |
| **Edit the title** | Double-click the title text, edit, press Enter |
| **Toggle urgent flag** | Open the task detail and click the urgent toggle (long-press on mobile) |
| **Remove a @mention chip** | Click the × inside the chip |
| **Edit the deadline** | Click the deadline badge on the card |

The last **10 completed tasks** are shown in a "Recently done" section at the bottom.

### Command bar

A sticky input bar at the bottom of the page lets you add and remove tasks without switching to Cursor:

```
Fix the crash
! Fix the crash
Write spec @Marie by friday
remove velocity audit
```

Click the **🎤 mic button** to dictate a task by voice (Chrome/Safari). Speak naturally — the transcript appears in the input field and you press Send or Enter to confirm.

The page **auto-refreshes every 10 minutes** to pick up tasks added via Cursor chat.

---

## Removing a task via Cursor chat

```
remove [partial title]
```

Example:

```
remove velocity audit
```

The agent finds the best matching active task by keyword and removes it.

---

## File reference

| File | Purpose |
|---|---|
| `~/.cursor/skills/todo-agent/SKILL.md` | Agent instructions (copy this) |
| `~/.cursor/skills/todo-agent/generate_html.py` | HTML generator (copy this) |
| `~/Documents/Cursor/todo-agent/todos.json` | Your task data (created by you) |
| `~/Documents/Cursor/todo-agent/todos.html` | Generated dashboard (opened in browser) |
