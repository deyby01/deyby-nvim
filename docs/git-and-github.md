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
- [Resolving merge conflicts](#resolving-merge-conflicts)
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
| Resolve a merge conflict (several files) | **Diffview merge tool** | `Space+gw` |
| Resolve a merge conflict (one file, in place) | **git-conflict** | `Space+cn` then `Space+co` |
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

> 💡 During a merge conflict, `Space+gw` opens Diffview in **merge mode**
> instead — a four-pane view built for resolving them. See
> [Resolving merge conflicts](#resolving-merge-conflicts).

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

## Resolving merge conflicts

There are **two tools** for this, and picking the right one is most of the
battle:

| Situation | Tool | Open with |
|-----------|------|-----------|
| One or two conflicts, in a file you already have open | **git-conflict** | nothing to open — it is already highlighting them |
| Several files, or you want to see both sides side by side | **Diffview merge tool** | `Space+gw` |

If you are not sure, use Diffview. It is the one that shows you everything.

---

### Option A — Diffview merge tool (the 4-pane view)

The equivalent of PyCharm's conflict window. Run it **while the merge is in
progress**, after git has told you `CONFLICT`:

```
Space+gw
```

```
┌───────────┬────────────┬─────────────┬───────────┐
│  Files    │    OURS    │   RESULT    │  THEIRS   │
│   with    │  the base  │  what you   │ the branch│
│ conflicts │   branch   │ are building│  coming in│
└───────────┴────────────┴─────────────┴───────────┘
```

The middle pane is the file as it will end up. Accepting a side moves that
text into it — exactly the behaviour you want: you work through the conflicts
and watch the final version assemble itself.

#### Keys inside

| Key | Action |
|-----|--------|
| `]x` / `[x` | Next / previous conflict |
| `Space+co` | Take **OURS** for this conflict |
| `Space+ct` | Take **THEIRS** for this conflict |
| `Space+ca` | Take **both**, in order |
| `dx` | Take **neither** — delete the conflict region |
| `Space+cO` / `Space+cT` | Take one side for the **whole file** (capitals) |
| `Tab` / `Shift+Tab` | Next / previous **file** |
| `Space+e` | Jump back to the file panel |
| `Space+b` | Hide/show the file panel |
| `g?` | Help with every key |

#### The full loop

```
Space+gw          # open the merge tool
]x                # go to the first conflict
Space+co          # accept a side — it lands in the RESULT pane
]x                # next conflict in this file
                  # ...until the file is done
:w                # save it
Space+e           # focus the file panel
s                 # mark the file resolved  ← the step people miss
Tab               # move to the next file
```

> ⚠️ **Saving is not the same as resolving.** `:w` writes the file, but git
> still lists it as conflicted (`UU` in `git status`) until it is staged. That
> is what `s` does in the file panel — it is `git add` under another name.
> `S` stages every file at once.

When the file panel is empty, commit as usual with `Space+gs` → `cc`.

---

### Option B — git-conflict (in the file itself)

No separate window: the conflict markers in the buffer are highlighted and you
pick a side with the cursor on them.

| Shortcut | Action |
|----------|--------|
| `Space+cn` / `Space+cp` | Next / previous conflict |
| `Space+co` | Keep **ours** (current / HEAD) |
| `Space+ct` | Keep **theirs** (incoming) |
| `Space+cb` | Keep **both** |
| `Space+cl` | List every conflict in the project (quickfix) |

> ⚠️ **The cursor has to be inside the conflict.** This is the one that wastes
> your afternoon: with the cursor anywhere else, `Space+co` does **nothing at
> all** — no error, no message, no beep. It looks like the keymap is broken.
>
> Always press `Space+cn` first. That is what puts the cursor on a conflict;
> after it, the choose keys work.

```
Space+cl          # see every conflict in the project
Space+cn          # jump to one          ← never skip this
Space+co          # now it resolves
Space+cn          # next
                  # ...
Space+cl          # empty = nothing left
:w                # save
```

Staging still happens separately — `Space+gs`, then `s` on the file.

---

### Ours and theirs: read, don't trust the label

During a **merge**, the names mean what you expect: "ours" is your current
branch, "theirs" is what is coming in.

During a **rebase they are swapped**, because git replays your commits on top
of the other branch: "ours" becomes the base branch and "theirs" becomes *your*
own work. The labels are technically right and completely misleading.

When in doubt, read the actual content of each side rather than the label. The
Diffview merge tool helps here — the winbar names the real source of each pane.

---

### If something goes wrong

| Symptom | Cause |
|---------|-------|
| `Space+co` does nothing | Cursor is not inside a conflict. Press `Space+cn` first. |
| File still shows as conflicted after saving | It was saved but not staged. `s` in the Diffview file panel, or `Space+gs` then `s`. |
| `Space+gw` opens a normal diff, not the 4 panes | The merge is not in progress. The merge tool only exists while git reports a conflict. |
| You want out | `git merge --abort` (or `git rebase --abort`) returns everything to how it was. |

Nothing here is destructive until you commit. `git merge --abort` is always
available while the merge is unfinished.

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
