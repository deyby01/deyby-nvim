# 🧠 LSP, Autocompletado y Formateo

> Inteligencia de código: definiciones, referencias, diagnósticos, snippets y formateo.

**Plugins:** `nvim-lspconfig` · `mason.nvim` (v2) · `nvim-cmp` · `LuaSnip` · `conform.nvim`
**Archivo de config:** [`lua/plugins/lsp.lua`](../lua/plugins/lsp.lua)

---

## 📋 Contenido

- [Atajos de LSP](#atajos-de-lsp)
- [Autocompletado](#autocompletado)
- [Servidores incluidos](#servidores-incluidos)
- [Linters por proyecto (.venv)](#linters-por-proyecto-venv)
- [Formateo con conform.nvim](#formateo-con-conformnvim)
- [Snippets](#snippets)
- [Diagnósticos](#diagnósticos)
- [Agregar un servidor nuevo](#agregar-un-servidor-nuevo)
- [Comandos de diagnóstico](#comandos-de-diagnóstico)

---

## Atajos de LSP

Se registran automáticamente cuando un servidor se adjunta al buffer (`LspAttach`),
así que solo existen donde hay LSP activo.

| Atajo | Acción |
|-------|--------|
| `gd` | **Ir a la definición** |
| `gr` | **Ver referencias** (dónde se usa) |
| `gi` | Ir a la implementación |
| `K` | **Hover**: documentación del símbolo bajo el cursor |
| `Espacio+rn` | **Renombrar** el símbolo en todo el proyecto |
| `Espacio+ca` | **Code actions**: auto-import, quick fixes |
| `Espacio+cf` | **Formatear** (ver [conform](#formateo-con-conformnvim)) |
| `]d` / `[d` | Siguiente / anterior diagnóstico |

### Ejemplo: auto-import con code actions

```python
# 1. Escribes código sin el import
User.objects.all()      # 'User' no está importado

# 2. Cursor sobre "User" → Espacio+ca
# 3. Eliges "Import User from django.contrib.auth.models"
# 4. El import se agrega arriba automáticamente
```

### Inlay hints

Se activan solos en los servidores que los soportan: muestran tipos y nombres
de parámetros en gris dentro del código.

---

## Autocompletado

`nvim-cmp` unifica cuatro fuentes en un solo menú, por prioridad:

| Prioridad | Fuente | Qué aporta |
|-----------|--------|------------|
| 1100 |  **Copilot** | Sugerencias de IA ([ver doc](ai-copilot.md)) |
| 1000 | **LSP** | Métodos, atributos, tipos reales del proyecto |
| 750 | 󰩫 **LuaSnip** | Snippets (incluidos los de Django/DRF) |
| 500 | **Buffer** | Palabras del archivo actual |
| 250 | **Path** | Rutas de archivos |

### Atajos

| Atajo | Acción |
|-------|--------|
| `Ctrl+Space` | Abrir el menú manualmente |
| `Tab` | Siguiente opción · o expandir/saltar en un snippet |
| `Shift+Tab` | Opción anterior · o saltar atrás en un snippet |
| `Enter` | Aceptar la opción **seleccionada** |
| `Ctrl+e` | Cerrar el menú |
| `Ctrl+f` / `Ctrl+b` | Scroll en la ventana de documentación |

> 💡 **`Enter` usa `select = false`**: si no seleccionaste con `Tab`, hace un
> salto de línea normal. Evita aceptar sugerencias que no querías.

---

## Servidores incluidos

Mason los instala automáticamente en la primera ejecución (`ensure_installed`).

| Servidor | Lenguaje / Uso |
|----------|----------------|
| `pyright` | Python — type checking, navegación |
| `ruff` | Python — linting y formateo (ultrarrápido) |
| `html` | HTML y templates de Django (`htmldjango`) |
| `cssls` | CSS / SCSS / LESS |
| `ts_ls` | JavaScript / TypeScript / React (JSX, TSX) |
| `emmet_ls` | Emmet: `div.card>ul>li*3` + `Tab` |
| `jsonls` | JSON — con validación de schemas |
| `yamlls` | YAML |
| `dockerls` | Dockerfile |
| `docker_compose_language_service` | `docker-compose.yml` |
| `nginx_language_server` | `nginx.conf` |

### Por qué pyright **y** ruff juntos

No se solapan, se complementan:

- **pyright** entiende tipos, resuelve imports y navega el código (`gd`, `gr`)
- **ruff** hace linting y formateo casi instantáneo (reemplaza flake8 + isort + black)

---

## Linters por proyecto (.venv)

`ruff` se resuelve **desde el `PATH`**, no con una ruta fija. Esto es intencional:

```bash
# Activas el venv del proyecto
cd ~/Documents/mi-proyecto
source .venv/bin/activate

# Abres nvim desde ahí
nvim
```

Ahora Neovim usa **el ruff del proyecto** con su configuración local
(`pyproject.toml`, `ruff.toml`, `setup.cfg`). Cada proyecto puede tener reglas
distintas y todo funciona sin tocar la config de Neovim.

```toml
# pyproject.toml del proyecto
[tool.ruff]
line-length = 100

[tool.ruff.lint]
select = ["E", "F", "I", "DJ"]   # DJ = reglas de Django
```

> ⚠️ Si abres Neovim **sin** el venv activado, ruff usará la versión global
> (la de Mason) con su config por defecto. Los diagnósticos pueden diferir.

---

## Formateo con conform.nvim

`Espacio+cf` formatea el archivo completo, o la selección en modo visual.

| Filetype | Formatter | Fallback |
|----------|-----------|----------|
| `python` | `ruff_format` | LSP |
| `javascript` `typescript` `*react` | `prettierd` → `prettier` | LSP |
| `css` `scss` | `prettierd` → `prettier` | LSP |
| `json` `yaml` | `prettierd` → `prettier` | LSP |
| `htmldjango` | `djlint` | LSP |
| Cualquier otro | — | LSP |

**Cómo funciona la cadena:** conform intenta el primer formatter de la lista;
si no está instalado prueba el siguiente; si ninguno existe usa
`vim.lsp.buf.format()`. Nunca se queda sin formatear.

### Instalar los formatters

```bash
# Python + templates Django, dentro del .venv del proyecto
pip install ruff djlint

# JS/TS/CSS/JSON, global
npm install -g prettier @fsouza/prettierd
```

### Ver qué formatter se usaría

```vim
:ConformInfo
```

Muestra los formatters disponibles para el buffer actual y cuál se ejecutaría.

### Activar formateo al guardar

Si lo quieres, edita [`lua/plugins/lsp.lua`](../lua/plugins/lsp.lua) y agrega a
las `opts` de conform:

```lua
format_on_save = {
  timeout_ms = 500,
  lsp_format = "fallback",
},
```

> No está activado por defecto: en proyectos con estilos mezclados, formatear
> al guardar genera diffs gigantes en archivos que solo querías tocar un poco.

---

## Snippets

`friendly-snippets` + `LuaSnip`. Aparecen en el menú de cmp con tipo **Snippet**.

### Navegación dentro de un snippet

| Atajo | Acción |
|-------|--------|
| `Tab` | Siguiente placeholder |
| `Shift+Tab` | Placeholder anterior |

### Django y DRF

Activados con `filetype_extend`, que hace que un filetype herede snippets de otros:

```lua
luasnip.filetype_extend("htmldjango", { "html" })
luasnip.filetype_extend("python", { "django", "django-rest" })
```

Con eso disponibles: **168 snippets** en templates y **191** de Django/DRF en Python.
La lista completa está en **[django.md](django.md#snippets)**.

> ⚠️ **Orden importante:** `filetype_extend` debe llamarse **antes** de
> `require("luasnip.loaders.from_vscode").lazy_load()`. Al revés, los snippets
> extendidos no se cargan.

---

## Diagnósticos

Configuración actual:

```lua
vim.diagnostic.config({
    virtual_text = false,     -- lo dibuja tiny-inline-diagnostic
    signs = true,             -- iconos en la columna izquierda
    underline = true,
    update_in_insert = false, -- no molesta mientras escribes
    severity_sort = true,     -- errores antes que warnings
})
```

`virtual_text` está apagado porque **`tiny-inline-diagnostic.nvim`** dibuja los
mensajes con un estilo más legible (preset `modern`), con la fuente del
diagnóstico y soporte multilínea.

### Ver diagnósticos en panel

| Atajo | Acción |
|-------|--------|
| `Espacio+xx` | Todos los errores del proyecto (Trouble) |
| `Espacio+xf` | Solo del archivo actual |
| `Espacio+xq` | Quickfix list |
| `]d` / `[d` | Saltar entre diagnósticos |

---

## Agregar un servidor nuevo

Ejemplo con `gopls` (Go), en [`lua/plugins/lsp.lua`](../lua/plugins/lsp.lua):

**1.** Agrégalo a `ensure_installed` de `mason-lspconfig`:

```lua
ensure_installed = {
  "pyright", "ruff", -- ...
  "gopls",           -- ← nuevo
},
```

**2.** Si necesita configuración específica, dentro del `config` de `nvim-lspconfig`:

```lua
vim.lsp.config("gopls", {
    cmd = { "gopls" },
    filetypes = { "go", "gomod" },
    settings = {
        gopls = { analyses = { unusedparams = true } },
    },
})
```

**3.** Reinicia Neovim. Mason lo instala y `automatic_enable` (default en v2) lo activa.

> 💡 **No hace falta `vim.lsp.enable()`**: mason-lspconfig v2 habilita
> automáticamente todo lo que instala. Los nombres válidos están en la
> [lista de nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md).

### Agregar un formatter

En las `opts` de conform:

```lua
formatters_by_ft = {
  go = { "gofmt" },
},
```

---

## Comandos de diagnóstico

| Comando | Para qué |
|---------|----------|
| `:LspInfo` | Servidores adjuntos al buffer actual |
| `:LspLog` | Log de errores del LSP |
| `:LspRestart` | Reiniciar servidores (útil tras cambiar config) |
| `:Mason` | Gestor de servidores (`U` = actualizar todos) |
| `:ConformInfo` | Formatters disponibles y activo |
| `:checkhealth lsp` | Diagnóstico del subsistema LSP |
| `:checkhealth mason` | Verificar Mason y sus dependencias |

---

[⬅️ Volver al README](../README.md) · [Django y DRF ➡️](django.md)
