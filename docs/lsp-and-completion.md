# 🧠 LSP, Completion and Formatting

> Code intelligence: definitions, references, diagnostics, snippets and formatting.

**Plugins:** `nvim-lspconfig` · `mason.nvim` (v2) · `nvim-cmp` · `LuaSnip` · `conform.nvim`
**Config file:** [`lua/plugins/lsp.lua`](../lua/plugins/lsp.lua)

---

## 📋 Contents

- [LSP shortcuts](#lsp-shortcuts)
- [Completion](#completion)
- [Included servers](#included-servers)
- [Per-project linters (.venv)](#per-project-linters-venv)
- [Formatting with conform.nvim](#formatting-with-conformnvim)
- [Snippets](#snippets)
- [Diagnostics](#diagnostics)
- [Adding a new server](#adding-a-new-server)
- [Diagnostic commands](#diagnostic-commands)

---

## LSP shortcuts

These are registered per buffer when a server attaches, so they only exist
where an LSP is running.

| Shortcut | Action |
|----------|--------|
| `gd` | **Go to definition** |
| `gr` | **Find references** (where it's used) |
| `gi` | Go to implementation |
| `K` | **Hover**: documentation for the symbol under the cursor |
| `Space+rn` | **Rename** the symbol across the project |
| `Space+ca` | **Code actions**: auto-import, quick fixes |
| `Space+cf` | **Format** (see [conform](#formatting-with-conformnvim)) |
| `]d` / `[d` | Next / previous diagnostic |

### Example: auto-import via code actions

```python
# 1. You write code without the import
User.objects.all()      # 'User' is not imported

# 2. Cursor on "User" → Space+ca
# 3. Pick "Import User from django.contrib.auth.models"
# 4. The import is added at the top automatically
```

### Inlay hints

Enabled automatically on servers that support them: types and parameter names
are shown greyed out inside the code.

---

## Completion

`nvim-cmp` merges four sources into a single menu, by priority:

| Priority | Source | What it provides |
|----------|--------|------------------|
| 1100 |  **Copilot** | AI suggestions ([see doc](ai-copilot.md)) |
| 1000 | **LSP** | Methods, attributes, real types from the project |
| 750 | 󰩫 **LuaSnip** | Snippets (including the Django/DRF ones) |
| 500 | **Buffer** | Words from the current file |
| 250 | **Path** | Filesystem paths |

### Shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl+Space` | Open the menu manually |
| `Tab` | Next entry · or expand/jump inside a snippet |
| `Shift+Tab` | Previous entry · or jump backwards in a snippet |
| `Enter` | Accept the **selected** entry |
| `Ctrl+e` | Close the menu |
| `Ctrl+f` / `Ctrl+b` | Scroll the documentation window |

> 💡 **`Enter` uses `select = false`**: if you didn't select anything with
> `Tab`, it inserts a normal newline. No accidental accepts.

---

## Included servers

Mason installs these automatically on first launch (`ensure_installed`).

| Server | Language / use |
|--------|----------------|
| `pyright` | Python — type checking, navigation |
| `ruff` | Python — linting and formatting (very fast) |
| `html` | HTML and Django templates (`htmldjango`) |
| `cssls` | CSS / SCSS / LESS |
| `ts_ls` | JavaScript / TypeScript / React (JSX, TSX) |
| `emmet_ls` | Emmet: `div.card>ul>li*3` + `Tab` |
| `jsonls` | JSON — with schema validation |
| `yamlls` | YAML |
| `dockerls` | Dockerfile |
| `docker_compose_language_service` | `docker-compose.yml` |
| `nginx_language_server` | `nginx.conf` |

### Why pyright **and** ruff together

They don't overlap, they complement each other:

- **pyright** understands types, resolves imports and powers navigation (`gd`, `gr`)
- **ruff** does near-instant linting and formatting (replaces flake8 + isort + black)

---

## Per-project linters (.venv)

`ruff` is resolved **from `PATH`**, not from a fixed path. That's intentional:

```bash
# Activate the project's venv
cd ~/projects/my-project
source .venv/bin/activate

# Open nvim from there
nvim
```

Neovim now uses **the project's ruff** with its local configuration
(`pyproject.toml`, `ruff.toml`, `setup.cfg`). Every project can have different
rules and it all works without touching the Neovim config.

```toml
# The project's pyproject.toml
[tool.ruff]
line-length = 100

[tool.ruff.lint]
select = ["E", "F", "I", "DJ"]   # DJ = Django rules
```

> ⚠️ If you open Neovim **without** the venv active, ruff falls back to the
> global (Mason) version with its default configuration. Diagnostics may differ.

---

## Formatting with conform.nvim

`Space+cf` formats the whole file, or the selection in visual mode.

| Filetype | Formatter | Fallback |
|----------|-----------|----------|
| `python` | `ruff_format` | LSP |
| `javascript` `typescript` `*react` | `prettierd` → `prettier` | LSP |
| `css` `scss` | `prettierd` → `prettier` | LSP |
| `json` `yaml` | `prettierd` → `prettier` | LSP |
| `htmldjango` | `djlint` | LSP |
| Anything else | — | LSP |

**How the chain works:** conform tries the first formatter in the list; if it
isn't installed it tries the next; if none exist it falls back to
`vim.lsp.buf.format()`. It never leaves the file unformatted.

### Installing the formatters

```bash
# Python + Django templates, inside the project's .venv
pip install ruff djlint

# JS/TS/CSS/JSON, global
npm install -g prettier @fsouza/prettierd
```

### See which formatter would run

```vim
:ConformInfo
```

Lists the formatters available for the current buffer and which one would execute.

### Enabling format-on-save

If you want it, edit [`lua/plugins/lsp.lua`](../lua/plugins/lsp.lua) and add to
conform's `opts`:

```lua
format_on_save = {
  timeout_ms = 500,
  lsp_format = "fallback",
},
```

> It's off by default: in projects with mixed styles, formatting on save
> produces huge diffs in files you only meant to touch slightly.

---

## Snippets

`friendly-snippets` + `LuaSnip`. They appear in the cmp menu tagged **Snippet**.

### Moving inside a snippet

| Shortcut | Action |
|----------|--------|
| `Tab` | Next placeholder |
| `Shift+Tab` | Previous placeholder |

### Django and DRF

Enabled through `filetype_extend`, which makes one filetype inherit another's snippets:

```lua
luasnip.filetype_extend("htmldjango", { "html" })
luasnip.filetype_extend("python", { "django", "django-rest" })
```

That yields **168 snippets** in templates and **191** Django/DRF ones in Python.
The full list is in **[django.md](django.md#snippets)**.

> ⚠️ **Order matters:** `filetype_extend` must be called **before**
> `require("luasnip.loaders.from_vscode").lazy_load()`. The other way around,
> the extended snippets never load.

---

## Diagnostics

Current configuration:

```lua
vim.diagnostic.config({
    virtual_text = false,     -- drawn by tiny-inline-diagnostic instead
    signs = true,             -- icons in the left gutter
    underline = true,
    update_in_insert = false, -- doesn't nag while you type
    severity_sort = true,     -- errors before warnings
})
```

`virtual_text` is off because **`tiny-inline-diagnostic.nvim`** renders the
messages more legibly (the `modern` preset), including the diagnostic source
and multiline support.

### Viewing diagnostics in a panel

| Shortcut | Action |
|----------|--------|
| `Space+xx` | Every error in the project (Trouble) |
| `Space+xf` | Current file only |
| `Space+xq` | Quickfix list |
| `]d` / `[d` | Jump between diagnostics |

---

## Adding a new server

Example with `gopls` (Go), in [`lua/plugins/lsp.lua`](../lua/plugins/lsp.lua):

**1.** Add it to mason-lspconfig's `ensure_installed`:

```lua
ensure_installed = {
  "pyright", "ruff", -- ...
  "gopls",           -- ← new
},
```

**2.** If it needs specific settings, add them inside `nvim-lspconfig`'s `config`:

```lua
vim.lsp.config("gopls", {
    cmd = { "gopls" },
    filetypes = { "go", "gomod" },
    settings = {
        gopls = { analyses = { unusedparams = true } },
    },
})
```

**3.** Restart Neovim. Mason installs it and `automatic_enable` (the v2 default) turns it on.

> 💡 **No `vim.lsp.enable()` needed**: mason-lspconfig v2 automatically enables
> everything it installs. Valid names are in the
> [nvim-lspconfig list](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md).

### Adding a formatter

In conform's `opts`:

```lua
formatters_by_ft = {
  go = { "gofmt" },
},
```

---

## Diagnostic commands

| Command | Purpose |
|---------|---------|
| `:LspInfo` | Servers attached to the current buffer |
| `:LspLog` | LSP error log |
| `:LspRestart` | Restart servers (handy after config changes) |
| `:Mason` | Server manager (`U` = update all) |
| `:ConformInfo` | Available and active formatters |
| `:checkhealth lsp` | LSP subsystem diagnostics |
| `:checkhealth mason` | Verify Mason and its dependencies |

---

[⬅️ Back to the README](../README.md) · [Django and DRF ➡️](django.md)
