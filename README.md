# Maxime's Marvelous Todolist

**[https://lesdouillets.github.io/maxime_todo/todos.html](https://lesdouillets.github.io/maxime_todo/todos.html)**

A personal Eisenhower-matrix task manager that lives inside [Cursor](https://cursor.sh). You talk to it in the Cursor chat, it organises your tasks into a beautiful interactive HTML dashboard you open in your browser — no server, no accounts, no dependencies.

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

> **Browser requirement:** Chrome 86+ or Safari 15.2+ — needed for the File System Access API that lets the page write back to `todos.json`.

---

## Adding tasks

Type directly in the Cursor chat using a **quadrant prefix** followed by your task description.

### Quadrant prefixes (Eisenhower matrix)

| Prefix | Also accepted as | Quadrant | Colour | Meaning |
|--------|-----------------|----------|--------|---------|
| `IU` | `important urgent` | **Do First** | Red | High value, needs doing today |
| `IN` | `important not urgent` | **Schedule** | Blue | High value, can be planned |
| `NU` | `not important urgent` | **Delegate** | Orange | Low value but time-sensitive |
| `NN` | `not important not urgent` | **Eliminate** | Grey | Low value, low urgency |

The order of words doesn't matter — `urgent important` works the same as `important urgent`.

### Basic examples

```
IU Fix the production bug
IN Write the Q2 roadmap
NU Reply to the meeting invite
NN Clean up old Slack channels
```

### With a deadline

The deadline is parsed automatically and stripped from the title:

```
IN Prepare strategy workshop by friday
IN Submit report before 17/04
IU Fix onboarding bug in 3 days
NN Archive old projects within a week
```

**All recognised deadline patterns:**

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

> **IU items without a deadline automatically get a deadline of tomorrow.**

### With @mentions

Tag people involved in the task using `@Name`. Their names appear as coloured chips under the task title in the dashboard, and are stripped from the title text:

```
IN Review spec @Marie @Antoine by friday
IU Fix login bug @Backend
```

### With a dependency

Signal that the task is blocked by someone using natural language. A chip is shown under the title:

```
IN Write release notes waiting for Thomas
NU Book venue blocked by budget approval
```

Recognised signals: `waiting for`, `blocked by`, `depends on`.

---

## Using the HTML dashboard

Open `todos.html` in your browser after the first task is added.

### Connecting to todos.json

The first time you open the page, click **"Connect now"** in the banner at the top and select your `todos.json` file. The page remembers this connection — future visits reconnect automatically (or with a single click if browser permission needs refreshing).

> The page is **read-only until connected**. Once connected, all changes are written to `todos.json` in real time.

### The board

- Tasks are organised into the 4 quadrants in a 2×2 grid
- Within each quadrant, tasks are sorted by **deadline** (closest first), then by creation date for tasks without a deadline
- A **"Due Today"** strip at the top of the page highlights everything due today, colour-coded by quadrant
- **Overdue** tasks show a red left border and an OVERDUE tag

### Interacting with tasks

| Action | How |
|---|---|
| **Move to another quadrant** | Drag & drop the card |
| **Mark as done** | Click the circular ✓ button (top-right of card) |
| **Restore a done task** | Click ↩ Restore in the "Recently done" section |
| **Delete permanently** | Click the × button (top-right of card) |
| **Edit the title** | Double-click the title text, edit, press Enter |
| **Remove a @mention chip** | Click the × inside the chip |
| **Edit the deadline** | Click the deadline badge on the card |

The last **10 completed tasks** are shown in a "Recently done" section at the bottom.

### Command bar

A sticky input bar at the bottom of the page lets you add and remove tasks without switching to Cursor:

```
IU Fix the crash
important urgent Fix the crash
IN Write spec @Marie by friday
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
