# 🖥️ tmux — Sessions and Multiplexing

> Keep several projects open, survive closing the terminal, and move between
> tmux panes and Neovim splits with the same keys.

**Integration plugin:** `vim-tmux-navigator`
**Neovim config file:** [`lua/plugins/terminal.lua`](../lua/plugins/terminal.lua)

---

## 📋 Contents

- [Why tmux](#why-tmux)
- [Install and configure](#install-and-configure)
- [Session commands](#session-commands)
- [tmux shortcuts](#tmux-shortcuts)
- [Unified navigation with Neovim](#unified-navigation-with-neovim)
- [Integrated terminal vs tmux](#integrated-terminal-vs-tmux)
- [Multi-project workflow](#multi-project-workflow)
- [Common problems](#common-problems)

---

## Why tmux

This Neovim setup already has `auto-session` (restores your session when you
return to a folder) and `toggleterm` (integrated terminal). tmux solves
something different:

| Need | Solution |
|------|----------|
| The `runserver` keeps running after I close the terminal | ✅ tmux |
| Work on 3 projects at once and hop between them | ✅ tmux |
| Reconnect over SSH and find everything as I left it | ✅ tmux |
| Get my open files back when I return to a project | ✅ auto-session |
| A quick terminal for a one-off command | ✅ toggleterm (`Ctrl+´`) |

---

## Install and configure

```bash
sudo apt install tmux -y
```

Create `~/.tmux.conf`:

```bash
nvim ~/.tmux.conf
```

> ⚠️ If `~/.tmux.conf` already exists **as a directory** (an accidental
> `mkdir`), tmux will silently ignore your config. Check with
> `ls -ld ~/.tmux.conf` and remove it with `rmdir ~/.tmux.conf` first.

Recommended configuration (compatible with this Neovim setup):

```bash
# Ctrl+a prefix instead of Ctrl+b (easier to reach)
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# Split with | and -
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"
unbind '"'
unbind %

# New windows open in the current directory
bind c new-window -c "#{pane_current_path}"

# Move between panes with Alt+arrows (no prefix)
bind -n M-Left  select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up    select-pane -U
bind -n M-Down  select-pane -D

# Reload the configuration
bind r source-file ~/.tmux.conf \; display "Config reloaded!"

# Mouse support
set -g mouse on

# Number from 1
set -g base-index 1
setw -g pane-base-index 1

# Colors (required for the theme to look right)
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",xterm-256color:Tc"

# Bigger scrollback
set -g history-limit 10000

# Don't rename windows automatically
set-option -g allow-rename off
```

Apply without restarting:

```bash
tmux source-file ~/.tmux.conf
```

> 💡 **`terminal-overrides` with `Tc`** enables true color. Without that line
> your Neovim theme looks washed out inside tmux.

### vim-tmux-navigator integration

For `Ctrl+h/j/k/l` to work **across** tmux and Neovim, add this to `~/.tmux.conf`:

```bash
# Smart pane switching with Vim awareness
is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'
```

Without it, `Ctrl+h/j/k/l` only move between Neovim splits.

---

## Session commands

From a normal terminal (not inside tmux):

| Command | Action |
|---------|--------|
| `tmux new -s name` | Create a named session |
| `tmux ls` | List active sessions |
| `tmux attach -t name` | Reconnect to a session |
| `tmux attach` | Reconnect to the last one |
| `tmux kill-session -t name` | Close one session |
| `tmux kill-server` | Close everything ⚠️ |

---

## tmux shortcuts

**Prefix:** `Ctrl+a` (press it, release, then the key)

### Sessions

| Shortcut | Action |
|----------|--------|
| `Ctrl+a d` | **Detach** — leave, everything keeps running |
| `Ctrl+a s` | Interactive **session** list |
| `Ctrl+a $` | Rename the session |

### Windows (like tabs)

| Shortcut | Action |
|----------|--------|
| `Ctrl+a c` | **Create** a window |
| `Ctrl+a n` | **Next** window |
| `Ctrl+a p` | **Previous** window |
| `Ctrl+a {number}` | Go to window N |
| `Ctrl+a w` | Window list |
| `Ctrl+a ,` | Rename the window |
| `Ctrl+a &` | Close the window |

### Panes (splits)

| Shortcut | Action |
|----------|--------|
| `Ctrl+a \|` | Split **vertically** |
| `Ctrl+a -` | Split **horizontally** |
| `Ctrl+a x` | Close the current pane |
| `Ctrl+a z` | **Zoom** — fullscreen toggle |
| `Ctrl+a {` / `}` | Move the pane around |
| `Alt+↑↓←→` | Resize the pane |
| `Ctrl+h/j/k/l` | Move between panes (no prefix, see [integration](#unified-navigation-with-neovim)) |

### Copying text

| Shortcut | Action |
|----------|--------|
| `Ctrl+a [` | Enter copy mode |
| `Space` | Start the selection |
| `Enter` | Copy and exit |
| `Ctrl+a ]` | Paste |

> 💡 `Ctrl+a z` (zoom) is one of the most useful: temporary fullscreen without
> having to close the other panes.

---

## Unified navigation with Neovim

With `vim-tmux-navigator` plus the `~/.tmux.conf` block, the same four keys
work no matter where you are:

| Shortcut | Action |
|----------|--------|
| `Ctrl+h` | Pane/split to the **left** |
| `Ctrl+j` | Pane/split **below** |
| `Ctrl+k` | Pane/split **above** |
| `Ctrl+l` | Pane/split to the **right** |

**The plugin detects the edge:** if you're in Neovim's leftmost split and press
`Ctrl+h`, you jump to the tmux pane on the left. No mental mode switch.

### It also works in the integrated terminal

The same keys are mapped in Neovim's terminal mode, so from `Ctrl+´` you can go
back to your code with `Ctrl+k` without leaving terminal mode.

---

## Integrated terminal vs tmux

Both coexist. When to use which:

| Situation | Use |
|-----------|-----|
| A quick command (`git log`, `ls`, `pip install`) | `Ctrl+´` (toggleterm) |
| Inspecting Docker containers | `Space+ld` (floating LazyDocker) |
| HTML/CSS preview with live reload | `Space+lv` (Live Server) |
| A `runserver` that must survive closing nvim | A tmux pane |
| Continuously tailing Docker logs | A tmux pane |
| Switching between whole projects | tmux sessions |

### Integrated terminal shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl+´` | Toggle horizontal terminal |
| `Space+tt` | Same (alternative) |
| `Space+ld` | LazyDocker in a floating window |
| `Space+lv` | Live Server in a floating window |
| `Esc` | Leave terminal mode for normal mode |
| `i` / `a` | Back to terminal mode |

---

## Multi-project workflow

### Monday — start the frontend

```bash
tmux new -s frontend
cd ~/projects/web-app
nvim

# Split for the dev server
Ctrl+a -            # pane below
npm run dev

Ctrl+k              # back to Neovim (vim-tmux-navigator)
```

### Tuesday — the backend needs work, don't lose the frontend

```bash
Ctrl+a d                    # detach: the frontend keeps running

tmux new -s backend
cd ~/projects/api
source .venv/bin/activate
nvim

Ctrl+a -
python manage.py runserver
```

### Hopping between projects

```bash
Ctrl+a s            # session list → arrows → Enter
```

### Friday — what do I have open?

```bash
tmux ls
# frontend: 2 windows (created Mon ...)
# backend:  2 windows (created Tue ...)
```

### Next Monday — pick up where you left off

```bash
tmux attach -t frontend
# Everything intact: Neovim, open files, the dev server still running
```

### Recommended per-project layout

```
┌─────────────────────────────────┐
│                                 │
│           Neovim                │  ← Ctrl+a z to zoom
│                                 │
├─────────────────┬───────────────┤
│   runserver     │   terminal    │
│   (logs)        │   (commands)  │
└─────────────────┴───────────────┘
```

Built with: `Ctrl+a -` (split below) then `Ctrl+a |` (split that pane).

---

## Common problems

### Colors look wrong inside tmux

The `terminal-overrides` line is missing. Check:

```bash
echo $TERM          # should be screen-256color inside tmux
tmux info | grep Tc
```

Add to `~/.tmux.conf`:

```bash
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",xterm-256color:Tc"
```

### `Ctrl+h/j/k/l` doesn't cross between tmux and Neovim

The `is_vim` block is missing from `~/.tmux.conf` (see
[integration](#vim-tmux-navigator-integration)).

### The `Ctrl+a` prefix clashes with bash's "go to start of line"

That's the trade-off of using `Ctrl+a`. Options: press `Ctrl+a a` to send a
literal `Ctrl+a` (already mapped via `send-prefix`), or switch the prefix to
`Ctrl+Space`:

```bash
set-option -g prefix C-Space
```

---

[⬅️ Back to the README](../README.md) · [Plugins ➡️](plugins.md)
