# 🚀 Instalación y Configuración de Neovim

> Guía completa para instalar y configurar Neovim en Ubuntu con todos los plugins y herramientas necesarias para desarrollo.

---

## 📋 Tabla de Contenidos

- [Requisitos Previos](#-requisitos-previos)
- [Instalación de Neovim](#-instalación-de-neovim)
- [Herramientas de Búsqueda](#-herramientas-de-búsqueda)
- [Tmux - Gestor de Sesiones](#-tmux---gestor-de-sesiones)
- [LazyDocker](#-lazydocker)
- [Fuentes Nerd Fonts](#-fuentes-nerd-fonts)
- [Configuración de Neovim](#️-configuración-de-neovim)
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
| `tmux new -s proyecto` | Crear nueva sesión |
| `tmux ls` | Listar sesiones activas |
| `tmux attach -t proyecto` | Conectarse a sesión |
| `Ctrl+a d` | Desconectar de sesión |
| `Ctrl+a s` | Cambiar entre sesiones |

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

Las Nerd Fonts son necesarias para mostrar correctamente los iconos en Neovim y el explorador de archivos.

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

Si prefieres otra fuente, aquí tienes más opciones:

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

### Crear estructura de directorios

```bash
# Crear carpeta de configuración
mkdir -p ~/.config/nvim

# Verificar creación
ls -la ~/.config/nvim/

# Navegar a la carpeta
cd ~/.config/nvim
```

### Crear archivo de configuración

```bash
# Crear init.lua
touch init.lua

# Verificar creación
ls -la init.lua
```

### Agregar configuración

**Opción 1: Copiar desde este repositorio**

```bash
# Clonar este repositorio
git clone <url-de-tu-repo> ~/temp-nvim-config

# Copiar init.lua
cp ~/temp-nvim-config/init.lua ~/.config/nvim/init.lua

# Limpiar
rm -rf ~/temp-nvim-config
```

**Opción 2: Editar manualmente**

```bash
# Abrir init.lua
nvim ~/.config/nvim/init.lua
```

1. Presiona `i` para entrar en modo **INSERT**
2. Pega el contenido del archivo `init.lua` de este repo
3. Presiona `Esc` para salir del modo INSERT
4. Escribe `:wq` y presiona Enter para guardar y salir

### Primera ejecución

```bash
# Abrir Neovim
nvim
```

**¿Qué esperar?**

- Lazy.nvim se instalará automáticamente
- Los plugins comenzarán a descargarse
- Espera a que termine el proceso (puede tomar 1-2 minutos)
- Una vez completado, cierra y vuelve a abrir Neovim

### Instalar Language Servers

```bash
# Abrir Neovim
nvim

# Dentro de Neovim, ejecuta:
:Mason
```

Instala los siguientes LSP (usa `/` para buscar y presiona `i` para instalar):

- ✅ **pyright** (Python)
- ✅ **html** (HTML)
- ✅ **emmet-ls** (Emmet para HTML/CSS)

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
```

### Probar configuración

```bash
# Abrir Neovim
nvim

# Probar Telescope (buscar archivos)
# Dentro de Neovim: Espacio + ff

# Probar NvimTree (explorador)
# Dentro de Neovim: Espacio + e

# Probar terminal
# Dentro de Neovim: Ctrl + ´
```

---

## 🐛 Solución de Problemas

### Los iconos no se muestran correctamente

**Solución:** Verifica que hayas configurado la Nerd Font en tu terminal y que hayas reiniciado la terminal después de instalar las fuentes.

### Telescope no encuentra archivos

**Solución:** Asegúrate de que `ripgrep` y `fd` estén instalados y en tu PATH.

```bash
which rg
which fd
```

### LSP no funciona

**Solución:** Abre Mason y verifica que los language servers estén instalados:

```vim
:Mason
```

### Errores al iniciar Neovim

**Solución:** Verifica la sintaxis de tu `init.lua`:

```bash
nvim --headless "+Lazy! sync" +qa
```

---

## 📚 Recursos Adicionales

### Documentación

- [Neovim Docs](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [LSP Config](https://github.com/neovim/nvim-lspconfig)

### Tutoriales

```bash
# Tutorial interactivo de Vim
vimtutor

# Ayuda de Neovim
:help
```

### Archivos de este repo

- `init.lua` - Configuración principal de Neovim
- `nvim-cheatsheet.md` - Guía de referencia de atajos
- `README.md` - Este archivo

---

## 🎯 Próximos Pasos

1. ✅ Completa la instalación siguiendo esta guía
2. 📖 Lee el archivo `nvim-cheatsheet.md` para aprender los atajos
3. 🎮 Practica con `vimtutor`
4. 🔧 Personaliza tu configuración según tus necesidades
5. 🚀 ¡Empieza a codear como un pro!

---

## 🤝 Contribuciones

Si encuentras algún error o tienes sugerencias para mejorar esta guía, no dudes en:

- Abrir un issue
- Hacer un pull request
- Compartir tu feedback

---

## 📝 Notas

- Esta configuración está optimizada para **desarrollo en Python, HTML y JavaScript**
- Usa **Dracula** como tema por defecto
- La tecla **Leader** está configurada como **Espacio**
- Compatible con **Ubuntu 20.04+**

---

**¡Happy coding! 🚀**

*Última actualización: Enero 2026*
