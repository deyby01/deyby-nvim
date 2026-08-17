# 🔀 Git and GitHub

> The whole Git workflow without leaving the editor: status, hunks, diffs,
> conflicts, PRs and reviews.

**Plugins:** `vim-fugitive` · `gitsigns.nvim` · `diffview.nvim` · `git-conflict.nvim` · `octo.nvim`
**Config file:** [`lua/plugins/git.lua`](../lua/plugins/git.lua)

---

## 📋 Contents

- [Which tool for what](#which-tool-for-what)
- [Fugitive — status and commits](#fugitive--status-and-commits)
- [GitSigns — hunks and blame](#gitsigns--hunks-and-blame)
- [Diffview — branch diffs and history](#diffview--branch-diffs-and-history)
- [git-conflict — merge conflicts](#git-conflict--merge-conflicts)
- [Octo — GitHub PRs and issues](#octo--github-prs-and-issues)
- [Complete flows](#complete-flows)

---

## Which tool for what

The five plugins overlap a little. Quick guide:

| I want to... | Tool | Shortcut |
|--------------|------|----------|
| See what files I changed and commit | **Fugitive** | `Space+gs` |
| See/stage the change on the line I'm on | **GitSigns** | `Space+hp` `Space+hs` |
| Compare my branch against the base branch | **Diffview** | `Space+gd` |
| See a file's history | **Diffview** | `Space+gh` |
| Resolve a merge conflict | **git-conflict** | `Space+co` `Space+ct` |
| Create or review a PR | **Octo** | `Space+opc` `Space+opr` |

> ℹ️ The Diffview shortcuts compare against the branch set in
> [`lua/config/user.lua`](../lua/config/user.lua) as `git_base_branch`
> (`development` by default — change it to `main` or whatever your team uses).

---

## Fugitive — status and commits

Git's "control panel". `Space+gs` opens the interactive status.

### Shortcuts

| Shortcut | Action |
|----------|--------|
| `Space+gs` | **Git status** (interactive panel) |
| `Space+gu` | Discard changes in the **current file** |
| `Space+gU` | Discard **ALL** changes ⚠️ |

### Inside the status panel

| Key | Action |
|-----|--------|
| `s` | **Stage** the file under the cursor |
| `u` | **Unstage** the file |
| `-` | Toggle stage/unstage |
| `=` | Show the file's inline **diff** |
| `cc` | Create a **commit** (opens a message buffer) |
| `ca` | **Amend** the last commit |
| `X` | Discard the file's changes ⚠️ |
| `dd` | Open the diff in a split |
| `dv` | Open the diff in a vertical split |
| `q` | Close the panel |

> 💡 After `cc`, write the message and save with `Ctrl+s`. To cancel the
> commit, close the buffer without saving (`:q!`).

### Commands

| Command | Action |
|---------|--------|
| `:Git` | Same as `Space+gs` |
| `:Git add %` | Stage the current file |
| `:Git commit -m "message"` | Commit directly |
| `:Git push origin my-branch` | Push |
| `:Git pull origin main` | Pull |
| `:Git checkout -b feature/thing` | Create a branch |
| `:Git log --oneline` | History |
| `:Git blame` | Who wrote each line |
| `:Git restore file` | Discard changes |

---

## GitSigns — hunks and blame

Shows in the left gutter which lines you added (`│`), changed (`│`) or deleted
(`_`), and lets you act hunk by hunk.

### Shortcuts

| Shortcut | Action |
|----------|--------|
| `]c` | Go to the **next** change |
| `[c` | Go to the **previous** change |
| `Space+hp` | **Preview** the hunk (diff in a popup) |
| `Space+hs` | **Stage** just this hunk |
| `Space+hr` | **Reset** just this hunk |
| `Space+hb` | **Blame** the current line (full) |
| `Space+hd` | **Diff** the whole file |
| `Space+tb` | Toggle inline blame on every line |

> 💡 **Inline blame is on by default**: the end of each line shows in grey who
> wrote it and when. `Space+tb` turns it off if it gets noisy.

### Why stage by hunks

If you touched three unrelated things in one file, you can make three clean
commits instead of one mixed bag:

```
]c              → first change
Space+hp        → check it's what you want
Space+hs        → stage only that one
]c              → next change... (or leave it for another commit)
Space+gs → cc   → commit only what's staged
```

---

## Diffview — branch diffs and history

A full, GitHub-style diff view for comparing branches and browsing history.

### Shortcuts

| Shortcut | Action |
|----------|--------|
| `Space+gd` | Diff against the local **base branch** |
| `Space+gD` | Diff against **`origin/<base branch>`** |
| `Space+gw` | Diff the **working tree** (uncommitted changes) |
| `Space+gh` | **History** of the current file |
| `Space+gf` | All **commits** from the base branch to `HEAD` |
| `Space+gq` | **Close** Diffview |

### Inside Diffview

| Key | Action |
|-----|--------|
| `Tab` | Next file in the diff |
| `Shift+Tab` | Previous file |
| `j` / `k` + `Enter` | Navigate and open from the file panel |
| `-` | Stage/unstage the file |
| `X` | Restore the file |
| `g?` | Help with every shortcut |

### Commands

```vim
:DiffviewOpen                       " working tree
:DiffviewOpen main                  " against main
:DiffviewOpen HEAD~3                " against 3 commits back
:DiffviewOpen feature-a..feature-b  " between two branches
:DiffviewFileHistory %              " current file history
:DiffviewFileHistory                " whole repo history
:DiffviewClose
```

---

## git-conflict — merge conflicts

When a merge or rebase conflicts, it highlights the three sides in color and
lets you pick with a shortcut.

### Shortcuts

| Shortcut | Action |
|----------|--------|
| `Space+co` | Choose **ours** (current / HEAD) |
| `Space+ct` | Choose **theirs** (incoming) |
| `Space+cb` | Choose **both** |
| `Space+cn` | **Next** conflict |
| `Space+cp` | **Previous** conflict |
| `Space+cl` | **List** every conflict (quickfix) |

### Workflow

```bash
# 1. The merge fails
:Git merge main
# → CONFLICT

# 2. See every conflict in the repo
Space+cl

# 3. For each one
Space+cn        → jump to the next
Space+co        → keep mine
Space+ct        → keep the other branch's
Space+cb        → keep both and edit by hand

# 4. Check no markers are left
Space+cl        → should be empty

# 5. Commit the resolution
Space+gs → s → cc
```

> 💡 **"Ours" vs "theirs" is inverted during a rebase**: there, "ours" is the
> base branch and "theirs" is *your* commits. When in doubt, read the content,
> not the label.

---

## Octo — GitHub PRs and issues

### Requirement

```bash
sudo apt install gh -y
gh auth login
```

### Shortcuts

| Shortcut | Action |
|----------|--------|
| `Space+opr` | **List** pull requests |
| `Space+opc` | **Create** a pull request |
| `Space+ois` | **List** issues |
| `Space+oic` | **Create** an issue |
| `Space+or` | **Start** a code review |

### Commands

```vim
:Octo pr list
:Octo pr create
:Octo pr checkout        " switch to the PR's branch
:Octo pr merge
:Octo issue list
:Octo issue create
:Octo review start
:Octo review submit      " send the review
:Octo review discard
:Octo comment add        " comment on the current line
```

### Inside a PR or issue

| Key | Action |
|-----|--------|
| `<localleader>ca` | Add a comment |
| `<localleader>ic` | Close the issue |
| `<localleader>po` | Open the PR in the browser |
| `<localleader>rp` | Request a review |

> `localleader` is also `Space` in this configuration.

---

## Complete flows

### Starting a task

```bash
:Git checkout main
:Git pull origin main
:Git checkout -b feature/task-name
```

### While developing

```bash
]c / [c            # walk through my changes
Space+hp           # review each hunk
Space+gw           # full working-tree diff
Space+gs           # overall status
```

### Commit and push

```bash
Space+gs           # open status
s                  # stage files (or Space+hs by hunk)
cc                 # commit → write message → Ctrl+s
:Git push origin feature/task-name
```

### Opening the PR

```bash
Space+opc          # from Neovim

# or from the terminal
gh pr create --base main --title "..." --body "..."
```

### Reviewing an assigned PR

```bash
Space+opr          # list PRs
# Enter on the one assigned to you
Space+or           # start the review
Space+gD           # see the diff against origin/<base branch>
# comment with :Octo comment add
:Octo review submit
```

### Before requesting a merge — self review

```bash
Space+gf           # every commit of mine since the base branch
Space+gd           # full diff against the base branch
```

Reviewing your own diff before asking for review saves rounds of comments.

---

[⬅️ Back to the README](../README.md) · [tmux ➡️](tmux.md)
