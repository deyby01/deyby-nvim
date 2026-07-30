# 🚀 Instalación y Configuración de Neovim

> Guía completa para instalar y configurar Neovim en Ubuntu con estructura modular, optimizada para desarrollo con **Python / Django / DRF, JavaScript / TypeScript / React, HTML / CSS, Docker y nginx**.

---

## ✨ Características

- ⚡ **Arranque rápido** (~60ms) gracias a lazy-loading de plugins
- 🤖 **GitHub Copilot integrado en el autocompletado** (copilot-cmp): las sugerencias de IA aparecen dentro del mismo menú que el LSP
- 🐍 **Snippets de Django y DRF** activados: `{% block %}`, `{% for %}`, modelos, forms, serializers, views...
- 🧠 **LSPs auto-instalados** con Mason v2 (Python, JS/TS/React, HTML, CSS, JSON, YAML, Docker, docker-compose, nginx)
- 🪄 **Formateo inteligente** con conform.nvim: usa los formatters de tu `.venv`/PATH (ruff, prettier, djlint) con fallback al LSP
- 🐞 **Debugger de Python/Django** (debugpy) con configuración lista para `manage.py runserver`
- 🎨 Tema **Dracula**, dashboard personalizado, which-key, paleta de comandos (Legendary)

---

## 📋 Tabla de Contenidos

- [Requisitos Previos](#-requisitos-previos)
- [Instalación de Neovim](#-instalación-de-neovim)
- [Herramientas de Búsqueda](#-herramientas-de-búsqueda)
- [Tmux - Gestor de Sesiones](#️-tmux---gestor-de-sesiones)
- [LazyDocker](#-lazydocker)
- [Fuentes Nerd Fonts](#-fuentes-nerd-fonts)
- [Configuración de Neovim](#️-configuración-de-neovim)
- [Estructura Modular](#-estructura-modular)
- [LSPs y Herramientas](#-lsps-y-herramientas)
- [Verificación](#-verificación)
- [Solución de Problemas](#-solución-de-problemas)
- [Recursos Adicionales](#-recursos-adicionales)

---

## 🔧 Requisitos Previos

### Verificar e instalar Git

```bash
# Verificar si Git está instalado
git --version

# Si no está instalado:
sudo apt install git -y
```

### Actualizar el sistema

```bash
sudo apt update && sudo apt upgrade -y
```

### Compilador y make (requerido por telescope-fzf-native y treesitter)

```bash
sudo apt install build-essential -y
```

---

## 📦 Instalación de Neovim

> ⚠️ Esta configuración usa la API moderna de LSP (`vim.lsp.config` / `vim.lsp.enable`), por lo que requiere **Neovim 0.11 o superior**.

```bash
# Agregar repositorio de Neovim
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update

# Instalar Neovim
sudo apt install neovim -y
```

### Verificar instalación

```bash
nvim --version
```

**Salida esperada:** Neovim v0.11.x o superior

---

## 🔍 Herramientas de Búsqueda

Estas herramientas son esenciales para que Telescope funcione correctamente.

### Ripgrep (búsqueda de contenido)

```bash
# Instalar ripgrep
sudo apt install ripgrep -y

# Verificar instalación
rg --version
```

### fd (búsqueda de archivos)

```bash
# Instalar fd-find
sudo apt install fd-find -y

# Crear enlace simbólico para usar 'fd'
sudo ln -s /usr/bin/fdfind /usr/local/bin/fd

# Verificar instalación
fd --version
```

---

## 🖥️ Tmux - Gestor de Sesiones

Tmux te permite mantener múltiples sesiones y proyectos abiertos simultáneamente.

### Instalación

```bash
sudo apt install tmux -y
```

### Configuración

```bash
# Crear archivo de configuración
nvim ~/.tmux.conf
```

Pega la siguiente configuración:

```bash
# Cambiar prefijo de Ctrl+b a Ctrl+a (más cómodo)
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# Dividir paneles con | y -
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# Navegar entre paneles con Alt+flechas (sin prefijo)
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# Recargar configuración rápido
bind r source-file ~/.tmux.conf \; display "Config recargada!"

# Habilitar mouse
set -g mouse on

# Numeración desde 1
set -g base-index 1
setw -g pane-base-index 1

# Colores
set -g default-terminal "screen-256color"

# Historial más grande
set -g history-limit 10000

# Renombrar ventanas automáticamente
set-option -g allow-rename off
```

### Comandos básicos de Tmux

| Comando | Descripción |
|---------|-------------|
| `tmux new -s nombre` | Crear nueva sesión |
| `tmux ls` | Listar sesiones activas |
| `tmux attach -t nombre` | Conectarse a sesión |
| `Ctrl+a d` | Desconectar de sesión |
| `Ctrl+a s` | Cambiar entre sesiones |
| `Ctrl+a \|` | Dividir verticalmente |
| `Ctrl+a -` | Dividir horizontalmente |

---

## 🐳 LazyDocker

Interfaz visual para gestionar contenedores Docker desde Neovim.

```bash
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
```

### Verificar instalación

```bash
lazydocker --version
```

---

## 🎨 Fuentes Nerd Fonts

Las Nerd Fonts son necesarias para mostrar correctamente los iconos en Neovim.

### Instalación de JetBrainsMono Nerd Font (Recomendada)

```bash
# Crear carpeta para fuentes
mkdir -p ~/.local/share/fonts

# Descargar JetBrainsMono Nerd Font
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip

# Descomprimir y limpiar
unzip JetBrainsMono.zip -d JetBrainsMono
rm JetBrainsMono.zip

# Actualizar caché de fuentes
fc-cache -fv
```

### Configurar en tu terminal

1. Abre una **nueva terminal**
2. Ve a **Preferencias** (Ctrl + ,)
3. Entra en **Perfiles**
4. Selecciona tu perfil o crea uno nuevo con **+**
5. Marca **Fuente personalizada** (Custom Font)
6. Elige **JetBrainsMono Nerd Font**
7. Tamaño: **12** (o el que prefieras)

### Verificar que funciona

Si ves iconos en lugar de cuadrados, ¡está funcionando!

```bash
echo -e " ±  ➦ ✘ ⚡ ⚙"
```

---

## ⚙️ Configuración de Neovim

### Instalar Node.js (requerido por Copilot, LSPs web y Markdown Preview)

```bash
# Verificar si Node.js está instalado
node --version

# Recomendado: instalar con nvm (permite cambiar de versión fácilmente)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
nvm install 22

# Verificar instalación
node --version
npm --version
```

### Clonar configuración desde repositorio

```bash
# Hacer backup de configuración anterior (si existe)
mv ~/.config/nvim ~/.config/nvim.backup

# Clonar tu repositorio de configuración
git clone <url-de-tu-repo> ~/.config/nvim

# Navegar a la carpeta
cd ~/.config/nvim
```

### Primera ejecución

```bash
# Abrir Neovim
nvim
```

**¿Qué esperar?**

1. Lazy.nvim se instala automáticamente
2. Los plugins se descargan (las versiones exactas vienen fijadas en `lazy-lock.json`)
3. `telescope-fzf-native` se compila con `make` y Treesitter compila sus parsers
4. **Mason instala automáticamente todos los LSPs** (`ensure_installed`) — no hay que instalarlos a mano
5. Espera 2-3 minutos, cierra Neovim (`:qa`) y vuelve a abrirlo

### Autenticar GitHub Copilot (solo la primera vez)

```vim
:Copilot auth
```

Sigue el enlace que aparece, pega el código en GitHub y listo. Verifica con:

```vim
:Copilot status
```

---

## 📁 Estructura Modular

```
~/.config/nvim/
├── init.lua                 # Archivo principal (carga módulos)
├── lazy-lock.json           # Versiones exactas de plugins (reproducibilidad)
├── lua/
│   ├── config/
│   │   ├── options.lua      # Opciones básicas de Vim
│   │   ├── keymaps.lua      # Atajos de teclado
│   │   └── autocmds.lua     # Autocomandos
│   └── plugins/
│       ├── init.lua         # Bootstrap y configuración de Lazy.nvim
│       ├── ui.lua           # Tema Dracula, lualine, colorizer, dropbar
│       ├── ui_extra.lua     # Noice, which-key
│       ├── editor.lua       # Telescope (+fzf), NvimTree, Harpoon, Treesitter, Trouble, Spectre
│       ├── lsp.lua          # Mason v2, LSPs, nvim-cmp, conform, snippets Django
│       ├── ai.lua           # GitHub Copilot (integrado en cmp)
│       ├── git.lua          # Fugitive, GitSigns, Diffview, git-conflict, Octo
│       ├── terminal.lua     # ToggleTerm, LazyDocker, tmux-navigator
│       ├── debug.lua        # DAP para Python/Django (debugpy)
│       ├── testing.lua      # Neotest (pytest)
│       ├── session.lua      # Auto-session
│       ├── dashboard.lua    # Pantalla de inicio
│       └── legendary.lua    # Paleta de comandos
```

### Ventajas de la estructura modular:

- ✅ **Fácil de mantener**: Cada archivo tiene una responsabilidad clara
- ✅ **Fácil de expandir**: Agrega plugins en el archivo correspondiente
- ✅ **Fácil de debugear**: Sabes exactamente dónde está cada configuración
- ✅ **Fácil de compartir**: Puedes compartir módulos específicos

### Cómo agregar un nuevo plugin:

```lua
-- Editar el archivo correspondiente en lua/plugins/
-- Ejemplo: lua/plugins/editor.lua

return {
  -- ... plugins existentes ...

  -- Nuevo plugin
  {
    "autor/nombre-plugin",
    config = function()
      require("plugin").setup({
        -- configuración
      })
    end
  },
}
```

### ⚠️ Regla de oro: atajos de plugins lazy van en `keys`, NO en `config`

Casi todos los plugins de esta config cargan bajo demanda (lazy) con
`cmd`, `event`, `ft` o `keys`. Si un plugin carga por comando
(`cmd = "MiComando"`) y defines sus atajos dentro de `config`, esos
atajos **no existen** hasta que el plugin cargue... pero el plugin no
carga hasta que ejecutes el comando a mano. Resultado: atajos muertos.

```lua
-- ❌ MAL: el atajo no existe hasta correr :DiffviewOpen manualmente
{
  "sindrets/diffview.nvim",
  cmd = "DiffviewOpen",
  config = function()
    vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>")  -- nunca se registra
  end,
}

-- ✅ BIEN: lazy registra el atajo al arrancar y carga el plugin al presionarlo
{
  "sindrets/diffview.nvim",
  cmd = "DiffviewOpen",
  keys = {
    { "<leader>gd", ":DiffviewOpen<CR>", desc = "Git: Diff" },
  },
}
```

**Excepciones válidas** (atajos en `config` está bien cuando):
- El plugin **no es lazy** (`lazy = false`), como auto-session
- El plugin carga por **evento temprano** (`event = "BufReadPre"` / `"VeryLazy"`), como flash o todo-comments
- Son atajos **buffer-local** creados al adjuntarse (gitsigns `on_attach`, keymaps de LSP en `LspAttach`)

> 💡 Para verificar que un atajo realmente existe: `:verbose nmap <leader>gd`
> o búscalo con `Ctrl+p` (Legendary).

---

## 🛠️ LSPs y Herramientas

### LSPs incluidos (se instalan solos con Mason)

Definidos en `lua/plugins/lsp.lua` → `ensure_installed`:

| LSP | Para |
|-----|------|
| `pyright` | Python (type checker) |
| `ruff` | Python (linter + formatter) |
| `html` | HTML y templates de Django |
| `cssls` | CSS / SCSS / LESS |
| `ts_ls` | JavaScript / TypeScript / React |
| `emmet_ls` | Emmet (HTML, templates, JSX/TSX) |
| `jsonls` | JSON |
| `yamlls` | YAML |
| `dockerls` | Dockerfile |
| `docker_compose_language_service` | docker-compose.yml |
| `nginx_language_server` | nginx.conf |

> 💡 **Linters por proyecto:** ruff se resuelve desde el `PATH`, así que si abres nvim con el `.venv` del proyecto activado, usa el ruff del proyecto con su configuración local (`pyproject.toml` / `ruff.toml`).

### Debugger

```vim
:MasonInstall debugpy    " Solo si no se instaló automáticamente
```

### Formatters opcionales (para conform.nvim)

Conform busca estos en tu PATH/.venv y si no existen usa el LSP como fallback:

```bash
# Por proyecto (recomendado, dentro del .venv)
pip install ruff djlint

# Globales para JS/TS/CSS
npm install -g prettier @fsouza/prettierd
```

### Gestionar desde Mason

```vim
:Mason      " Ver estado, instalar/actualizar (U = actualizar todos)
```

---

## ✅ Verificación

### Checklist de instalación

```bash
nvim --version      # >= 0.11
rg --version
fd --version
tmux -V
lazydocker --version
git --version
node --version
npm --version
gcc --version       # Para fzf-native y treesitter
```

### Probar funcionalidades

```bash
# 1. Abrir Neovim
nvim

# 2. Verificar salud del sistema
:checkhealth

# 3. Probar Telescope (buscar archivos)
Espacio + ff

# 4. Probar NvimTree (explorador)
Espacio + e

# 5. Probar terminal
Ctrl + ´

# 6. Probar LSP + Copilot (abrir archivo Python y escribir)
nvim test.py
# Deben aparecer sugerencias del LSP y de Copilot () en el mismo menú

# 7. Probar snippets de Django (en un template .html de Django)
# Escribe "block" o "for" y acepta el snippet

# 8. Probar Git
Espacio + gs
```

---

## 🐛 Solución de Problemas

### Los iconos no se muestran correctamente

**Problema:** Ves cuadrados en lugar de iconos.

**Solución:**
```bash
# 1. Verificar que la fuente está instalada
fc-list | grep JetBrainsMono

# 2. Si no aparece, reinstalar (ver sección de fuentes)
# 3. Configurar la fuente en tu terminal
# 4. Reiniciar terminal completamente
```

### Telescope no encuentra archivos

```bash
# Verificar que ripgrep y fd están instalados
which rg
which fd

# Si no están:
sudo apt install ripgrep fd-find -y
sudo ln -s /usr/bin/fdfind /usr/local/bin/fd
```

### telescope-fzf-native falla al compilar

```bash
# Necesitas make y gcc
sudo apt install build-essential -y

# Recompilar
nvim
:Lazy build telescope-fzf-native.nvim
```

### LSP no funciona / No hay autocompletado

```bash
# 1. Verificar que los LSPs están instalados
nvim
:Mason

# 2. Verificar que el LSP se adjuntó al buffer
:LspInfo

# 3. Verificar logs de LSP
:LspLog
```

### Copilot no sugiere código

```vim
" 1. Verificar autenticación
:Copilot status

" 2. Si no está autenticado
:Copilot auth

" 3. Verificar que el filetype está habilitado
" (ver lua/plugins/ai.lua → filetypes; los no listados están
"  apagados a propósito, p. ej. .env para no filtrar secretos)
```

### Markdown Preview no funciona

```bash
# 1. Verificar Node.js
node --version

# 2. Reinstalar el plugin
nvim
:Lazy clean
:Lazy sync

# 3. Compilar manualmente si hace falta
cd ~/.local/share/nvim/lazy/markdown-preview.nvim/app
npm install
```

### Errores al iniciar Neovim

```bash
# 1. Limpiar caché de plugins
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# 2. Abrir Neovim (reinstalará todo)
nvim

# 3. Verificar errores específicos
:checkhealth
```

### ESC no funciona en modo INSERT

```bash
# Usa los atajos alternativos configurados:
jk  # Presiona 'j' seguido rápidamente de 'k'
kj  # O 'k' seguido de 'j'
```

---

## 📚 Recursos Adicionales

### Documentación oficial

- [Neovim Docs](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [LSP Config](https://github.com/neovim/nvim-lspconfig)
- [Mason](https://github.com/mason-org/mason.nvim)
- [conform.nvim](https://github.com/stevearc/conform.nvim)
- [copilot.lua](https://github.com/zbirenbaum/copilot.lua)

### Tutoriales

```bash
# Tutorial interactivo de Vim
vimtutor

# Ayuda de Neovim
:help
:help telescope
:help lsp
```

### Archivos de este repo

- `README.md` - Guía de instalación (este archivo)
- `commands-and-workflow.md` - Referencia completa de atajos
- `daily_routine.md` - Referencia rápida del día a día
- `init.lua` - Archivo principal de configuración
- `lazy-lock.json` - Versiones exactas de los plugins
- `lua/` - Módulos de configuración

---

## 🤝 Mantenimiento

### Actualizar plugins

```vim
:Lazy sync
" Después de actualizar, commitea el lazy-lock.json al repo
```

### Actualizar LSPs

```vim
:Mason
" Presiona 'U' para actualizar todos
```

### Actualizar parsers de Treesitter

```vim
:TSUpdate
```

### Actualizar Neovim

```bash
sudo apt update
sudo apt upgrade neovim
```

---

## 📝 Notas importantes

- **Leader Key:** `Espacio`
- **Tema:** Dracula
- **Stack soportado:** Python / Django / DRF, JavaScript / TypeScript / React, HTML (+ templates Django), CSS/SCSS, JSON, YAML, Docker, docker-compose, nginx, Lua, Markdown
- **Requisitos:** Neovim 0.11+, Ubuntu 20.04+, Node.js 18+ (recomendado 22)
- **Workflow de linters:** cada proyecto lleva sus linters/formatters en su `.venv/` — abre nvim con el venv activado y ruff/djlint usan la config del proyecto

---

**¡Happy coding! 🚀**

*Última actualización: Julio 2026*
