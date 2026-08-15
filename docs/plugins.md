# 🔌 Plugins y Estructura

> Los 56 plugins de esta configuración, qué hace cada uno, cuándo carga y cómo
> agregar o quitar.

**Gestor:** [`lazy.nvim`](https://github.com/folke/lazy.nvim) · **Bootstrap:** [`lua/plugins/init.lua`](../lua/plugins/init.lua)

---

## 📋 Contenido

- [Estructura de archivos](#estructura-de-archivos)
- [Lista de plugins](#lista-de-plugins)
- [Rendimiento y lazy-loading](#rendimiento-y-lazy-loading)
- [Agregar un plugin](#agregar-un-plugin)
- [🚨 Regla de oro: atajos en `keys`](#-regla-de-oro-atajos-en-keys-no-en-config)
- [Quitar un plugin](#quitar-un-plugin)
- [Actualizar plugins](#actualizar-plugins)

---

## Estructura de archivos

```
~/.config/nvim/
├── init.lua                  # Punto de entrada: carga los 4 módulos
├── lazy-lock.json            # Versiones exactas (reproducibilidad)
└── lua/
    ├── config/
    │   ├── options.lua       # Opciones de Vim (números, indentación, tiempos)
    │   ├── keymaps.lua       # Atajos globales (no de plugins)
    │   └── autocmds.lua      # Autocomandos (autoguardado, trailing spaces)
    └── plugins/
        ├── init.lua          # Bootstrap de lazy.nvim + imports
        ├── ui.lua            # Tema, lualine, colorizer, indent, dropbar, modes
        ├── ui_extra.lua      # Noice, which-key
        ├── editor.lua        # Telescope, NvimTree, Harpoon, Treesitter, Trouble, Spectre
        ├── lsp.lua           # Mason, LSPs, nvim-cmp, conform, snippets
        ├── ai.lua            # Copilot + copilot-cmp
        ├── git.lua           # Fugitive, GitSigns, Diffview, git-conflict, Octo
        ├── terminal.lua      # ToggleTerm, LazyDocker, Live Server, tmux-navigator
        ├── debug.lua         # DAP para Python/Django
        ├── testing.lua       # Neotest (pytest)
        ├── session.lua       # auto-session
        ├── dashboard.lua     # Pantalla de inicio
        └── legendary.lua     # Paleta de comandos
```

### Por qué modular

Cada archivo devuelve una tabla de especificaciones de lazy.nvim y se importa en
[`lua/plugins/init.lua`](../lua/plugins/init.lua). Ventajas: sabes exactamente
dónde buscar, puedes desactivar una categoría completa comentando un `import`, y
los conflictos de merge son mínimos.

---

## Lista de plugins

### 🎨 Interfaz

| Plugin | Qué hace | Carga |
|--------|----------|-------|
| [`dracula/vim`](https://github.com/dracula/vim) | Tema de colores | Inmediato (`priority = 1000`) |
| [`lualine.nvim`](https://github.com/nvim-lualine/lualine.nvim) | Barra de estado: rama, diff, diagnósticos | Inmediato |
| [`nvim-web-devicons`](https://github.com/nvim-tree/nvim-web-devicons) | Iconos por tipo de archivo | Dependencia |
| [`nvim-colorizer.lua`](https://github.com/NvChad/nvim-colorizer.lua) | Preview de colores CSS/hex | `BufReadPre` |
| [`indent-blankline.nvim`](https://github.com/lukas-reineke/indent-blankline.nvim) | Guías de indentación con scope arcoíris | Inmediato |
| [`rainbow-delimiters.nvim`](https://github.com/HiPhish/rainbow-delimiters.nvim) | Paréntesis y tags por color de nivel | `BufReadPost` |
| [`dropbar.nvim`](https://github.com/Bekaboo/dropbar.nvim) | Breadcrumbs navegables (`Espacio+bp`) | `BufReadPre` |
| [`modes.nvim`](https://github.com/mvllow/modes.nvim) | Color de cursor/línea según el modo | `BufReadPre` |
| [`tiny-inline-diagnostic.nvim`](https://github.com/rachartier/tiny-inline-diagnostic.nvim) | Diagnósticos inline legibles | `BufReadPre` |
| [`noice.nvim`](https://github.com/folke/noice.nvim) | Rediseño de cmdline, mensajes y popups | `VeryLazy` |
| [`nvim-notify`](https://github.com/rcarriga/nvim-notify) | Notificaciones flotantes | Dependencia |
| [`nui.nvim`](https://github.com/MunifTanjim/nui.nvim) | Componentes UI | Dependencia |
| [`which-key.nvim`](https://github.com/folke/which-key.nvim) | Muestra atajos disponibles al pulsar el prefijo | `VeryLazy` |
| [`dashboard-nvim`](https://github.com/nvimdev/dashboard-nvim) | Pantalla de inicio | `VimEnter` |

### ✏️ Editor

| Plugin | Qué hace | Carga |
|--------|----------|-------|
| [`telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder de archivos y contenido | `keys` + `cmd` |
| [`telescope-fzf-native.nvim`](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | Ordenador nativo en C (mucho más rápido) | Dependencia (compila con `make`) |
| [`nvim-tree.lua`](https://github.com/nvim-tree/nvim-tree.lua) | Explorador de archivos lateral | `keys` + `cmd` |
| [`harpoon`](https://github.com/ThePrimeagen/harpoon) | Marcadores de archivos frecuentes | `keys` |
| [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter) | Parsing real del código: highlighting e indentación | Inmediato |
| [`flash.nvim`](https://github.com/folke/flash.nvim) | Salto a cualquier punto con 2 teclas (`s`) | `VeryLazy` |
| [`nvim-surround`](https://github.com/kylechui/nvim-surround) | Manipular comillas, paréntesis, tags | `VeryLazy` |
| [`Comment.nvim`](https://github.com/numToStr/Comment.nvim) | Comentar con `gcc` / `gc` | `BufReadPre` |
| [`nvim-ts-context-commentstring`](https://github.com/JoosepAlviste/nvim-ts-context-commentstring) | Comentario correcto según el contexto (HTML vs Django vs JS) | Dependencia |
| [`nvim-autopairs`](https://github.com/windwp/nvim-autopairs) | Cierra paréntesis, comillas, llaves | `InsertEnter` |
| [`todo-comments.nvim`](https://github.com/folke/todo-comments.nvim) | Resalta y busca `TODO`, `FIXME`, `HACK` | `BufReadPre` |
| [`trouble.nvim`](https://github.com/folke/trouble.nvim) | Panel de errores y warnings | `keys` + `cmd` |
| [`nvim-spectre`](https://github.com/nvim-pack/nvim-spectre) | Buscar y reemplazar en todo el proyecto | `keys` |
| [`markdown-preview.nvim`](https://github.com/iamcco/markdown-preview.nvim) | Preview de Markdown en el navegador | `ft = markdown` |
| [`plenary.nvim`](https://github.com/nvim-lua/plenary.nvim) | Librería base de utilidades Lua | Dependencia |
| [`cellular-automaton.nvim`](https://github.com/eandrju/cellular-automaton.nvim) | Puro entretenimiento (`Espacio+fml`) | `keys` + `cmd` |

### 🧠 LSP y autocompletado

| Plugin | Qué hace | Carga |
|--------|----------|-------|
| [`nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig) | Configuración de servidores LSP | `BufReadPre` |
| [`mason.nvim`](https://github.com/mason-org/mason.nvim) | Instalador de LSPs, linters y debuggers | `cmd` |
| [`mason-lspconfig.nvim`](https://github.com/mason-org/mason-lspconfig.nvim) | Puente Mason ↔ lspconfig, auto-instala servidores | Dependencia |
| [`nvim-cmp`](https://github.com/hrsh7th/nvim-cmp) | Motor de autocompletado | `InsertEnter` |
| [`cmp-nvim-lsp`](https://github.com/hrsh7th/cmp-nvim-lsp) | Fuente: LSP | Dependencia |
| [`cmp-buffer`](https://github.com/hrsh7th/cmp-buffer) | Fuente: palabras del buffer | Dependencia |
| [`cmp-path`](https://github.com/hrsh7th/cmp-path) | Fuente: rutas de archivos | Dependencia |
| [`LuaSnip`](https://github.com/L3MON4D3/LuaSnip) | Motor de snippets | Dependencia |
| [`cmp_luasnip`](https://github.com/saadparwaiz1/cmp_luasnip) | Fuente: snippets | Dependencia |
| [`friendly-snippets`](https://github.com/rafamadriz/friendly-snippets) | Colección de snippets (Django, DRF, HTML...) | Dependencia |
| [`lspkind.nvim`](https://github.com/onsails/lspkind.nvim) | Iconos por tipo en el menú de cmp | Dependencia |
| [`conform.nvim`](https://github.com/stevearc/conform.nvim) | Formateo por filetype con fallback al LSP | `keys` |

### 🤖 IA

| Plugin | Qué hace | Carga |
|--------|----------|-------|
| [`copilot.lua`](https://github.com/zbirenbaum/copilot.lua) | Cliente de GitHub Copilot | `InsertEnter` |
| [`copilot-cmp`](https://github.com/zbirenbaum/copilot-cmp) | Copilot como fuente de nvim-cmp | Dependencia |

Detalles en **[ai-copilot.md](ai-copilot.md)**.

### 🔀 Git

| Plugin | Qué hace | Carga |
|--------|----------|-------|
| [`vim-fugitive`](https://github.com/tpope/vim-fugitive) | Comandos de Git y panel de status | `cmd` |
| [`gitsigns.nvim`](https://github.com/lewis6991/gitsigns.nvim) | Cambios en la columna, stage por hunk, blame | `BufReadPre` |
| [`diffview.nvim`](https://github.com/sindrets/diffview.nvim) | Diffs entre ramas e historial de archivos | `keys` + `cmd` |
| [`git-conflict.nvim`](https://github.com/akinsho/git-conflict.nvim) | Resolver conflictos de merge visualmente | `BufReadPre` |
| [`octo.nvim`](https://github.com/pwntester/octo.nvim) | PRs e Issues de GitHub | `keys` + `cmd` |

Detalles en **[git-and-github.md](git-and-github.md)**.

### 🖥️ Terminal y sesiones

| Plugin | Qué hace | Carga |
|--------|----------|-------|
| [`toggleterm.nvim`](https://github.com/akinsho/toggleterm.nvim) | Terminal integrada + LazyDocker y Live Server flotantes | Inmediato |
| [`vim-tmux-navigator`](https://github.com/christoomey/vim-tmux-navigator) | `Ctrl+hjkl` entre Neovim y tmux | Inmediato |
| [`auto-session`](https://github.com/rmagatti/auto-session) | Guarda/restaura sesión por carpeta y rama | Inmediato |
| [`legendary.nvim`](https://github.com/mrjones2014/legendary.nvim) | Paleta de comandos (`Ctrl+p`) | `VeryLazy` |
| [`sqlite.lua`](https://github.com/kkharji/sqlite.lua) | Persistencia de Legendary | Dependencia |

### 🐞 Debug y tests

| Plugin | Qué hace | Carga |
|--------|----------|-------|
| [`nvim-dap`](https://github.com/mfussenegger/nvim-dap) | Cliente de Debug Adapter Protocol | `keys` |
| [`nvim-dap-ui`](https://github.com/rcarriga/nvim-dap-ui) | Paneles de scopes, stacks, breakpoints, REPL | Dependencia |
| [`nvim-dap-python`](https://github.com/mfussenegger/nvim-dap-python) | Adaptador de Python/debugpy | Dependencia |
| [`nvim-dap-virtual-text`](https://github.com/theHamsta/nvim-dap-virtual-text) | Valor de las variables junto a cada línea | Dependencia |
| [`neotest`](https://github.com/nvim-neotest/neotest) | Runner de tests con resultados inline | `keys` |
| [`neotest-python`](https://github.com/nvim-neotest/neotest-python) | Adaptador de pytest | Dependencia |
| [`nvim-nio`](https://github.com/nvim-neotest/nvim-nio) | Librería async | Dependencia |

Detalles en **[django.md](django.md#debugger)**.

---

## Rendimiento y lazy-loading

**Arranque actual: ~63ms** con 56 plugins. Solo 12 cargan al inicio; el resto
espera un evento, comando o atajo.

### Tipos de trigger

| Trigger | Cuándo carga | Ejemplo |
|---------|--------------|---------|
| `keys` | Al pulsar el atajo | Telescope, Harpoon, Trouble |
| `cmd` | Al ejecutar el comando | Mason, Fugitive, Octo |
| `ft` | Al abrir ese filetype | markdown-preview |
| `event = "InsertEnter"` | Al entrar a modo insert | nvim-cmp, Copilot, autopairs |
| `event = "BufReadPre"` | Al abrir un archivo | LSP, gitsigns, colorizer |
| `event = "VeryLazy"` | Tras terminar el arranque | which-key, noice, flash |
| `lazy = false` | Inmediato | tema, lualine, treesitter, auto-session |

### Medir el arranque

```bash
nvim --startuptime /tmp/start.log +q && tail -1 /tmp/start.log
```

O dentro de Neovim:

```vim
:Lazy profile
```

Muestra el tiempo de carga por plugin, ordenado.

### Plugins de Vim desactivados

En [`lua/plugins/init.lua`](../lua/plugins/init.lua) se desactivan los plugins
heredados que no se usan y que suman al arranque:

```lua
performance = {
  rtp = {
    disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin", "netrwPlugin" },
  },
},
```

> ⚠️ `netrwPlugin` desactivado significa que `:Explore` y `gx` (abrir URL) no
> funcionan. NvimTree reemplaza al primero; para el segundo, quita `netrwPlugin`
> de la lista o instala un plugin de URLs.

---

## Agregar un plugin

**1.** Elige el archivo por categoría (`editor.lua`, `ui.lua`, `git.lua`...).

**2.** Agrega la especificación:

```lua
return {
  -- ... plugins existentes ...

  {
    "autor/nombre-plugin",
    event = "VeryLazy",              -- o cmd / keys / ft
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {                         -- equivale a require("plugin").setup(opts)
      alguna_opcion = true,
    },
  },
}
```

**3.** Reinicia Neovim. lazy.nvim detecta el cambio e instala.

**4.** Commitea `lazy-lock.json` para fijar la versión instalada.

### `opts` vs `config`

```lua
-- Preferido: opts (más limpio, lazy hace el setup)
{ "folke/trouble.nvim", opts = { modes = { ... } } }

-- Solo si necesitas lógica extra
{
  "folke/trouble.nvim",
  config = function()
    require("trouble").setup({ ... })
    -- algo más que no cabe en opts
  end,
}
```

---

## 🚨 Regla de oro: atajos en `keys`, no en `config`

**El error más común y difícil de detectar** en configs con lazy-loading.

Si un plugin carga por comando y defines sus atajos dentro de `config`, esos
atajos **no existen** hasta que el plugin cargue... pero el plugin no carga hasta
que ejecutes el comando a mano. Atajos muertos, sin ningún error visible.

```lua
-- ❌ MAL: <leader>gd nunca se registra
{
  "sindrets/diffview.nvim",
  cmd = "DiffviewOpen",
  config = function()
    vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>")
  end,
}

-- ✅ BIEN: lazy registra el atajo al arrancar y carga el plugin al pulsarlo
{
  "sindrets/diffview.nvim",
  cmd = "DiffviewOpen",
  keys = {
    { "<leader>gd", ":DiffviewOpen<CR>", desc = "Git: Diff" },
  },
}
```

### Excepciones válidas

Atajos en `config` **está bien** cuando:

- El plugin no es lazy (`lazy = false`) — ej. `auto-session`
- Carga por evento temprano (`BufReadPre`, `VeryLazy`) — ej. `flash`, `todo-comments`
- Son **buffer-local** creados al adjuntarse — ej. `gitsigns` en `on_attach`,
  keymaps de LSP en `LspAttach`

### Verificar que un atajo existe

```vim
:verbose nmap <leader>gd
```

Muestra si está mapeado y desde qué archivo. Si no aparece nada, está muerto.
También puedes buscarlo con `Ctrl+p` (Legendary) o `Espacio+lk`.

---

## Quitar un plugin

**1.** Borra o comenta su bloque en el archivo correspondiente.

**2.** Limpia los archivos descargados:

```vim
:Lazy clean
```

**3.** Si dejó atajos o comandos documentados, actualiza
[`commands-and-workflow.md`](commands-and-workflow.md).

### Desactivar una categoría completa

Comenta el `import` en [`lua/plugins/init.lua`](../lua/plugins/init.lua):

```lua
require("lazy").setup({
    { import = "plugins.ui" },
    -- { import = "plugins.debug" },   -- ← desactivado
    { import = "plugins.testing" },
}, { ... })
```

---

## Actualizar plugins

```vim
:Lazy sync      " actualizar + limpiar + instalar faltantes
:Lazy update    " solo actualizar
:Lazy check     " ver qué hay disponible sin aplicar
```

Después de actualizar:

```bash
# Commitear el lock actualizado
git add lazy-lock.json
git commit -m "chore: Update plugin versions"
```

### Volver a una versión que funcionaba

```vim
:Lazy restore   " reinstala exactamente lo que dice lazy-lock.json
```

Por eso `lazy-lock.json` está en el repo: si una actualización rompe algo,
`git checkout` del lock + `:Lazy restore` te devuelve al estado anterior.

### Actualizar parsers de Treesitter

```vim
:TSUpdate
```

---

[⬅️ Volver al README](../README.md) · [Solución de problemas ➡️](troubleshooting.md)
