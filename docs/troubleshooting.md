# 🐛 Solución de Problemas

> Diagnóstico de los problemas más comunes, del más frecuente al más raro.

---

## 📋 Contenido

- [Primer diagnóstico](#primer-diagnóstico)
- [Instalación](#instalación)
- [Iconos y fuentes](#iconos-y-fuentes)
- [Telescope](#telescope)
- [LSP y autocompletado](#lsp-y-autocompletado)
- [Copilot](#copilot)
- [Snippets](#snippets)
- [Formateo](#formateo)
- [Atajos](#atajos)
- [Rendimiento](#rendimiento)
- [Git](#git)
- [Debugger y tests](#debugger-y-tests)
- [Reinstalación limpia](#reinstalación-limpia)

---

## Primer diagnóstico

Antes de nada, estos cuatro comandos resuelven o localizan la mayoría de casos:

```vim
:checkhealth      " Diagnóstico completo de Neovim y plugins
:Lazy             " ¿Están todos los plugins instalados?
:Mason            " ¿Están los LSPs instalados?
:messages         " ¿Hubo errores al arrancar?
```

---

## Instalación

### `vim.lsp.config` no existe / errores al arrancar tras clonar

Tu Neovim es anterior a 0.11.

```bash
nvim --version
```

Si es 0.10 o menor, actualiza — ver [installation.md](installation.md#neovim).

### `telescope-fzf-native` falla al compilar

Falta el compilador.

```bash
sudo apt install build-essential -y
```

Luego, dentro de Neovim:

```vim
:Lazy build telescope-fzf-native.nvim
```

### Los parsers de Treesitter no compilan

Mismo motivo (falta `gcc`). Verifica y recompila:

```vim
:checkhealth nvim-treesitter
:TSUpdate
```

### Mason no instala nada

```vim
:checkhealth mason
```

Suele faltar `curl`, `unzip`, `tar`, `node` o `python3`:

```bash
sudo apt install curl unzip tar -y
```

---

## Iconos y fuentes

### Veo cuadrados o signos de interrogación

No tienes una Nerd Font activa en la terminal.

```bash
# 1. ¿Está instalada?
fc-list | grep -i "JetBrainsMono"

# 2. Si no aparece, instalar
mkdir -p ~/.local/share/fonts && cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono && rm JetBrainsMono.zip
fc-cache -fv
```

**3.** Configúrala en las preferencias de tu terminal (no basta con instalarla).
**4.** Cierra y abre la terminal por completo.

### Los colores se ven degradados o mal

Falta true color.

```bash
echo $COLORTERM     # debe decir "truecolor" o "24bit"
```

Si usas tmux, revisa [tmux.md](tmux.md#los-colores-se-ven-mal-dentro-de-tmux).

---

## Telescope

### No encuentra archivos

```bash
which rg
which fd

# Si faltan:
sudo apt install ripgrep fd-find -y
sudo ln -s /usr/bin/fdfind /usr/local/bin/fd
```

### No encuentra archivos ocultos o ignorados

Por diseño: se excluyen `node_modules`, `.git/`, `dist/`, `build/`, `__pycache__`
y `.pyc`. Para incluirlos temporalmente:

```vim
:Telescope find_files hidden=true no_ignore=true
```

Para cambiarlo de forma permanente, edita `file_ignore_patterns` en
[`lua/plugins/editor.lua`](../lua/plugins/editor.lua).

### La búsqueda va lenta

Verifica que `fzf-native` esté compilado:

```vim
:checkhealth telescope
```

---

## LSP y autocompletado

### No hay autocompletado ni diagnósticos

```vim
" 1. ¿Se adjuntó algún servidor a este buffer?
:LspInfo

" 2. ¿Está instalado el servidor?
:Mason

" 3. ¿Hay errores?
:LspLog
```

### `:LspInfo` dice que no hay clientes adjuntos

Causas frecuentes, en orden:

**a) El filetype no coincide.** Verifica:

```vim
:set filetype?
```

Compara con los `filetypes` del servidor en [`lua/plugins/lsp.lua`](../lua/plugins/lsp.lua).

**b) El binario no está en el `PATH`.** Los LSPs de Mason viven en
`~/.local/share/nvim/mason/bin/`. Prueba:

```vim
:lua print(vim.fn.executable("pyright-langserver"))
" 1 = existe, 0 = no
```

**c) Un typo en el `cmd`.** Este bug es silencioso: el servidor simplemente no
arranca y no hay error visible. Revisa el `cmd` del servidor carácter por
carácter (espacios sobrantes incluidos).

**d) No encuentra la raíz del proyecto.** Algunos servidores necesitan un marcador
(`pyproject.toml`, `package.json`, `.git`). Abre Neovim desde la raíz del proyecto.

### Los diagnósticos de Python no coinciden con mi CI

Casi siempre es el `.venv`. `ruff` se resuelve desde el `PATH`:

```bash
# Activa el venv ANTES de abrir nvim
source .venv/bin/activate
which ruff        # debe apuntar al .venv, no a mason
nvim
```

Si abres Neovim sin el venv, usa el ruff global de Mason con su config por defecto.

### Un servidor se queda colgado

```vim
:LspRestart
```

---

## Copilot

### No aparecen sugerencias

```vim
" 1. ¿Autenticado?
:Copilot status

" 2. Si no:
:Copilot auth

" 3. ¿El filetype está habilitado?
:set filetype?
```

Copilot usa `["*"] = false`: solo funciona en los filetypes de la lista de
[`lua/plugins/ai.lua`](../lua/plugins/ai.lua). Es intencional (ver
[ai-copilot.md](ai-copilot.md#-por-qué-la-lista-es-cerrada)).

### Copilot funciona pero las sugerencias no salen en el menú

Verifica que `copilot-cmp` esté cargado y que `copilot` esté en las `sources`
de nvim-cmp en [`lua/plugins/lsp.lua`](../lua/plugins/lsp.lua).

### `:Copilot status` dice "not authorized"

Tu cuenta no tiene una suscripción activa de Copilot. Alternativas gratuitas en
[ai-copilot.md](ai-copilot.md#alternativas-de-ia).

---

## Snippets

### Los snippets de Django no aparecen

Verifica que se cargaron:

```vim
:lua print(#(require("luasnip").get_snippets("django") or {}))
" Debe imprimir ~139
```

Si imprime `0`, el orden en [`lua/plugins/lsp.lua`](../lua/plugins/lsp.lua) está
mal: `filetype_extend` **tiene que llamarse antes** de `lazy_load()`.

```lua
-- ✅ Orden correcto
luasnip.filetype_extend("python", { "django", "django-rest" })
require("luasnip.loaders.from_vscode").lazy_load()
```

### En un template no salen los snippets de Django

El filetype es `html` en vez de `htmldjango`:

```vim
:set filetype?
:set filetype=htmldjango    " forzar
```

Neovim detecta `htmldjango` por la presencia de sintaxis `{% %}`. Un template
que aún no tiene ninguna se detecta como `html`.

---

## Formateo

### `Espacio+cf` no hace nada

```vim
:ConformInfo
```

Muestra los formatters disponibles y el que se usaría. Si no hay ninguno,
conform cae al LSP; si el LSP tampoco formatea ese filetype, no pasa nada.

### Instalar el formatter que falta

```bash
# Python / templates Django (en el .venv del proyecto)
pip install ruff djlint

# JS/TS/CSS/JSON
npm install -g prettier @fsouza/prettierd
```

### El formateo no respeta la config de mi proyecto

Los formatters se resuelven desde el `PATH`. Abre Neovim con el `.venv` activado
para que use el ruff/djlint del proyecto y su `pyproject.toml`.

---

## Atajos

### Un atajo documentado no hace nada

```vim
:verbose nmap <leader>gd
```

- **Si no muestra nada:** el atajo no está registrado. Casi siempre es el bug de
  definir atajos en `config` de un plugin lazy — ver
  [plugins.md](plugins.md#-regla-de-oro-atajos-en-keys-no-en-config).
- **Si muestra otro plugin:** hay una colisión.

### Un atajo tarda ~1 segundo en responder

Colisión de prefijos: existe un mapeo que es a la vez completo y prefijo de
otro. Neovim espera `timeoutlen` para desambiguar.

Esta config usa `timeoutlen = 300` y no tiene colisiones, pero si agregas
`<leader>x` teniendo ya `<leader>xx`, reintroduces el problema.

Para detectarlas:

```vim
:lua for _,m in ipairs(vim.api.nvim_get_keymap("n")) do print(m.lhs) end
```

### `Ctrl+h/j/k/l` no salta a los paneles de tmux

Falta configurar `~/.tmux.conf` — ver
[tmux.md](tmux.md#integración-con-vim-tmux-navigator).

### `Ctrl+´` no abre la terminal

Ese carácter depende del layout de teclado. Usa la alternativa `Espacio+tt`, o
cambia `open_mapping` en [`lua/plugins/terminal.lua`](../lua/plugins/terminal.lua):

```lua
open_mapping = [[<C-\>]],
```

---

## Rendimiento

### Neovim tarda en arrancar

```bash
nvim --startuptime /tmp/start.log +q && tail -1 /tmp/start.log
```

Referencia: **~63ms**. Si es mucho más, identifica al culpable:

```vim
:Lazy profile
```

Causa habitual: un plugin agregado sin trigger de lazy-loading (sin `keys`,
`cmd`, `ft` ni `event`).

### El editor se siente lento al escribir

- **Archivos muy grandes:** Treesitter y el LSP sufren. Prueba
  `:TSBufDisable highlight` en ese buffer.
- **`update_in_insert`:** ya está en `false`. Si lo activaste, vuélvelo a apagar.
- **Blame inline de gitsigns:** desactívalo con `Espacio+tb`.

---

## Git

### `Espacio+gd` falla con "revision not found"

Los atajos de Diffview asumen una rama base llamada `development`. Si tu repo
usa `main` o `develop`, cámbialos en la sección `keys` de diffview en
[`lua/plugins/git.lua`](../lua/plugins/git.lua).

### Octo no funciona

```bash
gh auth status

# Si no está autenticado:
gh auth login
```

### GitSigns no muestra nada

Solo funciona dentro de un repositorio Git. Verifica con `:Git status` o
`git status`.

---

## Debugger y tests

### `Espacio+dc` no encuentra el adaptador

```vim
:MasonInstall debugpy
```

### El debugger de Django no se detiene en el breakpoint

Asegúrate de usar la configuración **"Django runserver"**, que incluye
`--noreload`. Con el autoreload activo, Django reinicia el proceso y el debugger
pierde el attach.

### Neotest no encuentra los tests

Requiere `pytest` en el entorno y que el `python` configurado exista:

```bash
source .venv/bin/activate
pip install pytest
which python      # debe apuntar a .venv/bin/python
```

Si usas el runner de Django en vez de pytest, cámbialo en
[`lua/plugins/testing.lua`](../lua/plugins/testing.lua).

---

## Reinstalación limpia

Cuando nada más funciona. **No borra tu configuración**, solo los plugins
descargados, el estado y la caché:

```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
nvim
```

Se reinstala todo desde `lazy-lock.json` (2-3 minutos).

### Volver a la última versión que funcionaba

```bash
cd ~/.config/nvim
git log --oneline           # encuentra el commit bueno
git checkout <commit>
```

```vim
:Lazy restore   " reinstala las versiones de ese lazy-lock.json
```

### Restaurar tu configuración anterior a esta

```bash
rm -rf ~/.config/nvim
mv ~/.config/nvim.backup ~/.config/nvim
```

---

## Reportar un problema

Si nada de esto ayuda, abre un issue incluyendo:

```bash
nvim --version
```

```vim
:checkhealth      " copia la salida relevante
:messages         " errores al arrancar
:LspInfo          " si es un problema de LSP
```

Y el filetype del archivo donde ocurre (`:set filetype?`).

---

[⬅️ Volver al README](../README.md) · [Comandos ➡️](commands-and-workflow.md)
