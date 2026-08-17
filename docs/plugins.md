# 🔌 Plugins and Structure

> The 56 plugins in this configuration, what each one does, when it loads, and
> how to add or remove them.

**Manager:** [`lazy.nvim`](https://github.com/folke/lazy.nvim) · **Bootstrap:** [`lua/plugins/init.lua`](../lua/plugins/init.lua)

---

## 📋 Contents

- [File structure](#file-structure)
- [Plugin list](#plugin-list)
- [Performance and lazy-loading](#performance-and-lazy-loading)
- [Adding a plugin](#adding-a-plugin)
- [🚨 Golden rule: keymaps go in `keys`, not `config`](#-golden-rule-keymaps-go-in-keys-not-config)
- [Removing a plugin](#removing-a-plugin)
- [Updating plugins](#updating-plugins)

---

## File structure

```
~/.config/nvim/
├── init.lua                  # entry point: loads the four modules
├── lazy-lock.json            # exact versions (reproducibility)
└── lua/
    ├── config/
    │   ├── user.lua          # ← YOUR settings: projects dir, git branch, name
    │   ├── options.lua       # Vim options (numbers, indentation, timings)
    │   ├── keymaps.lua       # global keymaps (non-plugin)
    │   └── autocmds.lua      # autocommands (auto-save, trailing whitespace)
    └── plugins/
        ├── init.lua          # lazy.nvim bootstrap + imports
        ├── ui.lua            # theme, lualine, colorizer, indent, dropbar, modes
        ├── ui_extra.lua      # Noice, which-key
        ├── editor.lua        # Telescope, NvimTree, Harpoon, Treesitter, Trouble, Spectre
        ├── lsp.lua           # Mason, LSPs, nvim-cmp, conform, snippets
        ├── ai.lua            # Copilot + copilot-cmp
        ├── git.lua           # Fugitive, GitSigns, Diffview, git-conflict, Octo
        ├── terminal.lua      # ToggleTerm, LazyDocker, Live Server, tmux-navigator
        ├── debug.lua         # DAP for Python/Django
        ├── testing.lua       # Neotest (pytest)
        ├── session.lua       # auto-session
        ├── dashboard.lua     # start screen
        └── legendary.lua     # command palette
```

### Why modular

Each file returns a table of lazy.nvim specs and is imported in
[`lua/plugins/init.lua`](../lua/plugins/init.lua). The benefits: you always
know where to look, you can disable a whole category by commenting one
`import`, and merge conflicts stay small.

### Where personal settings live

Everything user-specific — projects directory, git base branch, dashboard name
and banner — lives in [`lua/config/user.lua`](../lua/config/user.lua). No
personal paths are hardcoded anywhere else, so a fresh clone works after
editing that one file.

---

## Plugin list

### 🎨 Interface

| Plugin | What it does | Loads |
|--------|--------------|-------|
| [`nordic.nvim`](https://github.com/AlexvZyl/nordic.nvim) | Color scheme | Immediately (`priority = 1000`) |
| [`lualine.nvim`](https://github.com/nvim-lualine/lualine.nvim) | Statusline: branch, diff, diagnostics | Immediately |
| [`nvim-web-devicons`](https://github.com/nvim-tree/nvim-web-devicons) | Filetype icons | Dependency |
| [`nvim-colorizer.lua`](https://github.com/NvChad/nvim-colorizer.lua) | CSS/hex color previews | `BufReadPre` |
| [`indent-blankline.nvim`](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent guides with rainbow scope | Immediately |
| [`rainbow-delimiters.nvim`](https://github.com/HiPhish/rainbow-delimiters.nvim) | Brackets and tags colored by depth | `BufReadPost` |
| [`dropbar.nvim`](https://github.com/Bekaboo/dropbar.nvim) | Navigable breadcrumbs (`Space+bp`) | `BufReadPre` |
| [`modes.nvim`](https://github.com/mvllow/modes.nvim) | Cursor/line color per vim mode | `BufReadPre` |
| [`tiny-inline-diagnostic.nvim`](https://github.com/rachartier/tiny-inline-diagnostic.nvim) | Readable inline diagnostics | `BufReadPre` |
| [`noice.nvim`](https://github.com/folke/noice.nvim) | Redesigned cmdline, messages and popups | `VeryLazy` |
| [`nvim-notify`](https://github.com/rcarriga/nvim-notify) | Floating notifications | Dependency |
| [`nui.nvim`](https://github.com/MunifTanjim/nui.nvim) | UI components | Dependency |
| [`which-key.nvim`](https://github.com/folke/which-key.nvim) | Shows available keys after a prefix | `VeryLazy` |
| [`dashboard-nvim`](https://github.com/nvimdev/dashboard-nvim) | Start screen | `VimEnter` |

### ✏️ Editor

| Plugin | What it does | Loads |
|--------|--------------|-------|
| [`telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder for files and content | `keys` + `cmd` |
| [`telescope-fzf-native.nvim`](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | Native C sorter (much faster) | Dependency (compiled with `make`) |
| [`nvim-tree.lua`](https://github.com/nvim-tree/nvim-tree.lua) | Side file explorer | `keys` + `cmd` |
| [`harpoon`](https://github.com/ThePrimeagen/harpoon) | Bookmarks for frequent files | `keys` |
| [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter) | Real parsing: highlighting and indentation | Immediately |
| [`flash.nvim`](https://github.com/folke/flash.nvim) | Jump anywhere in two keystrokes (`s`) | `VeryLazy` |
| [`nvim-surround`](https://github.com/kylechui/nvim-surround) | Manipulate quotes, brackets, tags | `VeryLazy` |
| [`Comment.nvim`](https://github.com/numToStr/Comment.nvim) | Comment with `gcc` / `gc` | `BufReadPre` |
| [`nvim-ts-context-commentstring`](https://github.com/JoosepAlviste/nvim-ts-context-commentstring) | Context-correct comments (HTML vs Django vs JS) | Dependency |
| [`nvim-autopairs`](https://github.com/windwp/nvim-autopairs) | Closes brackets, quotes, braces | `InsertEnter` |
| [`todo-comments.nvim`](https://github.com/folke/todo-comments.nvim) | Highlights and finds `TODO`, `FIXME`, `HACK` | `BufReadPre` |
| [`trouble.nvim`](https://github.com/folke/trouble.nvim) | Errors and warnings panel | `keys` + `cmd` |
| [`nvim-spectre`](https://github.com/nvim-pack/nvim-spectre) | Project-wide search and replace | `keys` |
| [`markdown-preview.nvim`](https://github.com/iamcco/markdown-preview.nvim) | Markdown preview in the browser | `ft = markdown` + `keys` |
| [`plenary.nvim`](https://github.com/nvim-lua/plenary.nvim) | Shared Lua utility library | Dependency |
| [`cellular-automaton.nvim`](https://github.com/eandrju/cellular-automaton.nvim) | Pure fun (`Space+fml`) | `keys` + `cmd` |

### 🧠 LSP and completion

| Plugin | What it does | Loads |
|--------|--------------|-------|
| [`nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig) | Language server configuration | `BufReadPre` |
| [`mason.nvim`](https://github.com/mason-org/mason.nvim) | Installs LSPs, linters and debuggers | `cmd` |
| [`mason-lspconfig.nvim`](https://github.com/mason-org/mason-lspconfig.nvim) | Mason ↔ lspconfig bridge, auto-installs servers | Dependency |
| [`nvim-cmp`](https://github.com/hrsh7th/nvim-cmp) | Completion engine | `InsertEnter` |
| [`cmp-nvim-lsp`](https://github.com/hrsh7th/cmp-nvim-lsp) | Source: LSP | Dependency |
| [`cmp-buffer`](https://github.com/hrsh7th/cmp-buffer) | Source: buffer words | Dependency |
| [`cmp-path`](https://github.com/hrsh7th/cmp-path) | Source: filesystem paths | Dependency |
| [`LuaSnip`](https://github.com/L3MON4D3/LuaSnip) | Snippet engine | Dependency |
| [`cmp_luasnip`](https://github.com/saadparwaiz1/cmp_luasnip) | Source: snippets | Dependency |
| [`friendly-snippets`](https://github.com/rafamadriz/friendly-snippets) | Snippet collection (Django, DRF, HTML...) | Dependency |
| [`lspkind.nvim`](https://github.com/onsails/lspkind.nvim) | Kind icons in the cmp menu | Dependency |
| [`conform.nvim`](https://github.com/stevearc/conform.nvim) | Per-filetype formatting with LSP fallback | `keys` |

### 🤖 AI

| Plugin | What it does | Loads |
|--------|--------------|-------|
| [`copilot.lua`](https://github.com/zbirenbaum/copilot.lua) | GitHub Copilot client | `InsertEnter` |
| [`copilot-cmp`](https://github.com/zbirenbaum/copilot-cmp) | Copilot as an nvim-cmp source | Dependency |

Details in **[ai-copilot.md](ai-copilot.md)**.

### 🔀 Git

| Plugin | What it does | Loads |
|--------|--------------|-------|
| [`vim-fugitive`](https://github.com/tpope/vim-fugitive) | Git commands and status panel | `cmd` |
| [`gitsigns.nvim`](https://github.com/lewis6991/gitsigns.nvim) | Gutter changes, per-hunk staging, blame | `BufReadPre` |
| [`diffview.nvim`](https://github.com/sindrets/diffview.nvim) | Branch diffs and file history | `keys` + `cmd` |
| [`git-conflict.nvim`](https://github.com/akinsho/git-conflict.nvim) | Resolve merge conflicts visually | `BufReadPre` |
| [`octo.nvim`](https://github.com/pwntester/octo.nvim) | GitHub PRs and issues | `keys` + `cmd` |

Details in **[git-and-github.md](git-and-github.md)**.

### 🖥️ Terminal and sessions

| Plugin | What it does | Loads |
|--------|--------------|-------|
| [`toggleterm.nvim`](https://github.com/akinsho/toggleterm.nvim) | Integrated terminal + floating LazyDocker and Live Server | Immediately |
| [`vim-tmux-navigator`](https://github.com/christoomey/vim-tmux-navigator) | `Ctrl+hjkl` across Neovim and tmux | Immediately |
| [`auto-session`](https://github.com/rmagatti/auto-session) | Saves/restores a session per folder and branch | Immediately |
| [`legendary.nvim`](https://github.com/mrjones2014/legendary.nvim) | Command palette (`Ctrl+p`) | `VeryLazy` |
| [`sqlite.lua`](https://github.com/kkharji/sqlite.lua) | Legendary persistence | Dependency |

### 🐞 Debug and tests

| Plugin | What it does | Loads |
|--------|--------------|-------|
| [`nvim-dap`](https://github.com/mfussenegger/nvim-dap) | Debug Adapter Protocol client | `keys` |
| [`nvim-dap-ui`](https://github.com/rcarriga/nvim-dap-ui) | Scopes, stacks, breakpoints, REPL panels | Dependency |
| [`nvim-dap-python`](https://github.com/mfussenegger/nvim-dap-python) | Python/debugpy adapter | Dependency |
| [`nvim-dap-virtual-text`](https://github.com/theHamsta/nvim-dap-virtual-text) | Variable values next to each line | Dependency |
| [`neotest`](https://github.com/nvim-neotest/neotest) | Test runner with inline results | `keys` |
| [`neotest-python`](https://github.com/nvim-neotest/neotest-python) | pytest adapter | Dependency |
| [`nvim-nio`](https://github.com/nvim-neotest/nvim-nio) | Async library | Dependency |

Details in **[django.md](django.md#debugger)**.

---

## Performance and lazy-loading

**Current startup: ~60ms** with 56 plugins. Only 12 load at boot; the rest wait
for an event, command or keypress.

### Trigger types

| Trigger | When it loads | Example |
|---------|---------------|---------|
| `keys` | On pressing the shortcut | Telescope, Harpoon, Trouble |
| `cmd` | On running the command | Mason, Fugitive, Octo |
| `ft` | On opening that filetype | markdown-preview |
| `event = "InsertEnter"` | On entering insert mode | nvim-cmp, Copilot, autopairs |
| `event = "BufReadPre"` | On opening a file | LSP, gitsigns, colorizer |
| `event = "VeryLazy"` | After startup finishes | which-key, noice, flash |
| `lazy = false` | Immediately | theme, lualine, treesitter, auto-session |

### Measuring startup

```bash
nvim --startuptime /tmp/start.log +q && tail -1 /tmp/start.log
```

Or inside Neovim:

```vim
:Lazy profile
```

Shows load time per plugin, sorted.

### Disabled Vim plugins

[`lua/plugins/init.lua`](../lua/plugins/init.lua) disables the legacy plugins
we don't use, which otherwise add to startup:

```lua
performance = {
  rtp = {
    disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin", "netrwPlugin" },
  },
},
```

> ⚠️ Disabling `netrwPlugin` means `:Explore` and `gx` (open URL) stop working.
> NvimTree replaces the first; for the second, drop `netrwPlugin` from the list
> or install a URL-opening plugin.

---

## Adding a plugin

**1.** Pick the file matching the category (`editor.lua`, `ui.lua`, `git.lua`...).

**2.** Add the spec:

```lua
return {
  -- ... existing plugins ...

  {
    "author/plugin-name",
    event = "VeryLazy",              -- or cmd / keys / ft
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {                         -- equivalent to require("plugin").setup(opts)
      some_option = true,
    },
  },
}
```

**3.** Restart Neovim. lazy.nvim detects the change and installs it.

**4.** Commit `lazy-lock.json` to pin the installed version.

### `opts` vs `config`

```lua
-- Preferred: opts (cleaner, lazy runs setup for you)
{ "folke/trouble.nvim", opts = { modes = { ... } } }

-- Only when you need extra logic
{
  "folke/trouble.nvim",
  config = function()
    require("trouble").setup({ ... })
    -- something else that doesn't fit in opts
  end,
}
```

---

## 🚨 Golden rule: keymaps go in `keys`, not `config`

**The most common and hardest-to-spot mistake** in lazy-loaded configs.

If a plugin loads on a command and you define its keymaps inside `config`,
those keymaps **don't exist** until the plugin loads... but the plugin doesn't
load until you run the command by hand. Dead keys, with no visible error.

```lua
-- ❌ WRONG: <leader>gd is never registered
{
  "sindrets/diffview.nvim",
  cmd = "DiffviewOpen",
  config = function()
    vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>")
  end,
}

-- ✅ RIGHT: lazy registers the key at startup and loads the plugin on press
{
  "sindrets/diffview.nvim",
  cmd = "DiffviewOpen",
  keys = {
    { "<leader>gd", ":DiffviewOpen<CR>", desc = "Git: Diff" },
  },
}
```

### Valid exceptions

Keymaps in `config` are **fine** when:

- The plugin isn't lazy (`lazy = false`) — e.g. `auto-session`
- It loads on an early event (`BufReadPre`, `VeryLazy`) — e.g. `flash`, `todo-comments`
- They're **buffer-local**, created on attach — e.g. `gitsigns`'s `on_attach`,
  LSP keymaps in `LspAttach`

### Verifying a keymap exists

```vim
:verbose nmap <leader>gd
```

Shows whether it's mapped and from which file. Nothing printed means it's dead.
You can also search for it with `Ctrl+p` (Legendary) or `Space+lk`.

---

## Removing a plugin

**1.** Delete or comment out its block in the matching file.

**2.** Clean up the downloaded files:

```vim
:Lazy clean
```

**3.** If it left documented keymaps or commands behind, update
[`commands-and-workflow.md`](commands-and-workflow.md).

### Disabling a whole category

Comment out the `import` in [`lua/plugins/init.lua`](../lua/plugins/init.lua):

```lua
require("lazy").setup({
    { import = "plugins.ui" },
    -- { import = "plugins.debug" },   -- ← disabled
    { import = "plugins.testing" },
}, { ... })
```

---

## Updating plugins

```vim
:Lazy sync      " update + clean + install missing
:Lazy update    " update only
:Lazy check     " see what's available without applying
```

After updating:

```bash
# Commit the updated lock
git add lazy-lock.json
git commit -m "chore: Update plugin versions"
```

### Rolling back to a working version

```vim
:Lazy restore   " reinstall exactly what lazy-lock.json says
```

That's why `lazy-lock.json` is committed: if an update breaks something,
`git checkout` the lock plus `:Lazy restore` returns you to the previous state.

### Updating Treesitter parsers

```vim
:TSUpdate
```

---

[⬅️ Back to the README](../README.md) · [Troubleshooting ➡️](troubleshooting.md)
