# 📦 Full Installation Guide

> Step-by-step setup on Ubuntu/Debian. For the quick version, see the [README](../README.md#-install).

---

## 📋 Contents

- [Prerequisites](#prerequisites)
- [Neovim](#neovim)
- [Search tools](#search-tools)
- [Node.js](#nodejs)
- [Nerd Fonts](#nerd-fonts)
- [Clone the configuration](#clone-the-configuration)
- [Make it yours](#make-it-yours)
- [First launch](#first-launch)
- [Authenticate Copilot](#authenticate-copilot)
- [Optional tools](#optional-tools)
- [Final verification](#final-verification)
- [Uninstall / roll back](#uninstall--roll-back)

---

## Prerequisites

### Update the system

```bash
sudo apt update && sudo apt upgrade -y
```

### Git and a compiler

`build-essential` is **required**: `telescope-fzf-native` and the Treesitter
parsers are compiled during installation.

```bash
sudo apt install git build-essential -y
```

---

## Neovim

> ⚠️ This configuration uses the modern LSP API (`vim.lsp.config` / `vim.lsp.enable`),
> so it needs **Neovim 0.12 or newer**. The versions in Ubuntu's stable repos
> are usually older, which is why we use the PPA.

```bash
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install neovim -y
```

### Verify

```bash
nvim --version
```

**Expected:** `NVIM v0.12.x` or newer.

<details>
<summary>Alternative: install the official AppImage</summary>

```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim
nvim --version
```

</details>

---

## Search tools

Essential for Telescope. `ripgrep` searches file contents, `fd` searches filenames.

```bash
sudo apt install ripgrep fd-find -y

# On Ubuntu the binary is called 'fdfind'; create an 'fd' alias
sudo ln -s /usr/bin/fdfind /usr/local/bin/fd

# Verify
rg --version
fd --version
```

---

## Node.js

Required by Copilot, the web language servers (html, cssls, ts_ls, emmet) and
Markdown Preview.

> ⚠️ **Copilot requires Node 22 or newer.** Ubuntu's `nodejs` package ships
> v18, which is too old — use nvm so you control the version.

**Recommended, with nvm:**

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# Reopen the terminal, then:
nvm install 22
nvm alias default 22

node --version
```

> 💡 **If you use zsh**, the nvm installer usually only writes to `.bashrc`.
> Make sure this block is in your `~/.zshrc`, otherwise your shell (and Neovim)
> will keep using the system Node:
>
> ```bash
> export NVM_DIR="$HOME/.nvm"
> [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
> [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
> ```

---

## Nerd Fonts

Needed for the icons in NvimTree, lualine, the dashboard and the diagnostics.

### Install JetBrainsMono Nerd Font (recommended)

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono
rm JetBrainsMono.zip
fc-cache -fv
```

### Select it in your terminal

1. Open a **new terminal**
2. **Preferences** (`Ctrl + ,`) → **Profiles**
3. Tick **Custom font**
4. Pick **JetBrainsMono Nerd Font**, size 12

### Verify

```bash
echo -e " ±  ➦ ✘ ⚡ ⚙"
```

If you see icons instead of boxes, it works.

<details>
<summary>Alternative fonts</summary>

```bash
cd ~/.local/share/fonts

# FiraCode
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip
unzip FiraCode.zip -d FiraCode && rm FiraCode.zip

# Hack
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip
unzip Hack.zip -d Hack && rm Hack.zip

# CascadiaCode
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/CascadiaCode.zip
unzip CascadiaCode.zip -d CascadiaCode && rm CascadiaCode.zip

fc-cache -fv
```

</details>

---

## Clone the configuration

```bash
# Back up any existing configuration
mv ~/.config/nvim ~/.config/nvim.backup

# Clone
git clone https://github.com/deyby01/deyby-nvim.git ~/.config/nvim
```

> 💡 The repo ships `lazy-lock.json`, which pins the exact version of every
> plugin. Cloning gives you **the same tested setup**, not the latest releases
> (which might contain breaking changes).

---

## Make it yours

Everything personal lives in one file: [`lua/config/user.lua`](../lua/config/user.lua).

```lua
-- Where your projects live (used by the "all projects" pickers and the dashboard)
M.projects_dir = "~/Documents"

-- Base branch the Diffview shortcuts compare against
M.git_base_branch = "development"    -- "main", "develop", ...

-- Dashboard greeting; nil auto-detects your system username
M.name = nil

-- ASCII banner for the dashboard (replace with your own, or use {})
M.dashboard_header = { ... }
```

Nothing else needs editing to get a working setup.

---

## First launch

```bash
nvim
```

**What happens, in order:**

1. `lazy.nvim` installs itself
2. Plugins are downloaded at the versions in `lazy-lock.json`
3. `telescope-fzf-native` is compiled with `make`
4. Treesitter compiles the parsers (python, typescript, htmldjango, docker...)
5. **Mason installs every language server** listed in `ensure_installed` — no manual step needed

⏱️ This takes **2-3 minutes**. When it finishes, quit with `:qa` and reopen.

### Verify everything loaded

```vim
:Lazy         " every plugin should be installed
:Mason        " language servers with a ✓
:checkhealth  " general diagnostics
```

---

## Authenticate Copilot

One time only (requires an active GitHub Copilot subscription).

```vim
:Copilot auth
```

A link and a code appear: paste the code on GitHub, authorize, come back to Neovim.

```vim
:Copilot status   " should report it's online/enabled
```

Details on the integration in **[ai-copilot.md](ai-copilot.md)**.

---

## Optional tools

### tmux (recommended)

For juggling several projects and keeping sessions alive.
Full setup in **[tmux.md](tmux.md)**.

```bash
sudo apt install tmux -y
```

### LazyDocker

Visual Docker interface, reachable with `Space+ld`.

```bash
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
lazydocker --version
```

### GitHub CLI (for Octo)

Required to manage PRs and issues from Neovim.

```bash
sudo apt install gh -y
gh auth login
```

### Formatters for conform.nvim

Conform looks for these on `PATH` and falls back to the LSP when they're missing.

```bash
# Per project, inside the .venv (recommended)
pip install ruff djlint

# Global, for JS/TS/CSS/JSON
npm install -g prettier @fsouza/prettierd
```

### Python debugger

```vim
:MasonInstall debugpy
```

### Live Server (HTML/CSS preview)

Nothing to install — `Space+lv` runs it through `npx`. If you'd rather have it
installed permanently:

```bash
npm install -g live-server
```

---

## Final verification

```bash
nvim --version       # >= 0.12
rg --version
fd --version
node --version       # >= 22
gcc --version
git --version
tmux -V              # optional
lazydocker --version # optional
gh --version         # optional
```

### Try it inside Neovim

| Check | How |
|-------|-----|
| Find files | `Space+ff` |
| Explorer | `Space+e` |
| Terminal | `Ctrl+´` |
| LSP + Copilot | Open a `.py`, type, and watch the menu (Copilot's  should appear) |
| Django snippets | In a template, type `block` and accept |
| Git | `Space+gs` |
| Command palette | `Ctrl+p` |

If anything fails, see **[troubleshooting.md](troubleshooting.md)**.

---

## Uninstall / roll back

```bash
# Restore your previous configuration
rm -rf ~/.config/nvim
mv ~/.config/nvim.backup ~/.config/nvim

# Clear plugins, state and cache
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```

---

[⬅️ Back to the README](../README.md) · [Commands ➡️](commands-and-workflow.md)
