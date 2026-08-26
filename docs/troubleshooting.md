# 🐛 Troubleshooting

> Diagnosing the most common problems, from most frequent to most obscure.

---

## 📋 Contents

- [First diagnosis](#first-diagnosis)
- [Installation](#installation)
- [Icons and fonts](#icons-and-fonts)
- [Telescope](#telescope)
- [LSP and completion](#lsp-and-completion)
- [Copilot](#copilot)
- [Snippets](#snippets)
- [Formatting](#formatting)
- [Keymaps](#keymaps)
- [Performance](#performance)
- [Git](#git)
- [Debugger and tests](#debugger-and-tests)
- [Live Server and Docker](#live-server-and-docker)
- [REST client (Kulala)](#rest-client-kulala)
- [Treesitter and highlighting](#treesitter-and-highlighting)
- [Clean reinstall](#clean-reinstall)
- [Reporting a problem](#reporting-a-problem)

---

## First diagnosis

Before anything else, these four commands solve or locate most cases:

```vim
:checkhealth      " full Neovim and plugin diagnostics
:Lazy             " are all plugins installed?
:Mason            " are the language servers installed?
:messages         " were there errors at startup?
```

---

## Installation

### `vim.lsp.config` doesn't exist / errors right after cloning

Your Neovim is older than 0.12.

```bash
nvim --version
```

If it's 0.11 or lower, upgrade — see [installation.md](installation.md#neovim).
nvim-treesitter's `main` branch also requires 0.12.

### `telescope-fzf-native` fails to compile

The compiler is missing.

```bash
sudo apt install build-essential -y
```

Then, inside Neovim:

```vim
:Lazy build telescope-fzf-native.nvim
```

### Treesitter parsers won't compile

Same cause (`gcc` missing). Check and rebuild:

```vim
:checkhealth nvim-treesitter
:TSUpdate
```

### Mason installs nothing

```vim
:checkhealth mason
```

Usually `curl`, `unzip`, `tar`, `node` or `python3` is missing:

```bash
sudo apt install curl unzip tar -y
```

### The "all projects" search finds nothing

`projects_dir` in [`lua/config/user.lua`](../lua/config/user.lua) points at a
folder that doesn't exist. Set it to wherever you actually keep your code:

```lua
M.projects_dir = "~/projects"
```

---

## Icons and fonts

### I see boxes or question marks

You don't have a Nerd Font active in the terminal.

```bash
# 1. Is it installed?
fc-list | grep -i "JetBrainsMono"

# 2. If not, install it
mkdir -p ~/.local/share/fonts && cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono && rm JetBrainsMono.zip
fc-cache -fv
```

**3.** Select it in your terminal preferences (installing isn't enough).
**4.** Fully close and reopen the terminal.

### Colors look washed out

True color is missing.

```bash
echo $COLORTERM     # should say "truecolor" or "24bit"
```

If you use tmux, see [tmux.md](tmux.md#colors-look-wrong-inside-tmux).

---

## Telescope

### It doesn't find files

```bash
which rg
which fd

# If they're missing:
sudo apt install ripgrep fd-find -y
sudo ln -s /usr/bin/fdfind /usr/local/bin/fd
```

### It doesn't find hidden or ignored files

By design: `node_modules`, `.git/`, `dist/`, `build/`, `__pycache__` and `.pyc`
are excluded. To include them temporarily:

```vim
:Telescope find_files hidden=true no_ignore=true
```

To change it permanently, edit `file_ignore_patterns` in
[`lua/plugins/editor.lua`](../lua/plugins/editor.lua).

### Search feels slow

Check `fzf-native` compiled:

```vim
:checkhealth telescope
```

---

## LSP and completion

### No completion or diagnostics at all

```vim
" 1. Did any server attach to this buffer?
:LspInfo

" 2. Is the server installed?
:Mason

" 3. Any errors?
:LspLog
```

### `:LspInfo` says no clients attached

Common causes, in order:

**a) The filetype doesn't match.** Check:

```vim
:set filetype?
```

Compare against the server's `filetypes` in [`lua/plugins/lsp.lua`](../lua/plugins/lsp.lua).

**b) The binary isn't on `PATH`.** Mason's servers live in
`~/.local/share/nvim/mason/bin/`. Try:

```vim
:lua print(vim.fn.executable("pyright-langserver"))
" 1 = found, 0 = not found
```

**c) A typo in `cmd`.** This bug is silent: the server simply never starts and
nothing is reported. Check the server's `cmd` character by character — stray
spaces included.

**d) The project root isn't detected.** Some servers need a marker file
(`pyproject.toml`, `package.json`, `.git`). Open Neovim from the project root.

### Python diagnostics don't match my CI

Almost always the `.venv`. `ruff` is resolved from `PATH`:

```bash
# Activate the venv BEFORE opening nvim
source .venv/bin/activate
which ruff        # should point into .venv, not mason
nvim
```

Without the venv, it uses Mason's global ruff with default settings.

### No inline types in TypeScript/JavaScript (inlay hints)

If `gd`, `K` and diagnostics work but you never see the greyed-out inferred
types, it's not a broken install: `tsserver` reports `inlayHintProvider = true`
and then returns zero hints unless its preferences are enabled.

Check the server is actually attached and what it returns:

```vim
:LspInfo
:lua =vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
```

The fix lives in `ts_ls`'s `settings` in
[`lua/plugins/lsp.lua`](../lua/plugins/lsp.lua) — `typescript.inlayHints` and
`javascript.inlayHints` must both be set.

> 💡 Remember hints only appear where the type is **inferred**. In a file where
> every variable is annotated by hand there is nothing to show, which can look
> like a failure when it isn't.

### A server hangs

```vim
:LspRestart
```

---

## Copilot

### `Node.js version 22 or newer required but found 18.x`

Your shell is resolving an old Node.

```bash
which node && node --version
```

If it points at `/usr/bin/node`, the system (apt) Node is winning over nvm's.
Make sure nvm is loaded in **your** shell's config — the nvm installer often
only writes to `.bashrc`, so zsh users need this in `~/.zshrc`:

```bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
```

Open a new terminal and confirm with `node --version`.

> 💡 This also fixes `npm install -g` needing sudo: with nvm active, global
> installs go into your home directory.

### No suggestions

```vim
" 1. Authenticated?
:Copilot status

" 2. If not:
:Copilot auth

" 3. Is the filetype enabled?
:set filetype?
```

Copilot uses `["*"] = false`: it only works on the filetypes listed in
[`lua/plugins/ai.lua`](../lua/plugins/ai.lua). That's intentional (see
[ai-copilot.md](ai-copilot.md#-why-the-list-is-closed)).

### Copilot works but suggestions don't show in the menu

Check `copilot-cmp` is loaded and that `copilot` is in nvim-cmp's `sources` in
[`lua/plugins/lsp.lua`](../lua/plugins/lsp.lua).

### `:Copilot status` says "not authorized"

Your account has no active Copilot subscription. Free alternatives in
[ai-copilot.md](ai-copilot.md#ai-alternatives).

---

## Snippets

### The Django snippets don't appear

Check they loaded:

```vim
:lua print(#(require("luasnip").get_snippets("django") or {}))
" Should print ~139
```

If it prints `0`, the order in [`lua/plugins/lsp.lua`](../lua/plugins/lsp.lua)
is wrong: `filetype_extend` **must be called before** `lazy_load()`.

```lua
-- ✅ Correct order
luasnip.filetype_extend("python", { "django", "django-rest" })
require("luasnip.loaders.from_vscode").lazy_load()
```

### No Django snippets inside a template

The filetype is `html` instead of `htmldjango`:

```vim
:set filetype?
:set filetype=htmldjango    " force it
```

Neovim detects `htmldjango` from the presence of `{% %}` syntax. A template
that doesn't have any yet is detected as `html`.

---

## Formatting

### `Space+cf` does nothing

```vim
:ConformInfo
```

Shows the available formatters and which would run. If there are none, conform
falls back to the LSP; if the LSP doesn't format that filetype either, nothing
happens.

### Installing the missing formatter

```bash
# Python / Django templates (inside the project's .venv)
pip install ruff djlint

# JS/TS/CSS/JSON
npm install -g prettier @fsouza/prettierd
```

### Formatting ignores my project's config

Formatters are resolved from `PATH`. Open Neovim with the `.venv` active so it
uses the project's ruff/djlint and its `pyproject.toml`.

---

## Keymaps

### A documented shortcut does nothing

```vim
:verbose nmap <leader>gd
```

- **Nothing shown:** the keymap isn't registered. Almost always the bug of
  defining keymaps inside a lazy plugin's `config` — see
  [plugins.md](plugins.md#-golden-rule-keymaps-go-in-keys-not-config).
- **Another plugin shown:** there's a collision.

### A shortcut takes ~1 second to respond

Prefix collision: a mapping is both complete and a prefix of another one.
Neovim waits `timeoutlen` to disambiguate.

This config uses `timeoutlen = 300` and has no collisions, but adding
`<leader>x` when `<leader>xx` already exists reintroduces the problem.

To detect them:

```vim
:lua for _,m in ipairs(vim.api.nvim_get_keymap("n")) do print(m.lhs) end
```

### `Ctrl+h/j/k/l` doesn't reach the tmux panes

`~/.tmux.conf` isn't configured — see
[tmux.md](tmux.md#vim-tmux-navigator-integration).

### `Ctrl+´` doesn't open the terminal

That character depends on your keyboard layout. Use `Space+tt` instead, or
change `open_mapping` in [`lua/plugins/terminal.lua`](../lua/plugins/terminal.lua):

```lua
open_mapping = [[<C-\>]],
```

---

## Performance

### Neovim is slow to start

```bash
nvim --startuptime /tmp/start.log +q && tail -1 /tmp/start.log
```

Reference: **~60ms**. If it's much higher, find the culprit:

```vim
:Lazy profile
```

Usual cause: a plugin added without a lazy-loading trigger (no `keys`, `cmd`,
`ft` or `event`).

### The editor feels sluggish while typing

- **Very large files:** Treesitter and the LSP struggle. Try
  `:TSBufDisable highlight` in that buffer.
- **`update_in_insert`:** it's already `false`. If you turned it on, turn it back off.
- **gitsigns inline blame:** disable it with `Space+tb`.

---

## Git

### `Space+gd` fails with "revision not found"

The Diffview shortcuts compare against the branch set as `git_base_branch` in
[`lua/config/user.lua`](../lua/config/user.lua). If your repo uses `main` and
that's set to `development` (or vice versa), update it:

```lua
M.git_base_branch = "main"
```

### Octo doesn't work

```bash
gh auth status

# If not authenticated:
gh auth login
```

### GitSigns shows nothing

It only works inside a Git repository. Verify with `:Git status` or `git status`.

---

## Debugger and tests

### `Space+dc` can't find the adapter

```vim
:MasonInstall debugpy
```

### The Django debugger doesn't stop at the breakpoint

Make sure you picked the **"Django runserver"** configuration, which includes
`--noreload`. With autoreload on, Django restarts the process and the debugger
loses its attachment.

### Neotest finds no tests

It needs `pytest` in the environment and the configured `python` to exist:

```bash
source .venv/bin/activate
pip install pytest
which python      # should point to .venv/bin/python
```

If you use Django's runner instead of pytest, change it in
[`lua/plugins/testing.lua`](../lua/plugins/testing.lua).

---

## Live Server and Docker

### `Space+lv` does nothing or errors

It runs through `npx`, so Node must be available:

```bash
node --version    # >= 22 recommended
npx --yes live-server --version
```

The first run downloads the package, which takes a few seconds.

### Live Server serves the wrong folder

It serves the folder of whichever file was open **the first time** you pressed
`Space+lv` in that session. Restart Neovim to pick up a different folder.

### `Space+ld` (LazyDocker) does nothing

LazyDocker isn't installed:

```bash
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
lazydocker --version
```

---

## REST client (Kulala)

### `:checkhealth kulala` says `kulala-core not found`

The backend (~100 MB) downloads on first use into
`~/.local/share/nvim/kulala.nvim/bin/`. Open any `.http` file with a working
connection and it retries. To force it:

```vim
:lua require("kulala.backend").ensure_installed(function(ok) print(ok) end)
```

If the download races with the first request you may see `ETXTBSY` once — it is
the installer executing the binary it just wrote. Re-run `:checkhealth kulala`;
if it reports OK, there is nothing to fix.

### `Failed to fetch tree-sitter grammar: fatal: 'origin' does not appear to be a git repository`

Full message, on opening a `.http` file:

```
Failed to fetch tree-sitter grammar: fatal: 'origin' does not appear to be a
git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights and the repository exists.
```

**This is not an SSH problem**, despite what the last two lines suggest. It is
what git prints when there is no remote named `origin`: it falls back to
treating `origin` as a URL, fails to resolve it, and emits its generic
access-rights message.

**Cause:** Kulala sets up the grammar in three async steps —

```
git init  →  git remote add origin <url>  →  git fetch origin <commit>
```

If Neovim exits between the first and second step (Ctrl+C, closing the
terminal, an impatient `:q` during the first launch), a `.git` directory is
left behind with no remote configured. `lua/kulala/config/parser.lua` then only
checks that `.git` **exists** before skipping straight to the fetch, so the
half-initialised state is never repaired and every subsequent `.http` file
raises the same error.

**Diagnose** — an empty output confirms it:

```bash
git -C ~/.local/share/nvim/kulala.nvim/tree-sitter-kulala-http remote -v
```

**Fix** — delete the directory and reopen a `.http` file, letting the setup run
to completion this time:

```bash
rm -rf ~/.local/share/nvim/kulala.nvim/tree-sitter-kulala-http
```

### `Failed to build tree-sitter parser`

The grammar downloaded but `tree-sitter-cli` is missing; Kulala compiles the
parser from source and shells out to it.

```bash
sudo pacman -S tree-sitter-cli     # Arch / CachyOS
```

`tree-sitter-cli` is needed twice over: Kulala builds its grammar with it, and
nvim-treesitter's `main` branch requires it (0.26.1 or later) to install
parsers. Upstream asks for the **package-manager build, not the npm one**, so
install it that way where you can.

Debian and Ubuntu do ship the package, but it lags well behind (0.20.x on
24.04) — too old for both consumers. On those, install a current release from
[the tree-sitter releases page](https://github.com/tree-sitter/tree-sitter/releases)
and put it on your `PATH`.

Reopen a `.http` file — the build takes a couple of seconds and only happens
once. It lands in `~/.local/share/nvim/site/parser/kulala_http.so`.

If you would rather not install it, add `treesitter = { enable = false }` to
the `opts` in `lua/plugins/http.lua`. You lose syntax highlighting inside
`.http` files; requests themselves work without the parser.

### Variables arrive as literal `{{host}}`

`http-client.env.json` has to sit in the **same folder** as the `.http` file,
and the selected environment must exist as a key in it. `Space+Ri` inspects the
request with everything resolved, which shows exactly what got substituted.

### A POST that looks correct returns `400`

The blank line between the headers and the body is required by the `.http`
spec. Without it Django receives an empty body.

> Full guide: [rest-client.md](rest-client.md)

---

## Treesitter and highlighting

### Markdown lost its colors — `attempt to call method 'range' (a nil value)`

Full error, on opening any `.md` file:

```
vim.schedule callback: .../treesitter/languagetree.lua:215:
.../treesitter.lua:197: attempt to call method 'range' (a nil value)
```

**Resolved** — this config now tracks the nvim-treesitter `main` branch, which
supports Neovim 0.12. Kept here because the error is cryptic and any config
still on `master` will hit it.

**Cause:** nvim-treesitter's `master` branch does not support Neovim 0.12; its
own README states `Neovim 0.10 or 0.11 (Neovim 0.12 is not supported)`. Its
markdown injections query uses the custom `#set-lang-from-info-string!`
directive, whose handler reads `match[capture_id]` as a single node. Neovim
0.12 changed that to a **list** of nodes, so the call fails. Since that query
is what injects `markdown_inline` and the fenced code languages, the whole
markdown highlighter goes down with it and you get plain text.

**Fix:** move to the `main` branch, as this config did. The directive does not
exist there — queries ship with each parser rather than with the plugin.

### A language lost its highlighting after the move to `main`

Parsers live in a different place on `main`
(`~/.local/share/nvim/site/parser/`), and the ones built by `master` inside the
plugin directory are not reused. If a language went plain after switching:

```vim
:checkhealth nvim-treesitter    " lists installed parsers and their versions
:TSInstall <language>
:TSUpdate
```

Highlighting is enabled by a `FileType` autocommand in
[`lua/plugins/editor.lua`](../lua/plugins/editor.lua) that starts treesitter
for whatever parser is available, so a language works as soon as its parser is
installed — no list to edit for a one-off.

Note that `main` requires `tree-sitter-cli` from a **package manager, not npm**
(the npm build is not supported upstream), plus a C compiler.

## Clean reinstall

When nothing else works. **This does not delete your configuration**, only the
downloaded plugins, state and cache:

```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
nvim
```

Everything reinstalls from `lazy-lock.json` (2-3 minutes).

### Going back to the last version that worked

```bash
cd ~/.config/nvim
git log --oneline           # find the good commit
git checkout <commit>
```

```vim
:Lazy restore   " reinstall that lock file's versions
```

### Restoring the configuration you had before this one

```bash
rm -rf ~/.config/nvim
mv ~/.config/nvim.backup ~/.config/nvim
```

---

## Reporting a problem

If none of this helps, open an issue including:

```bash
nvim --version
```

```vim
:checkhealth      " copy the relevant output
:messages         " startup errors
:LspInfo          " if it's an LSP problem
```

Plus the filetype of the file where it happens (`:set filetype?`).

---

[⬅️ Back to the README](../README.md) · [Commands ➡️](commands-and-workflow.md)
