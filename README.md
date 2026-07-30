<div align="center">

# ⚡ Neovim IDE — Python · Django · React

**Configuración modular de Neovim lista para desarrollo web moderno.**
Arranca en ~60ms, con IA integrada, LSP automático y todo el flujo de Git sin salir del editor.

[![Neovim](https://img.shields.io/badge/Neovim-0.11%2B-57A143?style=flat-square&logo=neovim&logoColor=white)](https://neovim.io)
[![Lua](https://img.shields.io/badge/Lua-2C2D72?style=flat-square&logo=lua&logoColor=white)](https://www.lua.org)
[![lazy.nvim](https://img.shields.io/badge/lazy.nvim-managed-blueviolet?style=flat-square)](https://github.com/folke/lazy.nvim)
[![Startup](https://img.shields.io/badge/startup-~60ms-success?style=flat-square)](docs/plugins.md#rendimiento-y-lazy-loading)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-20.04%2B-E95420?style=flat-square&logo=ubuntu&logoColor=white)](https://ubuntu.com)

[Instalación](#-instalación) · [Características](#-características) · [Comandos](#-comandos-básicos) · [Documentación](#-documentación)

</div>

---

## 🎯 Para quién es

Pensada para desarrolladores que trabajan con **Python/Django/DRF**,
**JavaScript/TypeScript/React**, **Docker** y **nginx**. Si tu stack es otro,
sirve igual como base: agregar servidores de lenguaje es cambiar una línea
([cómo](docs/lsp-and-completion.md#agregar-un-servidor-nuevo)).

---

## ✨ Características

| | |
|---|---|
| ⚡ **Arranque en ~60ms** | 56 plugins, solo 12 cargan al inicio |
| 🤖 **Copilot en el autocompletado** | Las sugerencias de IA salen en el mismo menú que el LSP, no como texto fantasma aparte |
| 🧠 **11 LSPs automáticos** | Mason los instala solo en la primera ejecución |
| 🐍 **Snippets de Django y DRF** | `model`, `serializer`, `{% block %}`, `{% for %}`... ~360 en total |
| 🪄 **Formateo por proyecto** | Usa el ruff/prettier de tu `.venv`, con fallback al LSP |
| 🐞 **Debugger de Django** | Breakpoints reales en vistas, con `manage.py runserver` |
| 🔀 **Git completo** | Status, hunks, diffs entre ramas, conflictos, PRs y reviews |
| 🎨 **UI cuidada** | Dracula, breadcrumbs, diagnósticos inline, which-key |
| ✅ **Sin colisiones de teclas** | 74 atajos verificados, ninguno se pisa |

---

## 📋 Requisitos

| Requisito | Mínimo | Por qué |
|-----------|--------|---------|
| **Neovim** | 0.11+ | Usa la API moderna `vim.lsp.config` |
| **build-essential** | — | Compila `fzf-native` y los parsers de Treesitter |
| **Node.js** | 18+ (rec. 22) | Copilot y LSPs web |
| **ripgrep** + **fd** | — | Búsquedas de Telescope |
| **Nerd Font** | — | Iconos de la interfaz |

Opcionales: `tmux`, `lazydocker`, `gh` (para PRs), suscripción de GitHub Copilot.

---

## 🚀 Instalación

### 1. Dependencias

```bash
sudo apt update && sudo apt install -y git build-essential ripgrep fd-find
sudo ln -s /usr/bin/fdfind /usr/local/bin/fd
```

### 2. Neovim 0.11+

```bash
sudo add-apt-repository ppa:neovim-ppa/unstable -y && sudo apt update && sudo apt install neovim -y
```

### 3. Nerd Font

```bash
mkdir -p ~/.local/share/fonts && cd ~/.local/share/fonts \
  && wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip \
  && unzip JetBrainsMono.zip -d JetBrainsMono && rm JetBrainsMono.zip && fc-cache -fv
```

Luego actívala en las preferencias de tu terminal.

### 4. Clonar la configuración

```bash
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null; git clone https://github.com/deyby01/deyby-nvim.git ~/.config/nvim
```

### 5. Primera ejecución

```bash
nvim
```

Espera 2-3 minutos: se instalan los plugins, se compilan los parsers y **Mason
instala los 11 LSPs automáticamente**. Cierra con `:qa` y vuelve a abrir.

### 6. Autenticar Copilot (opcional)

```vim
:Copilot auth
```

> 📖 **Guía detallada, alternativas y verificación:** [docs/installation.md](docs/installation.md)

---

## 🔑 Comandos básicos

**Leader key:** `Espacio`

### Lo esencial

| Atajo | Acción |
|-------|--------|
| `Espacio+ff` | Buscar archivos |
| `Espacio+fg` | Buscar texto en el proyecto |
| `Espacio+e` | Explorador de archivos |
| `Espacio+gs` | Git status |
| `Espacio+ld` | Docker: contenedores y logs (LazyDocker) |
| `Ctrl+´` | Terminal integrada |
| `Ctrl+s` / `Ctrl+q` | Guardar / salir sin guardar |
| `jk` | Salir de modo insert |
| `Ctrl+p` | **Buscar cualquier comando** (si olvidas un atajo) |

### Código

| Atajo | Acción |
|-------|--------|
| `gd` / `gr` | Ir a la definición / ver referencias |
| `K` | Documentación del símbolo |
| `Espacio+ca` | Code actions (auto-import, quick fixes) |
| `Espacio+cf` | Formatear |
| `Espacio+rn` | Renombrar en todo el proyecto |
| `Espacio+xx` | Panel de errores |
| `Tab` / `Enter` | Navegar / aceptar el autocompletado |

### Navegación rápida

| Atajo | Acción |
|-------|--------|
| `s` + 2 letras | Saltar a cualquier punto visible |
| `Espacio+a` | Marcar archivo (Harpoon) |
| `Espacio+1..4` | Ir al archivo marcado |
| `Ctrl+h/j/k/l` | Moverse entre splits y paneles de tmux |

> 💡 **No hace falta memorizar nada:** pulsa `Espacio` y espera — which-key
> muestra las opciones. O usa `Ctrl+p` para buscar por nombre.

> 📖 **Los 74 atajos, agrupados por herramienta:** [docs/commands-and-workflow.md](docs/commands-and-workflow.md)

---

## 📚 Documentación

| Documento | Contenido |
|-----------|-----------|
| 📦 **[Instalación](docs/installation.md)** | Guía paso a paso, opcionales, verificación y cómo volver atrás |
| ⌨️ **[Referencia de comandos](docs/commands-and-workflow.md)** | Todos los atajos agrupados por herramienta, con cheatsheet alfabético |
| 🔁 **[Rutina diaria](docs/daily-routine.md)** | Los flujos reales de un dev: explorar código, debuggear, commitear, revisar PRs |
| 🤖 **[IA — Copilot](docs/ai-copilot.md)** | Integración con cmp, filetypes, seguridad y alternativas gratuitas |
| 🧠 **[LSP y autocompletado](docs/lsp-and-completion.md)** | Servidores, linters por `.venv`, formateo y snippets |
| 🐍 **[Django y DRF](docs/django.md)** | Snippets, templates, debugger y tests |
| 🔀 **[Git y GitHub](docs/git-and-github.md)** | Fugitive, GitSigns, Diffview, conflictos y Octo |
| 🖥️ **[tmux](docs/tmux.md)** | Configuración, sesiones y navegación unificada |
| 🔌 **[Plugins](docs/plugins.md)** | Los 56 plugins, estructura, lazy-loading y cómo agregar/quitar |
| 🐛 **[Solución de problemas](docs/troubleshooting.md)** | Diagnóstico de los fallos más comunes |

---

## 📁 Estructura

```
~/.config/nvim/
├── init.lua              # Punto de entrada
├── lazy-lock.json        # Versiones exactas de los plugins
├── lua/
│   ├── config/           # options · keymaps · autocmds
│   └── plugins/          # Un archivo por categoría (ui, editor, lsp, git...)
└── docs/                 # Esta documentación
```

Cada archivo de `lua/plugins/` cubre una categoría: comentando un `import` en
`lua/plugins/init.lua` desactivas el grupo completo.

> 📖 **Detalle de cada módulo:** [docs/plugins.md](docs/plugins.md#estructura-de-archivos)

---

## 🔧 Personalizar

**Cambiar el tema:** edita `lua/plugins/ui.lua`.

**Agregar un lenguaje:** añade el servidor a `ensure_installed` en
`lua/plugins/lsp.lua` — Mason lo instala y activa solo.

**Agregar un plugin:** créalo en el archivo de su categoría dentro de
`lua/plugins/`.

> ⚠️ **Si el plugin trae atajos, ponlos en `keys`, no dentro de `config`** — o
> quedarán muertos. La explicación está en
> [docs/plugins.md](docs/plugins.md#-regla-de-oro-atajos-en-keys-no-en-config).

---

## 🔄 Mantener actualizado

Como `~/.config/nvim` **es** el repositorio clonado, actualizar es un `git pull`:

```bash
cd ~/.config/nvim && git pull
```

Y si haces cambios, los subes desde ahí mismo:

```bash
cd ~/.config/nvim && git add -A && git commit -m "feat: ..." && git push
```

### Rutina mensual

| Qué | Cómo |
|-----|------|
| **Neovim** | `sudo apt update && sudo apt upgrade neovim -y` |
| **Plugins** | `:Lazy sync` — luego commitea `lazy-lock.json` |
| **LSPs** | `:Mason` → pulsa `U` |
| **Treesitter** | `:TSUpdate` |

`lazy-lock.json` fija las versiones exactas: commitéalo tras cada `:Lazy sync`
para que la config sea reproducible entre máquinas. Si una actualización rompe
algo, `:Lazy restore` te devuelve a las versiones del lock.

---

## 🤝 Contribuir

Los issues y PRs son bienvenidos. Si algo no funciona en tu entorno, revisa
primero **[troubleshooting.md](docs/troubleshooting.md)** e incluye en el issue
la salida de `nvim --version` y `:checkhealth`.

---

<div align="center">

**Si te sirvió, deja una ⭐**

Hecho con ☕ por [deyby01](https://github.com/deyby01) · *Julio 2026*

</div>
