# 🚀 Instalación y Configuración de Neovim

> Guía completa para instalar y configurar Neovim en Ubuntu con estructura modular y todos los plugins necesarios para desarrollo profesional.

---

## 📋 Tabla de Contenidos

- [Requisitos Previos](#-requisitos-previos)
- [Instalación de Neovim](#-instalación-de-neovim)
- [Herramientas de Búsqueda](#-herramientas-de-búsqueda)
- [Tmux - Gestor de Sesiones](#-tmux---gestor-de-sesiones)
- [LazyDocker](#-lazydocker)
- [Fuentes Nerd Fonts](#-fuentes-nerd-fonts)
- [Configuración de Neovim](#️-configuración-de-neovim)
- [Estructura Modular](#-estructura-modular)
- [Instalación de LSPs](#-instalación-de-lsps)
- [Verificación](#-verificación)
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

---

## 📦 Instalación de Neovim

Instalaremos la última versión estable de Neovim desde el PPA oficial.

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

**Salida esperada:** Neovim v0.10.x o superior

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
echo -e "\ue0b0 \u00b1 \ue0a0 \u27a6 \u2718 \u26a1 \u2699"
```

**Salida esperada:** ⮀ ± ⮀ ➦ ✘ ⚡ ⚙

### Fuentes alternativas

```bash
cd ~/.local/share/fonts

# FiraCode Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip
unzip FiraCode.zip -d FiraCode && rm FiraCode.zip

# Hack Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip
unzip Hack.zip -d Hack && rm Hack.zip

# CascadiaCode Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/CascadiaCode.zip
unzip CascadiaCode.zip -d CascadiaCode && rm CascadiaCode.zip

# Actualizar caché
fc-cache -fv
```

---

## ⚙️ Configuración de Neovim

### Instalar Node.js (requerido para algunos plugins)

```bash
# Verificar si Node.js está instalado
node --version

# Si no está instalado:
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install nodejs -y

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

1. Lazy.nvim se instalará automáticamente
2. Los plugins comenzarán a descargarse en segundo plano
3. Espera 2-3 minutos a que termine
4. Verás algunos mensajes de instalación
5. Cierra Neovim (`:qa`) y vuelve a abrirlo

---

## 📁 Estructura Modular

Tu configuración está organizada de forma modular para facilitar el mantenimiento:

```
~/.config/nvim/
├── init.lua                 # Archivo principal (carga módulos)
├── lua/
│   ├── config/
│   │   ├── options.lua      # Opciones básicas de Vim
│   │   ├── keymaps.lua      # Atajos de teclado
│   │   └── autocmds.lua     # Autocomandos
│   └── plugins/
│       ├── init.lua         # Configuración de Lazy.nvim
│       ├── ui.lua           # Temas, lualine, colorizer
│       ├── editor.lua       # Telescope, NvimTree, Harpoon
│       ├── lsp.lua          # LSP, Mason, autocompletado
│       ├── git.lua          # Fugitive, GitSigns
│       └── terminal.lua     # ToggleTerm, tmux
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

---

## 🛠️ Instalación de LSPs

Los Language Servers proporcionan autocompletado, ir a definición, diagnósticos, etc.

### Instalar desde Mason

```bash
# Abrir Neovim
nvim

# Abrir Mason
:Mason
```

### LSPs recomendados:

Dentro de Mason, usa `/` para buscar y presiona `i` para instalar:

#### Python
- ✅ **pyright** - LSP principal para Python
- ✅ **black** - Formateador de código
- ✅ **isort** - Organizador de imports

#### Web (HTML/CSS/JS)
- ✅ **html-lsp** - LSP para HTML
- ✅ **css-lsp** - LSP para CSS
- ✅ **typescript-language-server** - LSP para JS/TS
- ✅ **emmet-ls** - Emmet para HTML/CSS
- ✅ **prettier** - Formateador para HTML/CSS/JS

#### Otros
- ✅ **lua-language-server** - LSP para Lua (útil para configurar Neovim)
- ✅ **json-lsp** - LSP para JSON

### Verificar que los LSPs están instalados

```vim
# Dentro de Neovim, abrir Mason
:Mason

# Deberías ver tus LSPs instalados con un checkmark ✓
```

### Actualizar LSPs

```vim
:Mason
# Presiona 'U' para actualizar todos los LSPs
```

---

## ✅ Verificación

### Checklist de instalación

Ejecuta estos comandos para verificar que todo esté instalado correctamente:

```bash
# Neovim
nvim --version

# Ripgrep
rg --version

# fd
fd --version

# Tmux
tmux -V

# LazyDocker
lazydocker --version

# Git
git --version

# Node.js y npm
node --version
npm --version
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

# 6. Probar LSP (abrir archivo Python/JS y ver autocompletado)
nvim test.py
# Escribe algo y verifica que aparezcan sugerencias

# 7. Probar Git
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

# 2. Si no aparece, reinstalar:
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono
fc-cache -fv

# 3. Configurar en tu terminal (ver sección de fuentes)
# 4. Reiniciar terminal completamente
```

### Telescope no encuentra archivos

**Problema:** Telescope no funciona o no encuentra archivos.

**Solución:**
```bash
# Verificar que ripgrep y fd están instalados
which rg
which fd

# Si no están:
sudo apt install ripgrep fd-find -y
sudo ln -s /usr/bin/fdfind /usr/local/bin/fd
```

### LSP no funciona / No hay autocompletado

**Problema:** No aparecen sugerencias al escribir.

**Solución:**
```bash
# 1. Verificar que los LSPs están instalados
nvim
:Mason

# 2. Verificar que el LSP se adjuntó al buffer
:LspInfo

# 3. Reinstalar el LSP específico
:Mason
# Busca el LSP, presiona 'X' para desinstalar, luego 'i' para reinstalar

# 4. Verificar logs de LSP
:LspLog
```

### Markdown Preview no funciona

**Problema:** No se abre el navegador al usar `:MarkdownPreview`.

**Solución:**
```bash
# 1. Verificar que Node.js está instalado
node --version

# 2. Si no está, instalarlo
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install nodejs -y

# 3. Reinstalar el plugin
nvim
:Lazy clean
:Lazy sync

# 4. Navegar al plugin y compilar
cd ~/.local/share/nvim/lazy/markdown-preview.nvim/app
npm install
```

### Errores al iniciar Neovim

**Problema:** Neovim muestra errores al iniciarse.

**Solución:**
```bash
# 1. Limpiar caché de plugins
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# 2. Abrir Neovim (reinstalará todo)
nvim

# 3. Sincronizar plugins
:Lazy sync

# 4. Verificar errores específicos
:checkhealth
```

### ESC no funciona en modo INSERT

**Problema:** Al presionar ESC no sales de modo INSERT.

**Solución:**
```bash
# Usa los atajos alternativos configurados:
jk  # Presiona 'j' seguido rápidamente de 'k'
kj  # O 'k' seguido de 'j'

# Si el problema persiste, revisa que no haya conflictos:
nvim
:verbose imap <Esc>
```

---

## 📚 Recursos Adicionales

### Documentación oficial

- [Neovim Docs](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [LSP Config](https://github.com/neovim/nvim-lspconfig)
- [Mason](https://github.com/williamboman/mason.nvim)

### Tutoriales

```bash
# Tutorial interactivo de Vim
vimtutor

# Ayuda de Neovim
:help

# Ayuda de un plugin específico
:help telescope
:help lsp
```

### Archivos de este repo

- `README.md` - Guía de instalación (este archivo)
- `commands-and-workflow.md` - Referencia completa de atajos
- `init.lua` - Archivo principal de configuración
- `lua/` - Módulos de configuración

---

## 🎯 Próximos Pasos

1. ✅ **Completar instalación** siguiendo esta guía
2. 📖 **Leer** `commands-and-workflow.md` para conocer todos los atajos
3. 🎮 **Practicar** con `vimtutor` (30 minutos)
4. 🧪 **Experimentar** creando archivos y usando atajos
5. 🔧 **Personalizar** según tus necesidades
6. 🚀 **Codear** como un profesional

---

## 💡 Tips para principiantes

### Primer día
- Usa `vimtutor` (30 minutos)
- Practica movimientos básicos: `h` `j` `k` `l`
- Aprende a entrar/salir de modo INSERT: `i` `Esc`
- Practica guardar: `Ctrl+s`

### Primera semana
- Domina Telescope: `Espacio+ff` para buscar archivos
- Usa NvimTree: `Espacio+e` para explorar
- Aprende movimientos avanzados: `w` `b` `0` `$` `gg` `G`
- Practica copiar/pegar: `yy` `dd` `p`

### Primer mes
- Domina Git: `Espacio+gs` y navegación con `]c` `[c`
- Usa Harpoon: marca archivos frecuentes con `Espacio+a`
- Aprende LSP: `gd` para ir a definición, `Espacio+ca` para auto-imports
- Personaliza atajos según tu workflow

---

## 📝 Notas importantes

- **Leader Key:** Configurada como `Espacio`
- **Tema:** Dracula por defecto
- **Lenguajes soportados:** Python, HTML, CSS, JavaScript, TypeScript
- **Compatibilidad:** Ubuntu 20.04+
- **Requisitos mínimos:** 4GB RAM, procesador dual-core

---

## 🤝 Mantenimiento

### Actualizar plugins

```vim
# Dentro de Neovim
:Lazy sync
```

### Actualizar LSPs

```vim
:Mason
# Presiona 'U' para actualizar todos
```

### Actualizar Neovim

```bash
sudo apt update
sudo apt upgrade neovim
```

### Hacer backup

```bash
# Backup completo de configuración
cp -r ~/.config/nvim ~/nvim-backup-$(date +%Y%m%d)

# Backup solo de archivos personalizados
tar -czf nvim-config-backup.tar.gz ~/.config/nvim/lua/config/
```

---

**¡Happy coding! 🚀**

*Última actualización: Febrero 2026*
