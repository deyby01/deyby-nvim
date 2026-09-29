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
sudo apt install tmux -y           # Debian / Ubuntu
sudo pacman -S tmux                # Arch / CachyOS
```

> ⚠️ Installing the package gives you the binary and **nothing else** — tmux
> ships with no configuration of its own.

**The config is in this repo**, at [`tmux.conf`](../tmux.conf). `setup.sh`
links it to `~/.tmux.conf`, so on a new machine there is nothing to write by
hand:

```bash
~/.config/nvim/setup.sh
```

Verify it took:

```bash
ls -l ~/.tmux.conf        # -> ~/.config/nvim/tmux.conf
tmux show -gv prefix      # -> C-a
```

Edit [`tmux.conf`](../tmux.conf) in the repo, never `~/.tmux.conf` — it is a
symlink to the same file, but editing through the repo is what keeps the change
committed. Reload a running tmux with `Ctrl+a` then `r`.

> ⚠️ If `~/.tmux.conf` already exists **as a directory** (an accidental
> `mkdir`), tmux silently ignores your config and `setup.sh` cannot link over
> it. Check with `ls -ld ~/.tmux.conf` and remove it with `rmdir ~/.tmux.conf`.

<details>
<summary>The full configuration, for reference</summary>

This is what `tmux.conf` contains. You do not need to type it — `setup.sh`
links the file — but it is here so the reasoning stays with the docs.

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

# Colors (required for the theme to look right).
# tmux-256color, not screen-256color: the latter has no italics, and the
# nordic theme sets italic_comments. Check it exists with
# `infocmp tmux-256color`; fall back to screen-256color if it does not.
set -g default-terminal "tmux-256color"
set -ga terminal-overrides ",*256col*:Tc"

# Neovim wants a low escape-time; the default 500ms makes Esc feel laggy
set -sg escape-time 10

# Tell Neovim when the terminal regains focus, so the config's :checktime
# autocmd fires and files edited outside nvim reload
set -g focus-events on

# Renumber windows when one is closed, so there are no gaps
set -g renumber-windows on

# Bigger scrollback
set -g history-limit 10000

# Don't rename windows automatically
set-option -g allow-rename off
```

</details>

Apply changes to a running tmux:

```bash
tmux source-file ~/.tmux.conf     # or Ctrl+a then r
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

# Same keys from inside tmux's copy-mode
bind-key -T copy-mode-vi 'C-h' select-pane -L
bind-key -T copy-mode-vi 'C-j' select-pane -D
bind-key -T copy-mode-vi 'C-k' select-pane -U
bind-key -T copy-mode-vi 'C-l' select-pane -R
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
echo $TERM          # should be tmux-256color inside tmux
tmux info | grep Tc
```

Add to `~/.tmux.conf`:

```bash
set -g default-terminal "tmux-256color"
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
