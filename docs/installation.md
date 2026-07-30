# 📦 Guía de Instalación Completa

> Instalación paso a paso en Ubuntu/Debian. Para la instalación rápida, mira el [README](../README.md#-instalación).

---

## 📋 Contenido

- [Requisitos previos](#requisitos-previos)
- [Neovim](#neovim)
- [Herramientas de búsqueda](#herramientas-de-búsqueda)
- [Node.js](#nodejs)
- [Nerd Fonts](#nerd-fonts)
- [Clonar la configuración](#clonar-la-configuración)
- [Primera ejecución](#primera-ejecución)
- [Autenticar Copilot](#autenticar-copilot)
- [Herramientas opcionales](#herramientas-opcionales)
- [Verificación final](#verificación-final)
- [Desinstalar / volver atrás](#desinstalar--volver-atrás)

---

## Requisitos previos

### Actualizar el sistema

```bash
sudo apt update && sudo apt upgrade -y
```

### Git y compilador

`build-essential` es **obligatorio**: `telescope-fzf-native` y los parsers de
Treesitter se compilan durante la instalación.

```bash
sudo apt install git build-essential -y
```

---

## Neovim

> ⚠️ Esta configuración usa la API moderna de LSP (`vim.lsp.config` / `vim.lsp.enable`),
> por lo que requiere **Neovim 0.11 o superior**. Las versiones de los repos
> estables de Ubuntu suelen ser más antiguas, por eso usamos el PPA.

```bash
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install neovim -y
```

### Verificar

```bash
nvim --version
```

**Salida esperada:** `NVIM v0.11.x` o superior.

<details>
<summary>Alternativa: instalar desde el AppImage oficial</summary>

```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim
nvim --version
```

</details>

---

## Herramientas de búsqueda

Esenciales para Telescope. `ripgrep` hace la búsqueda de contenido y `fd` la de archivos.

```bash
sudo apt install ripgrep fd-find -y

# En Ubuntu el binario se llama 'fdfind'; creamos el alias 'fd'
sudo ln -s /usr/bin/fdfind /usr/local/bin/fd

# Verificar
rg --version
fd --version
```

---

## Node.js

Requerido por Copilot, los LSPs web (html, cssls, ts_ls, emmet) y Markdown Preview.

**Recomendado con nvm** (permite cambiar de versión por proyecto):

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# Reabrir la terminal, luego:
nvm install 22
nvm alias default 22

node --version
npm --version
```

<details>
<summary>Alternativa: NodeSource (instalación global del sistema)</summary>

```bash
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install nodejs -y
```

</details>

---

## Nerd Fonts

Necesarias para los iconos de NvimTree, lualine, el dashboard y los diagnósticos.

### Instalar JetBrainsMono Nerd Font (recomendada)

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono
rm JetBrainsMono.zip
fc-cache -fv
```

### Configurar en la terminal

1. Abre una **nueva terminal**
2. **Preferencias** (`Ctrl + ,`) → **Perfiles**
3. Marca **Fuente personalizada**
4. Elige **JetBrainsMono Nerd Font**, tamaño 12

### Verificar

```bash
echo -e " ±  ➦ ✘ ⚡ ⚙"
```

Si ves iconos y no cuadrados, está funcionando.

<details>
<summary>Fuentes alternativas</summary>

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

## Clonar la configuración

```bash
# Backup de tu configuración anterior (si existe)
mv ~/.config/nvim ~/.config/nvim.backup

# Clonar
git clone https://github.com/deyby01/deyby-nvim.git ~/.config/nvim
```

> 💡 El repo incluye `lazy-lock.json`, que fija las versiones exactas de todos
> los plugins. Al clonar obtienes **la misma configuración probada**, no las
> versiones más recientes (que podrían tener cambios incompatibles).

---

## Primera ejecución

```bash
nvim
```

**Qué ocurre, en orden:**

1. `lazy.nvim` se instala automáticamente
2. Se descargan los plugins en las versiones de `lazy-lock.json`
3. `telescope-fzf-native` se compila con `make`
4. Treesitter compila los parsers (python, typescript, htmldjango, docker...)
5. **Mason instala todos los LSPs** definidos en `ensure_installed` — no hay que instalarlos a mano

⏱️ El proceso tarda **2-3 minutos**. Cuando termine, cierra con `:qa` y vuelve a abrir.

### Verificar que todo cargó

```vim
:Lazy         " Todos los plugins deben aparecer instalados
:Mason        " Los LSPs con ✓
:checkhealth  " Diagnóstico general
```

---

## Autenticar Copilot

Solo la primera vez (requiere una suscripción activa de GitHub Copilot).

```vim
:Copilot auth
```

Se abre un enlace y un código: pégalo en GitHub, autoriza y vuelve a Neovim.

```vim
:Copilot status   " Debe decir que está online/enabled
```

Detalles de la integración en **[ai-copilot.md](ai-copilot.md)**.

---

## Herramientas opcionales

### tmux (recomendado)

Para trabajar con varios proyectos y mantener sesiones vivas.
Configuración completa en **[tmux.md](tmux.md)**.

```bash
sudo apt install tmux -y
```

### LazyDocker

Interfaz visual de Docker, accesible con `Espacio+ld`.

```bash
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
lazydocker --version
```

### GitHub CLI (para Octo)

Necesario para gestionar PRs e Issues desde Neovim.

```bash
sudo apt install gh -y
gh auth login
```

### Formatters de conform.nvim

Conform los busca en el `PATH` y si no existen usa el LSP como fallback.

```bash
# Por proyecto, dentro del .venv (recomendado)
pip install ruff djlint

# Globales para JS/TS/CSS/JSON
npm install -g prettier @fsouza/prettierd
```

### Debugger de Python

```vim
:MasonInstall debugpy
```

---

## Verificación final

```bash
nvim --version       # >= 0.11
rg --version
fd --version
node --version       # >= 18, recomendado 22
gcc --version
git --version
tmux -V              # opcional
lazydocker --version # opcional
gh --version         # opcional
```

### Probar dentro de Neovim

| Prueba | Cómo |
|--------|------|
| Buscar archivos | `Espacio+ff` |
| Explorador | `Espacio+e` |
| Terminal | `Ctrl+´` |
| LSP + Copilot | Abre un `.py`, escribe y mira el menú (debe salir  de Copilot) |
| Snippets Django | En un template, escribe `block` y acepta |
| Git | `Espacio+gs` |
| Paleta de comandos | `Ctrl+p` |

Si algo falla, revisa **[troubleshooting.md](troubleshooting.md)**.

---

## Desinstalar / volver atrás

```bash
# Restaurar tu configuración anterior
rm -rf ~/.config/nvim
mv ~/.config/nvim.backup ~/.config/nvim

# Limpiar plugins, estado y caché
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```

---

[⬅️ Volver al README](../README.md) · [Comandos ➡️](commands-and-workflow.md)
