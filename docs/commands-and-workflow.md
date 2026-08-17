# ⌨️ Command Reference

> Every shortcut and command, **grouped by the tool that provides it**.
> Each section says which plugin it is, when it activates, and what each
> command does.

For the day-to-day workflow, see **[daily-routine.md](daily-routine.md)**.

---

## 📖 How to read this guide

| Notation | Means |
|----------|-------|
| `Space` | The **leader** key (spacebar) |
| `Space+ff` | Press `Space`, release, then `f`, `f` |
| `Ctrl+s` | Hold `Ctrl` and press `s` |
| `:command` | An Ex command: type it in normal mode and press `Enter` |
| `gd` | Two keys in sequence, in normal mode |

> 💡 **If you forget a shortcut:** press `Space` and wait — which-key shows the
> options. Or use `Ctrl+p` (Legendary) to search any command by name.

---

## 📋 Index

**Basics**
- [Vim core — modes](#vim-core--modes)
- [Vim core — navigation](#vim-core--navigation)
- [Vim core — editing](#vim-core--editing)
- [Vim core — buffers, windows and tabs](#vim-core--buffers-windows-and-tabs)
- [Vim core — registers, macros and marks](#vim-core--registers-macros-and-marks)
- [This config's own keymaps](#this-configs-own-keymaps)

**Project search and navigation**
- [Telescope](#telescope--fuzzy-finder) · [NvimTree](#nvimtree--file-explorer) · [Harpoon](#harpoon--bookmarks) · [Flash](#flash--fast-motion) · [Dropbar](#dropbar--breadcrumbs) · [Spectre](#spectre--project-wide-search-and-replace)

**Code**
- [LSP](#lsp--code-intelligence) · [nvim-cmp](#nvim-cmp--completion) · [Copilot](#copilot--ai-suggestions) · [Snippets](#snippets) · [conform](#conform--formatting) · [Trouble](#trouble--diagnostics-panel) · [Treesitter](#treesitter) · [Comment](#commentnvim--commenting) · [Surround](#nvim-surround--wrapping) · [autopairs](#nvim-autopairs--auto-closing) · [TODO comments](#todo-comments)

**Git**
- [Fugitive](#fugitive--status-and-commits) · [GitSigns](#gitsigns--hunks-and-blame) · [Diffview](#diffview--diffs-and-history) · [git-conflict](#git-conflict--conflicts) · [Octo](#octo--github)

**Environment**
- [ToggleTerm](#toggleterm--terminal) · [Docker](#docker--lazydocker) · [HTML — Live Server](#html--live-server) · [tmux](#tmux) · [auto-session](#auto-session--sessions) · [Legendary](#legendary--command-palette) · [Dashboard](#dashboard) · [which-key](#which-key)

**Running things**
- [nvim-dap](#nvim-dap--debugger) · [Neotest](#neotest--tests) · [Markdown Preview](#markdown-preview) · [Colorizer](#colorizer) · [Extras](#extras)

**Reference**
- [Management commands](#management-commands) · [Alphabetical cheatsheet](#alphabetical-cheatsheet)

---

# Basics

## Vim core — modes

**Tool:** Vim/Neovim · Always active

| Mode | How to enter | How to leave |
|------|--------------|--------------|
| **Normal** | `Esc` · `jk` · `kj` | — (the default mode) |
| **Insert** | `i` `a` `o` `I` `A` `O` | `Esc` · `jk` · `kj` |
| **Visual** | `v` | `Esc` |
| **Visual line** | `V` | `Esc` |
| **Visual block** | `Ctrl+v` | `Esc` |
| **Command** | `:` | `Esc` · `Ctrl+c` |
| **Terminal** | `i` inside a terminal | `Esc` |

### Entering INSERT mode

| Shortcut | Action |
|----------|--------|
| `i` / `a` | Insert **before** / **after** the cursor |
| `I` / `A` | Insert at the **start** / **end** of the line |
| `o` / `O` | New line **below** / **above**, then insert |
| `S` | Delete the line and insert |
| `C` | Delete to end of line and insert |
| `ciw` | Change the whole word under the cursor |

> ⚠️ **`s` is remapped to Flash** in this config. For the original `s` behaviour
> (delete a character and insert), use `cl`.

---

## Vim core — navigation

**Tool:** Vim/Neovim · Always active

### Within the file

| Shortcut | Action |
|----------|--------|
| `h` `j` `k` `l` | Left, down, up, right |
| `w` / `b` | Start of the next / previous word |
| `e` | End of the word |
| `W` `B` `E` | Same, ignoring punctuation |
| `0` / `^` / `$` | Line start / first non-blank / end |
| `gg` / `G` | Start / end of the file |
| `{number}G` | Go to line N (e.g. `50G`) |
| `Ctrl+d` / `Ctrl+u` | Half page down / up |
| `Ctrl+f` / `Ctrl+b` | Full page down / up |
| `%` | Jump to the matching bracket |
| `{` / `}` | Previous / next paragraph |
| `f{c}` / `F{c}` | Jump to the next / previous `{c}` on the line |
| `t{c}` / `T{c}` | Same, but stop just before |
| `;` / `,` | Repeat the last `f`/`t` forwards / backwards |
| `` `` `` | Back to the previous cursor position |

### Search

| Shortcut | Action |
|----------|--------|
| `/text` / `?text` | Search forwards / backwards |
| `n` / `N` | Next / previous match |
| `*` / `#` | Search the word under the cursor forwards / backwards |
| `/\<word\>` | Search the **exact** word |
| `/text\c` | Search ignoring case |

> This config uses `ignorecase` + `smartcase`: lowercase searches ignore case,
> but typing a capital makes the search case-sensitive.

---

## Vim core — editing

**Tool:** Vim/Neovim · Always active

### Copy, cut, paste

| Shortcut | Action |
|----------|--------|
| `yy` | Copy the line |
| `y{motion}` | Copy by motion (`yw`, `y$`, `yi(`) |
| `dd` | Cut the line |
| `d{motion}` | Cut by motion |
| `D` / `C` | Cut / change to end of line |
| `x` / `X` | Delete the character under / before the cursor |
| `p` / `P` | Paste after / before the cursor |
| `3yy` / `3dd` | Copy / cut 3 lines |
| `u` / `Ctrl+r` | Undo / redo |
| `.` | **Repeat the last action** |

> The clipboard is shared with the system (`clipboard=unnamedplus`): what you
> copy in Neovim pastes into the browser and vice versa.

### Indent and transform

| Shortcut | Action |
|----------|--------|
| `>>` / `<<` | Indent the line right / left |
| `>` / `<` | Indent the selection (visual mode) |
| `==` | Auto-indent the line |
| `gg=G` | Auto-indent the whole file |
| `J` / `gJ` | Join with the next line (with / without a space) |
| `~` | Toggle the character's case |
| `gu{motion}` / `gU{motion}` | To lowercase / UPPERCASE |

### Replace

| Command | Action |
|---------|--------|
| `:%s/old/new/g` | Replace throughout the file |
| `:%s/old/new/gc` | Same, with confirmation (`y`/`n`/`a`/`q`/`l`) |
| `:s/old/new/g` | Current line only |
| `:'<,'>s/old/new/g` | Visual selection only |
| `:%s/old/new/gi` | Ignoring case |

To replace across **the whole project**, use [Spectre](#spectre--project-wide-search-and-replace).

### Block editing (multiple lines)

```
Ctrl+v          → visual block mode
j / k           → select lines
I               → insert at the start
{text}          → type
Esc             → applies to ALL selected lines
```

To append at the end: `Ctrl+v` → select → `$` → `A` → text → `Esc`.

---

## Vim core — buffers, windows and tabs

**Tool:** Vim/Neovim · Always active

### Save and quit

| Shortcut / Command | Action |
|--------------------|--------|
| `Ctrl+s` | **Save** (this config's shortcut) |
| `:w` | Save |
| `:wq` · `ZZ` | Save and quit |
| `Ctrl+q` | **Quit without saving** (this config's shortcut) |
| `:q!` · `ZQ` | Quit without saving |
| `:qa` / `:qa!` | Close everything / without saving |
| `:wqa` | Save everything and close |

### Buffers

| Command | Action |
|---------|--------|
| `:e file` | Open a file |
| `:bn` / `:bp` | Next / previous buffer |
| `:bd` | Close the current buffer |
| `:ls` | List buffers |
| `:b name` | Go to a buffer by name (Tab completes) |

Faster: `Space+fb` ([Telescope](#telescope--fuzzy-finder)).

### Windows (splits)

| Shortcut | Action |
|----------|--------|
| `Ctrl+h` `Ctrl+j` `Ctrl+k` `Ctrl+l` | Move between splits (and tmux panes) |
| `Ctrl+w w` | Cycle |
| `Ctrl+w =` | Equalize sizes |
| `Ctrl+w _` / `Ctrl+w \|` | Maximize height / width |
| `:resize +5` | Change height |
| `:vertical resize +10` | Change width |

See also the `Space+w*` shortcuts in [this config's keymaps](#this-configs-own-keymaps).

### Tabs

| Command | Action |
|---------|--------|
| `:tabnew` | New tab |
| `gt` / `gT` | Next / previous tab |
| `:tabclose` | Close the tab |

---

## Vim core — registers, macros and marks

**Tool:** Vim/Neovim · Always active

### Macros

```
qa              → start recording into register 'a'
{actions}       → do whatever you want to automate
q               → stop recording
@a              → run once
10@a            → run 10 times
@@              → repeat the last macro
```

### Registers

| Shortcut | Action |
|----------|--------|
| `"ayy` / `"ap` | Copy / paste using register `a` |
| `"0p` | Paste the last **yank** (not the last delete) |
| `"+y` / `"+p` | Explicit system clipboard |
| `:reg` | Show every register |

### Marks

| Shortcut | Action |
|----------|--------|
| `ma` | Set mark `a` |
| `` `a `` | Jump to mark `a` (exact position) |
| `` `. `` | Last edit |
| `` `` `` | Previous cursor position |

### Advanced undo

| Command | Action |
|---------|--------|
| `:earlier 5m` | Go back 5 minutes |
| `:later 5m` | Go forward 5 minutes |
| `U` | Undo every change on the line |

> Undo history is **persistent** (`undofile`): it survives closing Neovim.
> It's stored in `~/.local/state/nvim/undo`.

---

## This config's own keymaps

**Source:** [`lua/config/keymaps.lua`](../lua/config/keymaps.lua) · Always active

| Shortcut | Action |
|----------|--------|
| `Ctrl+s` | Save |
| `Ctrl+q` | Quit without saving |
| `jk` / `kj` | Leave insert mode (alternative to `Esc`) |
| `Space+wv` | New split to the **right** |
| `Space+ws` | New split **below** |
| `Space+wo` | Close every split but this one |
| `Space+q` | Close the current split |
| `Space++` / `Space+-` | Widen / narrow NvimTree |
| `Space+ve` | Open the project's `.env` |
| `Space+tc` | Toggle the colorizer |

### Automatic behaviour

**Source:** [`lua/config/autocmds.lua`](../lua/config/autocmds.lua)

| When | What happens |
|------|--------------|
| Leaving insert mode | The file is **saved automatically** |
| Yanking (`y`) | The copied text is highlighted for 200ms |
| On save | Trailing whitespace is stripped (except in markdown, diff and gitcommit) |
| On focusing Neovim | The file reloads if it changed on disk |
| Opening `docker-compose*.yml` | The filetype is set so its LSP attaches |
| Opening `.MD` / `.mdx` / `.mdown` / `.mkd` | Detected as markdown |

---

# Project search and navigation

## Telescope — fuzzy finder

**Plugin:** `telescope.nvim` + `fzf-native` · **Loads on:** any `Space+f*` shortcut or `:Telescope`

Fuzzy finder for files, content, buffers and more.

| Shortcut | Action |
|----------|--------|
| `Space+ff` | Find **files** in the current project |
| `Space+fg` | Search **content** (grep) in the project |
| `Space+fb` | Search open **buffers** |
| `Space+fp` | Find files across **all** projects |
| `Space+fP` | Search content across **all** projects |
| `Space+ft` | Search the project's **TODOs** |

> `Space+fp` and `Space+fP` search inside the folder set as `projects_dir` in
> [`lua/config/user.lua`](../lua/config/user.lua).

### Inside Telescope

| Shortcut | Action |
|----------|--------|
| `Ctrl+j` / `Ctrl+k` | Move down / up the list |
| `Enter` | Open |
| `Ctrl+x` / `Ctrl+v` / `Ctrl+t` | Open in horizontal split / vertical split / tab |
| `Ctrl+u` / `Ctrl+d` | Scroll the preview |
| `Ctrl+q` | Send all results to the quickfix list |
| `Esc` | Close |

### Search tips

- **Fuzzy:** for `models.py` typing `mdpy` is enough
- **By path:** `app/models` filters by folder
- **Excluded by default:** `node_modules`, `.git/`, `dist/`, `build/`, `__pycache__`, `.pyc`
- To include them: `:Telescope find_files hidden=true no_ignore=true`

---

## NvimTree — file explorer

**Plugin:** `nvim-tree.lua` · **Loads on:** `Space+e` or `:NvimTreeToggle`

| Shortcut | Action |
|----------|--------|
| `Space+e` | Open / close the explorer |
| `Space++` / `Space+-` | Widen / narrow it |

### Inside the tree

| Key | Action |
|-----|--------|
| `Enter` / `o` | Open the file or expand the folder |
| `Tab` | Open without moving focus from the tree |
| `a` | **Create** a file (end with `/` for a folder) |
| `d` | Delete |
| `r` | Rename |
| `x` / `c` / `p` | Cut / copy / paste |
| `y` / `Y` / `gy` | Copy the name / relative path / absolute path |
| `H` | Toggle hidden files |
| `I` | Toggle git-ignored files |
| `R` | Refresh |
| `s` / `i` / `t` | Open in vertical split / horizontal split / tab |
| `Ctrl+]` | Make this folder the root |
| `Backspace` / `-` | Go to the parent directory |
| `q` | Close |

### Creating files

```
a                        → press 'a'
name.py                  → a file
folder/                  → a folder (ends with /)
folder/sub/file.py       → creates the whole path
```

---

## Harpoon — bookmarks

**Plugin:** `harpoon` (branch 2) · **Loads on:** `Space+a`, `Space+1..4` or `Space+hh`

Mark the 4-5 files you're working on in a task and jump between them instantly.

| Shortcut | Action |
|----------|--------|
| `Space+a` | **Mark** the current file |
| `Space+1` .. `Space+4` | Jump to marked file 1-4 |
| `Space+hh` | View / edit the marked list |

In the list you can reorder (`dd` + `p`) or delete lines: the order defines the numbers.

---

## Flash — fast motion

**Plugin:** `flash.nvim` · **Loads on:** `VeryLazy` (after startup)

| Shortcut | Action |
|----------|--------|
| `s` | Jump anywhere on screen |
| `S` | Select a Treesitter node (function, block, string) |

### How it works

```
s               → activate
co              → type 2 letters of the destination
{label}         → letters appear over each match; press the one you want
```

It also works as a motion: `ds` deletes up to where you jump, `ys` copies.

> ⚠️ `s` replaces Vim's native `s` (delete a character and insert). The
> equivalent is `cl`.

---

## Dropbar — breadcrumbs

**Plugin:** `dropbar.nvim` · **Loads on:** `BufReadPre`

A top bar with the file path and current symbol (class → method), navigable.

| Shortcut | Action |
|----------|--------|
| `Space+bp` | Navigate the breadcrumb: pick a component and jump |

Inside the menu, `q` closes.

---

## Spectre — project-wide search and replace

**Plugin:** `nvim-spectre` · **Loads on:** `Space+S`, `Space+sw` or `Space+sf`

Project-wide replacement **with a preview before applying**.

| Shortcut | Action |
|----------|--------|
| `Space+S` | Open the panel |
| `Space+sw` | Search the word under the cursor project-wide |
| `Space+sw` (visual) | Search the selection |
| `Space+sf` | Search in the current file only |

### Inside the panel

| Key | Action |
|-----|--------|
| `dd` | Exclude / include that match |
| `Enter` | Go to that line's file |
| `R` | **Apply** every replacement |
| `q` | Close |

> Always use `dd` to exclude what you don't want **before** pressing `R`.

---

# Code

## LSP — code intelligence

**Plugin:** `nvim-lspconfig` + `mason.nvim` · **Loads on:** opening a file (`BufReadPre`)

Keymaps are registered per buffer when a server attaches.

| Shortcut | Action |
|----------|--------|
| `gd` | Go to **definition** |
| `gr` | Find **references** |
| `gi` | Go to implementation |
| `K` | **Hover**: symbol documentation |
| `Space+rn` | **Rename** across the project |
| `Space+ca` | **Code actions**: auto-import, quick fixes |
| `Space+cf` | Format (see [conform](#conform--formatting)) |
| `]d` / `[d` | Next / previous diagnostic |

**Included servers:** pyright, ruff, html, cssls, ts_ls, emmet_ls, jsonls,
yamlls, dockerls, docker-compose, nginx.

📖 Details in **[lsp-and-completion.md](lsp-and-completion.md)**.

---

## nvim-cmp — completion

**Plugin:** `nvim-cmp` · **Loads on:** `InsertEnter`

Merges LSP, Copilot, snippets, buffer and paths into one menu.

| Shortcut | Action |
|----------|--------|
| `Ctrl+Space` | Open the menu manually |
| `Tab` | Next entry · or expand/advance in a snippet |
| `Shift+Tab` | Previous entry · or go back in a snippet |
| `Enter` | Accept the **selected** entry |
| `Ctrl+e` | Close |
| `Ctrl+f` / `Ctrl+b` | Scroll the documentation |

> `Enter` uses `select = false`: with nothing selected via `Tab`, it inserts a
> normal newline.

---

## Copilot — AI suggestions

**Plugin:** `copilot.lua` + `copilot-cmp` · **Loads on:** `InsertEnter`

Suggestions appear **inside the nvim-cmp menu** with the  icon, so they use
the same keys as above.

| Command | Action |
|---------|--------|
| `:Copilot auth` | Authenticate (first time) |
| `:Copilot status` | Show the state |
| `:Copilot disable` / `:Copilot enable` | Disable / re-enable |

📖 Details in **[ai-copilot.md](ai-copilot.md)**.

---

## Snippets

**Plugin:** `LuaSnip` + `friendly-snippets` · **Loads on:** with nvim-cmp (`InsertEnter`)

They show in the menu tagged **Snippet**.

| Shortcut | Action |
|----------|--------|
| `Tab` | Expand · or next placeholder |
| `Shift+Tab` | Previous placeholder |

**Django/DRF enabled:** `block`, `for`, `url`, `static`, `csrf` in templates ·
`model`, `serializer`, `modelform`, `listview` in Python.

📖 Full list in **[django.md](django.md#snippets)**.

---

## conform — formatting

**Plugin:** `conform.nvim` · **Loads on:** `Space+cf`

| Shortcut | Action |
|----------|--------|
| `Space+cf` | Format the file (or the selection in visual mode) |

| Command | Action |
|---------|--------|
| `:ConformInfo` | See which formatter would run for this buffer |

Uses the formatters from your `PATH`/`.venv` (ruff, prettier, djlint), falling
back to the LSP.

📖 Details in **[lsp-and-completion.md](lsp-and-completion.md#formatting-with-conformnvim)**.

---

## Trouble — diagnostics panel

**Plugin:** `trouble.nvim` · **Loads on:** `Space+x*` or `:Trouble`

| Shortcut | Action |
|----------|--------|
| `Space+xx` | Every error and warning in the project |
| `Space+xf` | Current file only |
| `Space+xq` | Quickfix list |

### Inside the panel

| Key | Action |
|-----|--------|
| `Enter` | Go to the problem |
| `r` | Refresh |
| `za` / `zA` | Fold / unfold a group |
| `q` | Close |

---

## Treesitter

**Plugin:** `nvim-treesitter` · **Loads on:** immediately

Real code parsing: accurate highlighting, correct indentation, and the
foundation for Flash (`S`), rainbow-delimiters, autopairs and contextual comments.

| Command | Action |
|---------|--------|
| `:TSUpdate` | Update every parser |
| `:TSInstall {language}` | Install a parser |
| `:TSBufDisable highlight` | Disable highlighting in this buffer (huge files) |
| `:InspectTree` | View the syntax tree |

**Included parsers:** python, javascript, typescript, tsx, html, htmldjango,
css, scss, json, yaml, toml, bash, dockerfile, nginx, markdown, gitcommit,
diff, lua, vim, vimdoc, query, regex.

---

## Comment.nvim — commenting

**Plugin:** `Comment.nvim` + `ts-context-commentstring` · **Loads on:** `BufReadPre`

| Shortcut | Action |
|----------|--------|
| `gcc` | Comment / uncomment the line |
| `gc{motion}` | Comment by motion (`gcap` = paragraph) |
| `gc` (visual) | Comment the selection |
| `gbc` | Block comment |

**Context-aware:** inside a Django template it uses `{# #}` within Django
blocks, `<!-- -->` in HTML, `//` inside `<script>` and `/* */` inside `<style>`.

---

## nvim-surround — wrapping

**Plugin:** `nvim-surround` · **Loads on:** `VeryLazy`

| Shortcut | Action |
|----------|--------|
| `ysiw"` | Wrap the word in `"` |
| `ysiw)` | Wrap the word in `()` |
| `yss)` | Wrap the whole line |
| `cs"'` | **Change** `"text"` → `'text'` |
| `cs(}` | Change `(text)` → `{text}` |
| `ds"` | **Delete** the quotes |
| `ysiwt` | Wrap in an HTML tag (prompts for the name) |

---

## nvim-autopairs — auto-closing

**Plugin:** `nvim-autopairs` · **Loads on:** `InsertEnter`

Works on its own: closes `()`, `[]`, `{}`, `""`, `''` and respects the
Treesitter context (won't close inside strings or comments).

| Shortcut | Action |
|----------|--------|
| `Alt+e` | **Fast wrap**: wrap what follows with the pair |

Extras configured: symmetric spaces inside brackets and Python f-strings
(`f'`, `f"`).

---

## TODO comments

**Plugin:** `todo-comments.nvim` · **Loads on:** `BufReadPre`

Highlights keywords in comments and lets you search them.

| Keyword | Use |
|---------|-----|
| `TODO` | Something still to implement |
| `FIXME` / `BUG` / `FIXIT` | A known bug |
| `HACK` | Temporary workaround |
| `WARN` / `WARNING` | A warning |
| `NOTE` / `INFO` | Informational note |

| Shortcut / Command | Action |
|--------------------|--------|
| `Space+ft` | Search every TODO in the project (Telescope) |
| `:TodoTrouble` | View them in the Trouble panel |

```python
# TODO: implement the statistics endpoint
# FIXME: this queryset causes N+1 queries
# NOTE: this view requires token authentication
```

---

# Git

## Fugitive — status and commits

**Plugin:** `vim-fugitive` · **Loads on:** `:Git` or `Space+gs`

| Shortcut | Action |
|----------|--------|
| `Space+gs` | Interactive **git status** panel |
| `Space+gu` | Discard changes in the current file |
| `Space+gU` | Discard **all** changes ⚠️ |

**Inside the panel:** `s` stage · `u` unstage · `=` diff · `cc` commit ·
`ca` amend · `X` discard · `q` close.

📖 Full command list in **[git-and-github.md](git-and-github.md#fugitive--status-and-commits)**.

---

## GitSigns — hunks and blame

**Plugin:** `gitsigns.nvim` · **Loads on:** `BufReadPre` (git repos only)

| Shortcut | Action |
|----------|--------|
| `]c` / `[c` | Next / previous change |
| `Space+hp` | **Preview** the hunk |
| `Space+hs` | **Stage** just this hunk |
| `Space+hr` | **Reset** just this hunk |
| `Space+hb` | Full **blame** for the line |
| `Space+hd` | Diff the whole file |
| `Space+tb` | Toggle inline blame |

📖 Details in **[git-and-github.md](git-and-github.md#gitsigns--hunks-and-blame)**.

---

## Diffview — diffs and history

**Plugin:** `diffview.nvim` · **Loads on:** `Space+g*` or `:DiffviewOpen`

| Shortcut | Action |
|----------|--------|
| `Space+gd` | Diff against the base branch |
| `Space+gD` | Diff against `origin/<base branch>` |
| `Space+gw` | Diff the working tree |
| `Space+gh` | Current file history |
| `Space+gf` | Commits from the base branch to `HEAD` |
| `Space+gq` | Close |

**Inside:** `Tab` / `Shift+Tab` between files · `g?` for help.

> The base branch comes from `git_base_branch` in
> [`lua/config/user.lua`](../lua/config/user.lua).

---

## git-conflict — conflicts

**Plugin:** `git-conflict.nvim` · **Loads on:** `BufReadPre`

| Shortcut | Action |
|----------|--------|
| `Space+co` | Choose **ours** (current) |
| `Space+ct` | Choose **theirs** (incoming) |
| `Space+cb` | Choose **both** |
| `Space+cn` / `Space+cp` | Next / previous conflict |
| `Space+cl` | List every conflict |

📖 Workflow in **[git-and-github.md](git-and-github.md#git-conflict--merge-conflicts)**.

---

## Octo — GitHub

**Plugin:** `octo.nvim` · **Loads on:** `Space+o*` or `:Octo` · **Requires:** `gh auth login`

| Shortcut | Action |
|----------|--------|
| `Space+opr` | List pull requests |
| `Space+opc` | Create a pull request |
| `Space+ois` | List issues |
| `Space+oic` | Create an issue |
| `Space+or` | Start a code review |

📖 Full commands in **[git-and-github.md](git-and-github.md#octo--github-prs-and-issues)**.

---

# Environment

## ToggleTerm — terminal

**Plugin:** `toggleterm.nvim` · **Loads on:** immediately

| Shortcut | Action |
|----------|--------|
| `Ctrl+´` | Toggle the horizontal terminal |
| `Space+tt` | Same (alternative if `Ctrl+´` doesn't work on your keyboard) |
| `Space+ld` | **LazyDocker** in a floating window |
| `Space+lv` | **Live Server** in a floating window |

### Inside the terminal

| Shortcut | Action |
|----------|--------|
| `Esc` | Leave for normal mode (terminal stays open) |
| `i` / `a` | Back to terminal mode |
| `Ctrl+h/j/k/l` | Move to other splits without leaving terminal mode |

---

## Docker — LazyDocker

**Tool:** [LazyDocker](https://github.com/jesseduffield/lazydocker) via `toggleterm.nvim` · **Loads on:** `Space+ld`

A visual interface for containers, logs, images and volumes without leaving Neovim.

| Shortcut | Action |
|----------|--------|
| `Space+ld` | Open **LazyDocker** in a floating window |

### Inside LazyDocker

| Key | Action |
|-----|--------|
| `Tab` · `[` `]` | Switch panels (Containers, Images, Volumes, Logs) |
| `↑` `↓` · `j` `k` | Move through the list |
| `Enter` | Show details / logs for the selection |
| `x` | **Action menu** for the item (the most useful: lists everything possible) |
| `s` | Stop the container |
| `r` | Restart the container |
| `a` | Attach to the container |
| `d` | Remove (asks for confirmation) |
| `/` | Filter |
| `q` | Quit LazyDocker |

> 💡 **When unsure about a key, press `x`**: it opens the contextual menu with
> every action available for what's selected. The safest way to operate without
> memorizing shortcuts.

### From the terminal

With `Ctrl+´` (integrated terminal) or a tmux pane:

```bash
# State
docker ps                          # running containers
docker ps -a                       # including stopped ones
docker compose ps                  # just this compose project

# Logs
docker compose logs -f web         # follow a service's logs
docker compose logs --tail=100 web

# Lifecycle
docker compose up -d               # start in the background
docker compose down                # tear everything down
docker compose restart web         # restart one service
docker compose build web           # rebuild the image

# Get inside the container
docker compose exec web bash
docker compose exec web python manage.py migrate

# Cleanup
docker system df                   # how much space Docker uses
docker system prune                # delete unused data ⚠️
```

### LSP support

Docker files get completion and diagnostics:

| File | Server |
|------|--------|
| `Dockerfile` | `dockerls` |
| `docker-compose*.yml` · `compose*.yml` | `docker_compose_language_service` |

> The compose filetype is assigned by an autocommand in
> [`lua/config/autocmds.lua`](../lua/config/autocmds.lua), because Neovim
> detects them as generic YAML and wouldn't start their server.

---

## HTML — Live Server

**Tool:** [live-server](https://github.com/tapio/live-server) via `npx` + `toggleterm.nvim` · **Loads on:** `Space+lv` · **Requires:** Node.js

The equivalent of the VSCode Live Server extension: serves your HTML/CSS files
and **reloads the browser automatically** every time you save. Meant for plain
HTML/CSS work with no Docker and no backend.

| Shortcut | Action |
|----------|--------|
| `Space+lv` | Open **Live Server** in a floating terminal — serves the current file's folder and opens the browser |

### How to use it

```
1. Open your index.html
2. Space+lv           → starts the server and opens the browser
3. Esc                → leave the floating terminal, it keeps serving in the background
4. Edit and save your .html or .css
5. Look at the browser: it refreshed on its own
```

Pressing `Space+lv` again shows/hides that terminal (just like `Space+ld` with
LazyDocker) without restarting the server.

### 🖥️ It isn't "inside" Neovim — and that's expected

Neovim runs in a text terminal: it can't draw a real browser inside itself.
What this shortcut does is start the server and open your system browser
**next to** the Neovim window — visually the same experience as Live Server in
VSCode (code on one side, result on the other), except the browser is a
separate window rather than an embedded panel.

### Technical notes

- It serves **the folder**, not just the file — with `index.html` + `style.css`
  in the same folder, relative links work exactly as in production
- The server starts serving the folder of whichever file was open **the first
  time** you press `Space+lv`. Switching to a different project means
  restarting Neovim so it picks the right folder up
- It runs `npx --yes live-server` rather than a global install, so no `sudo`
  and nothing touched system-wide

---

## tmux

**Integration plugin:** `vim-tmux-navigator` · **Loads on:** immediately

| Shortcut | Action |
|----------|--------|
| `Ctrl+h` `Ctrl+j` `Ctrl+k` `Ctrl+l` | Move between Neovim splits **and** tmux panes |

**tmux prefix:** `Ctrl+a` · `Ctrl+a d` detach · `Ctrl+a s` sessions ·
`Ctrl+a z` zoom · `Ctrl+a |` and `Ctrl+a -` to split.

📖 Full setup in **[tmux.md](tmux.md)**.

---

## auto-session — sessions

**Plugin:** `auto-session` · **Loads on:** immediately

Automatically saves and restores your open files **per folder and git branch**.

| Shortcut | Action |
|----------|--------|
| `Space+ss` | Save the session manually |
| `Space+sr` | Restore the session |
| `Space+sd` | Delete this folder's session |

Suppressed in `~/`, `/` and your projects root, so it won't restore junk
sessions. Configurable via `session_ignore_dirs` in
[`lua/config/user.lua`](../lua/config/user.lua).

---

## Legendary — command palette

**Plugin:** `legendary.nvim` · **Loads on:** `VeryLazy`

A fuzzy finder over **every** shortcut and command available. The lifesaver
when you can't remember a keymap.

| Shortcut | Action |
|----------|--------|
| `Ctrl+p` | Open the palette |
| `Space+lk` | Browse keymaps only |
| `Space+lc` | Browse commands only |

---

## Dashboard

**Plugin:** `dashboard-nvim` · **Loads on:** `VimEnter` (opening `nvim` with no file)

| Key | Action |
|-----|--------|
| `f` | Find a file |
| `r` | Open a project from your projects folder |
| `g` | Search text |
| `c` | Edit the configuration |
| `p` | Open Lazy (plugins) |
| `q` | Quit |
| `1` .. `5` | Open one of the recent files |

> The banner and greeting come from `dashboard_header` and `name` in
> [`lua/config/user.lua`](../lua/config/user.lua).

---

## which-key

**Plugin:** `which-key.nvim` · **Loads on:** `VeryLazy`

Press `Space` (or any prefix) and wait 300ms: a panel appears with the
available options. Defined groups:

| Prefix | Group |
|--------|-------|
| `Space+f` | Find |
| `Space+g` | Git |
| `Space+h` | Git hunks / Harpoon |
| `Space+w` | Windows |
| `Space+c` | Code / Conflicts |
| `Space+d` | Debug |
| `Space+n` | Tests |
| `Space+s` | Session / Spectre |
| `Space+x` | Diagnostics |
| `Space+o` | Octo (GitHub) |
| `Space+l` | Legendary / Live Server |
| `Space+t` | Toggle |
| `Space+m` | Markdown |

---

# Running things

## nvim-dap — debugger

**Plugin:** `nvim-dap` + `nvim-dap-python` · **Loads on:** `Space+d*`

| Shortcut | Action |
|----------|--------|
| `Space+db` | Toggle a breakpoint |
| `Space+dc` | Continue — or start and pick a configuration |
| `Space+do` | Step over |
| `Space+di` | Step into |
| `Space+dx` | Terminate the session |
| `Space+du` | Toggle the UI |

**Configurations:** "Django runserver", "Launch file", "Attach remote".

📖 Workflow in **[django.md](django.md#debugger)**.

---

## Neotest — tests

**Plugin:** `neotest` + `neotest-python` · **Loads on:** `Space+n*`

| Shortcut | Action |
|----------|--------|
| `Space+nt` | Run the test under the cursor |
| `Space+nf` | Run every test in the file |
| `Space+ns` | Toggle the results panel |
| `Space+no` | Show the test output |

Uses `pytest` with `.venv/bin/python`. Inline results: ✅ / ❌.

📖 Details in **[django.md](django.md#tests-with-neotest)**.

---

## Markdown Preview

**Plugin:** `markdown-preview.nvim` · **Loads on:** `Space+mp` or opening a `.md`

| Shortcut | Action |
|----------|--------|
| `Space+mp` | Open the preview in the browser |
| `Space+ms` | Stop the preview |

> `.MD`, `.mdx`, `.mdown` and `.mkd` are also detected as markdown thanks to an
> entry in [`lua/config/autocmds.lua`](../lua/config/autocmds.lua).

---

## Colorizer

**Plugin:** `nvim-colorizer.lua` · **Loads on:** `BufReadPre`

Paints CSS/hex colors with their actual color as the background.

| Shortcut / Command | Action |
|--------------------|--------|
| `Space+tc` | Toggle |
| `:ColorizerToggle` | Same |

Active in css, scss, sass, html, htmldjango, javascript, typescript, jsx, tsx
and lua. Supports names (`red`), `rgb()`, `hsl()`, hex and Tailwind classes.

---

## Extras

**Plugin:** `cellular-automaton.nvim` · **Loads on:** the shortcut

| Shortcut | Action |
|----------|--------|
| `Space+fml` | "Make it rain": your code melts 🌧️ |
| `Space+gol` | Game of Life over your buffer |

Pure fun. Any key stops it.

---

# Reference

## Management commands

### Plugins

| Command | Action |
|---------|--------|
| `:Lazy` | Open the plugin panel |
| `:Lazy sync` | Update + clean + install |
| `:Lazy update` | Update only |
| `:Lazy clean` | Remove plugins no longer in the config |
| `:Lazy restore` | Go back to `lazy-lock.json`'s versions |
| `:Lazy profile` | Load time per plugin |

### LSP and tooling

| Command | Action |
|---------|--------|
| `:Mason` | Server manager (`i` install, `X` uninstall, `U` update all) |
| `:LspInfo` | Servers attached to this buffer |
| `:LspRestart` | Restart servers |
| `:LspLog` | LSP error log |
| `:ConformInfo` | Available and active formatters |
| `:TSUpdate` | Update Treesitter parsers |
| `:Copilot status` | Copilot state |

### Diagnostics

| Command | Action |
|---------|--------|
| `:checkhealth` | Full diagnostics |
| `:checkhealth lsp` | LSP only |
| `:checkhealth telescope` | Telescope only |
| `:messages` | Session messages and errors |
| `:version` | Neovim version |
| `:verbose nmap <leader>gd` | Check whether a keymap exists and where it came from |

### Shell utilities

| Command | Action |
|---------|--------|
| `:!command` | Run a shell command |
| `:read !command` | Insert its output into the buffer |
| `:%!jq` | Format the whole buffer as JSON |
| `:sort` / `:sort n` | Sort lines alphabetically / numerically |
| `:g/^$/d` | Delete every blank line |
| `:args *.py` + `:argdo %s/a/b/g` | Replace across several files |

---

## Alphabetical cheatsheet

Every `Space` shortcut, sorted.

| Shortcut | Tool | Action |
|----------|------|--------|
| `Space++` | NvimTree | Widen |
| `Space+-` | NvimTree | Narrow |
| `Space+1..4` | Harpoon | Go to marked file 1-4 |
| `Space+a` | Harpoon | Mark file |
| `Space+bp` | Dropbar | Navigate breadcrumb |
| `Space+ca` | LSP | Code actions |
| `Space+cb` | git-conflict | Choose both changes |
| `Space+cf` | conform | Format |
| `Space+cl` | git-conflict | List conflicts |
| `Space+cn` | git-conflict | Next conflict |
| `Space+co` | git-conflict | Choose ours |
| `Space+cp` | git-conflict | Previous conflict |
| `Space+ct` | git-conflict | Choose theirs |
| `Space+db` | DAP | Toggle breakpoint |
| `Space+dc` | DAP | Continue / start |
| `Space+di` | DAP | Step into |
| `Space+do` | DAP | Step over |
| `Space+du` | DAP | Toggle UI |
| `Space+dx` | DAP | Terminate debug |
| `Space+e` | NvimTree | Toggle explorer |
| `Space+fb` | Telescope | Find buffers |
| `Space+ff` | Telescope | Find files |
| `Space+fg` | Telescope | Search text |
| `Space+fml` | Extras | Make it rain |
| `Space+fp` | Telescope | Files across all projects |
| `Space+fP` | Telescope | Text across all projects |
| `Space+ft` | todo-comments | Search TODOs |
| `Space+gd` | Diffview | Diff against base branch |
| `Space+gD` | Diffview | Diff against origin/base |
| `Space+gf` | Diffview | Commits since base branch |
| `Space+gh` | Diffview | File history |
| `Space+gol` | Extras | Game of Life |
| `Space+gq` | Diffview | Close Diffview |
| `Space+gs` | Fugitive | Git status |
| `Space+gu` | Fugitive | Discard file changes |
| `Space+gU` | Fugitive | Discard all changes ⚠️ |
| `Space+gw` | Diffview | Diff working tree |
| `Space+hb` | GitSigns | Blame line |
| `Space+hd` | GitSigns | Diff file |
| `Space+hh` | Harpoon | Show marked list |
| `Space+hp` | GitSigns | Preview hunk |
| `Space+hr` | GitSigns | Reset hunk |
| `Space+hs` | GitSigns | Stage hunk |
| `Space+lc` | Legendary | Browse commands |
| `Space+ld` | ToggleTerm | LazyDocker |
| `Space+lk` | Legendary | Browse keymaps |
| `Space+lv` | Live Server | HTML/CSS preview with auto-reload |
| `Space+mp` | Markdown Preview | Open preview |
| `Space+ms` | Markdown Preview | Stop preview |
| `Space+nf` | Neotest | Tests in file |
| `Space+no` | Neotest | Test output |
| `Space+ns` | Neotest | Results panel |
| `Space+nt` | Neotest | Test under cursor |
| `Space+oic` | Octo | Create issue |
| `Space+ois` | Octo | List issues |
| `Space+opc` | Octo | Create PR |
| `Space+opr` | Octo | List PRs |
| `Space+or` | Octo | Start review |
| `Space+q` | Config | Close split |
| `Space+rn` | LSP | Rename symbol |
| `Space+S` | Spectre | Open panel |
| `Space+sd` | auto-session | Delete session |
| `Space+sf` | Spectre | Search in current file |
| `Space+sr` | auto-session | Restore session |
| `Space+ss` | auto-session | Save session |
| `Space+sw` | Spectre | Search word project-wide |
| `Space+tb` | GitSigns | Toggle inline blame |
| `Space+tc` | Colorizer | Toggle colorizer |
| `Space+tt` | ToggleTerm | Toggle terminal |
| `Space+ve` | Config | Edit .env |
| `Space+wo` | Config | Close other splits |
| `Space+ws` | Config | Split below |
| `Space+wv` | Config | Split right |
| `Space+xf` | Trouble | File diagnostics |
| `Space+xq` | Trouble | Quickfix list |
| `Space+xx` | Trouble | Project diagnostics |

### Without leader

| Shortcut | Tool | Action |
|----------|------|--------|
| `Ctrl+s` / `Ctrl+q` | Config | Save / quit without saving |
| `Ctrl+h/j/k/l` | tmux-navigator | Move between splits and panes |
| `Ctrl+p` | Legendary | Command palette |
| `Ctrl+´` | ToggleTerm | Terminal |
| `Ctrl+Space` | nvim-cmp | Manual completion |
| `jk` / `kj` | Config | Leave insert mode |
| `gd` `gr` `gi` `K` | LSP | Definition, references, implementation, hover |
| `]d` / `[d` | LSP | Next / previous diagnostic |
| `]c` / `[c` | GitSigns | Next / previous change |
| `s` / `S` | Flash | Jump / Treesitter jump |
| `gcc` / `gc` | Comment | Comment line / selection |
| `ys` `cs` `ds` | nvim-surround | Wrap, change, delete |
| `Alt+e` | autopairs | Fast wrap |

---

[⬅️ Back to the README](../README.md) · [Daily routine ➡️](daily-routine.md)
