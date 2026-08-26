<div align="center">

# ⚡ Neovim IDE — Python · Django · React

**A modular Neovim setup, ready for modern web development.**
Starts in ~45ms, with AI in the completion menu, automatic LSP install and the whole Git workflow without leaving the editor.

[![Neovim](https://img.shields.io/badge/Neovim-0.12%2B-57A143?style=flat-square&logo=neovim&logoColor=white)](https://neovim.io)
[![Lua](https://img.shields.io/badge/Lua-2C2D72?style=flat-square&logo=lua&logoColor=white)](https://www.lua.org)
[![lazy.nvim](https://img.shields.io/badge/lazy.nvim-managed-blueviolet?style=flat-square)](https://github.com/folke/lazy.nvim)
[![Startup](https://img.shields.io/badge/startup-~45ms-success?style=flat-square)](docs/plugins.md#performance-and-lazy-loading)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-20.04%2B-E95420?style=flat-square&logo=ubuntu&logoColor=white)](https://ubuntu.com)

[Install](#-install) · [Features](#-features) · [Commands](#-essential-commands) · [Docs](#-documentation)

</div>

---

## 🎯 Who this is for

Built for developers working with **Python/Django/DRF**,
**JavaScript/TypeScript/React**, **Docker** and **nginx**. If your stack is
different it still works as a base: adding a language server is a one-line
change ([how](docs/lsp-and-completion.md#adding-a-new-server)).

Everything personal lives in a single file — [`lua/config/user.lua`](lua/config/user.lua) —
so cloning and making it yours takes about a minute.

---

## ✨ Features

| | |
|---|---|
| ⚡ **~45ms startup** | 63 plugins, only 14 load at boot |
| 🤖 **Copilot inside completion** | AI suggestions appear in the same menu as the LSP, not as separate ghost text |
| 🧠 **11 LSPs, installed for you** | Mason sets them up on first launch |
| 🐍 **Django and DRF snippets** | `model`, `serializer`, `{% block %}`, `{% for %}`... ~360 in total |
| 🪄 **Per-project formatting** | Uses the ruff/prettier from your `.venv`, falling back to the LSP |
| 🐞 **Django debugger** | Real breakpoints in views, with `manage.py runserver` |
| 🔀 **Complete Git workflow** | Status, hunks, branch diffs, conflicts, PRs and reviews |
| 🖥️ **Live preview** | Docker containers and HTML/CSS live-reload, without leaving nvim |
| ✅ **No key collisions** | Every shortcut verified — none shadows another |

---

## 📋 Requirements

| Requirement | Minimum | Why |
|-------------|---------|-----|
| **Neovim** | 0.12+ | Required by nvim-treesitter `main`; also the modern `vim.lsp.config` API |
| **build-essential** | — | Compiles `fzf-native` and the Treesitter parsers |
| **tree-sitter-cli** | 0.26.1+ | nvim-treesitter `main` builds parsers with it (package manager, not npm) |
| **Node.js** | 22+ | Copilot requires it; also powers the web LSPs |
| **ripgrep** + **fd** | — | Telescope searching |
| **A Nerd Font** | — | Interface icons |

Optional: `tmux`, `lazydocker`, `gh` (for PRs), an active GitHub Copilot subscription.

---

## 🚀 Install

### 1. Dependencies

```bash
sudo apt update && sudo apt install -y git build-essential ripgrep fd-find
sudo ln -s /usr/bin/fdfind /usr/local/bin/fd
```

### 2. Neovim 0.12+

```bash
sudo add-apt-repository ppa:neovim-ppa/unstable -y && sudo apt update && sudo apt install neovim -y
```

### 3. Node.js 22+

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash && nvm install 22
```

### 4. A Nerd Font

```bash
mkdir -p ~/.local/share/fonts && cd ~/.local/share/fonts \
  && wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip \
  && unzip JetBrainsMono.zip -d JetBrainsMono && rm JetBrainsMono.zip && fc-cache -fv
```

Then select it in your terminal preferences.

### 5. Clone the config

```bash
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null; git clone https://github.com/deyby01/deyby-nvim.git ~/.config/nvim
```

### 6. Make it yours

Open [`lua/config/user.lua`](lua/config/user.lua) and set your projects folder
and your default git branch. That's the only file you need to touch.

```lua
M.projects_dir    = "~/Documents"   -- where you keep your code
M.git_base_branch = "development"   -- "main", "develop", ...
```

### 7. First launch

```bash
nvim
```

Give it 2-3 minutes: plugins install, parsers compile and **Mason installs the
11 language servers automatically**. Quit with `:qa` and reopen.

### 8. Authenticate Copilot (optional)

```vim
:Copilot auth
```

> 📖 **Step-by-step guide, alternatives and verification:** [docs/installation.md](docs/installation.md)

---

## 🔑 Essential commands

**Leader key:** `Space`

### The basics

| Shortcut | Action |
|----------|--------|
| `Space+ff` | Find files |
| `Space+fg` | Search text in the project |
| `Space+e` | File explorer |
| `Space+gs` | Git status |
| `Space+ld` | Docker: containers and logs (LazyDocker) |
| `Space+lv` | Live Server: HTML/CSS preview with auto-reload |
| `Space+Rs` | Send the HTTP request under the cursor (REST client) |
| `Ctrl+´` | Integrated terminal |
| `Ctrl+s` / `Ctrl+q` | Save / quit without saving |
| `jk` | Leave insert mode |
| `Ctrl+p` | **Search any command** (when you forget a shortcut) |

### Code

| Shortcut | Action |
|----------|--------|
| `gd` / `gr` | Go to definition / find references |
| `K` | Symbol documentation |
| `Space+ca` | Code actions (auto-import, quick fixes) |
| `Space+cf` | Format |
| `Space+rn` | Rename across the project |
| `Space+xx` | Diagnostics panel |
| `Tab` / `Enter` | Navigate / accept completion |

### Fast movement

| Shortcut | Action |
|----------|--------|
| `s` + 2 letters | Jump anywhere on screen |
| `Space+a` | Mark file (Harpoon) |
| `Space+1..4` | Jump to a marked file |
| `Ctrl+h/j/k/l` | Move between splits and tmux panes |

> 💡 **Nothing to memorize:** press `Space` and wait — which-key lists the
> options. Or hit `Ctrl+p` to search commands by name.

> 📖 **Every shortcut, grouped by tool:** [docs/commands-and-workflow.md](docs/commands-and-workflow.md)
> The REST client keymaps live in [docs/rest-client.md](docs/rest-client.md).

---

## 📚 Documentation

| Document | Contents |
|----------|----------|
| 📦 **[Installation](docs/installation.md)** | Step-by-step setup, optional tools, verification and how to roll back |
| ⌨️ **[Command reference](docs/commands-and-workflow.md)** | Every shortcut grouped by tool, plus an alphabetical cheatsheet |
| 🔁 **[Daily routine](docs/daily-routine.md)** | A developer's real flows: exploring code, debugging, committing, reviewing PRs |
| 🤖 **[AI — Copilot](docs/ai-copilot.md)** | cmp integration, filetypes, privacy and free alternatives |
| 🧠 **[LSP and completion](docs/lsp-and-completion.md)** | Servers, per-`.venv` linters, formatting and snippets |
| 🐍 **[Django and DRF](docs/django.md)** | Snippets, templates, debugger and tests |
| 🔀 **[Git and GitHub](docs/git-and-github.md)** | Fugitive, GitSigns, Diffview, conflicts and Octo |
| 🔌 **[REST client](docs/rest-client.md)** | Testing DRF APIs from `.http` files, environments and auth |
| 🖥️ **[tmux](docs/tmux.md)** | Setup, sessions and unified navigation |
| 🔌 **[Plugins](docs/plugins.md)** | All 63 plugins, structure, lazy-loading and how to add or remove |
| 🐛 **[Troubleshooting](docs/troubleshooting.md)** | Diagnosing the most common failures |

---

## 📁 Structure

```
~/.config/nvim/
├── init.lua              # entry point
├── lazy-lock.json        # exact plugin versions
├── lua/
│   ├── config/
│   │   ├── user.lua      # ← the only file you need to edit
│   │   ├── options.lua
│   │   ├── keymaps.lua
│   │   └── autocmds.lua
│   └── plugins/          # one file per category (ui, editor, lsp, git, ...)
└── docs/                 # this documentation
```

Each file under `lua/plugins/` covers one category: commenting out an `import`
in `lua/plugins/init.lua` disables that whole group.

> 📖 **What each module does:** [docs/plugins.md](docs/plugins.md#file-structure)

---

## 🔧 Customizing

**Your settings:** everything personal — projects folder, git base branch,
dashboard banner and name — lives in [`lua/config/user.lua`](lua/config/user.lua).

**Change the theme:** edit `lua/plugins/ui.lua`.

**Add a language:** add the server to `ensure_installed` in
`lua/plugins/lsp.lua` — Mason installs and enables it for you.

**Add a plugin:** create it in the file matching its category under `lua/plugins/`.

> ⚠️ **If the plugin ships keymaps, put them in `keys`, not inside `config`** —
> otherwise they silently never register. The full explanation is in
> [docs/plugins.md](docs/plugins.md#-golden-rule-keymaps-go-in-keys-not-config).

---

## 🔄 Staying up to date

Since `~/.config/nvim` **is** the cloned repository, updating is a `git pull`:

```bash
cd ~/.config/nvim && git pull
```

### Monthly routine

| What | How |
|------|-----|
| **Neovim** | `sudo apt update && sudo apt upgrade neovim -y` |
| **Plugins** | `:Lazy sync` — then commit `lazy-lock.json` |
| **LSPs** | `:Mason` → press `U` |
| **Treesitter** | `:TSUpdate` |

`lazy-lock.json` pins exact versions: commit it after each `:Lazy sync` so the
setup stays reproducible across machines. If an update breaks something,
`:Lazy restore` puts you back on the locked versions.

---

## 🤝 Contributing

Issues and PRs are welcome. If something doesn't work in your environment,
check **[troubleshooting.md](docs/troubleshooting.md)** first and include the
output of `nvim --version` and `:checkhealth` in the issue.

---

<div align="center">

**If this helped, leave a ⭐**

Built with ☕ by [deyby01](https://github.com/deyby01)

</div>
