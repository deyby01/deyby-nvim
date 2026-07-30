# 🖥️ tmux — Sesiones y Multiplexado

> Mantén varios proyectos abiertos, sobrevive a cierres de terminal y navega
> entre paneles de tmux y splits de Neovim con las mismas teclas.

**Plugin de integración:** `vim-tmux-navigator`
**Archivo de config de Neovim:** [`lua/plugins/terminal.lua`](../lua/plugins/terminal.lua)

---

## 📋 Contenido

- [Por qué tmux](#por-qué-tmux)
- [Instalación y configuración](#instalación-y-configuración)
- [Comandos de sesión](#comandos-de-sesión)
- [Atajos de tmux](#atajos-de-tmux)
- [Navegación unificada con Neovim](#navegación-unificada-con-neovim)
- [Terminal integrada vs tmux](#terminal-integrada-vs-tmux)
- [Workflow multiproyecto](#workflow-multiproyecto)

---

## Por qué tmux

Con esta configuración de Neovim ya tienes `auto-session` (restaura tu sesión al
volver a una carpeta) y `toggleterm` (terminal integrada). tmux resuelve algo distinto:

| Necesidad | Solución |
|-----------|----------|
| El `runserver` sigue vivo aunque cierre la terminal | ✅ tmux |
| Trabajar en 3 proyectos a la vez y saltar entre ellos | ✅ tmux |
| Reconectar por SSH y encontrar todo como lo dejaste | ✅ tmux |
| Recuperar los archivos abiertos al volver a un proyecto | ✅ auto-session |
| Una terminal rápida para un comando puntual | ✅ toggleterm (`Ctrl+´`) |

---

## Instalación y configuración

```bash
sudo apt install tmux -y
```

Crea `~/.tmux.conf`:

```bash
nvim ~/.tmux.conf
```

Configuración recomendada (compatible con esta config de Neovim):

```bash
# Prefijo Ctrl+a en vez de Ctrl+b (más cómodo)
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

# Recargar configuración
bind r source-file ~/.tmux.conf \; display "Config recargada!"

# Mouse habilitado
set -g mouse on

# Numeración desde 1
set -g base-index 1
setw -g pane-base-index 1

# Colores (necesario para que Dracula se vea bien)
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",xterm-256color:Tc"

# Historial más grande
set -g history-limit 10000

# No renombrar ventanas automáticamente
set-option -g allow-rename off
```

Aplicar sin reiniciar:

```bash
tmux source-file ~/.tmux.conf
```

> 💡 **`terminal-overrides` con `Tc`** habilita true color. Sin esta línea, el
> tema Dracula se ve con colores degradados dentro de tmux.

### Integración con vim-tmux-navigator

Para que `Ctrl+h/j/k/l` funcionen **entre** tmux y Neovim, agrega a `~/.tmux.conf`:

```bash
# Smart pane switching con detección de Vim
is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'
```

Sin esto, `Ctrl+h/j/k/l` solo navegan splits dentro de Neovim.

---

## Comandos de sesión

Desde la terminal (no dentro de tmux):

| Comando | Acción |
|---------|--------|
| `tmux new -s nombre` | Crear sesión con nombre |
| `tmux ls` | Listar sesiones activas |
| `tmux attach -t nombre` | Reconectar a una sesión |
| `tmux attach` | Reconectar a la última |
| `tmux kill-session -t nombre` | Cerrar una sesión |
| `tmux kill-server` | Cerrar todo ⚠️ |

---

## Atajos de tmux

**Prefijo:** `Ctrl+a` (se presiona, se suelta, y luego la tecla)

### Sesiones

| Atajo | Acción |
|-------|--------|
| `Ctrl+a d` | **Detach** — salir dejando todo corriendo |
| `Ctrl+a s` | Lista interactiva de **sesiones** |
| `Ctrl+a $` | Renombrar la sesión |

### Ventanas (como pestañas)

| Atajo | Acción |
|-------|--------|
| `Ctrl+a c` | **Crear** ventana |
| `Ctrl+a n` | Ventana **siguiente** |
| `Ctrl+a p` | Ventana **anterior** |
| `Ctrl+a {número}` | Ir a la ventana N |
| `Ctrl+a w` | Lista de ventanas |
| `Ctrl+a ,` | Renombrar ventana |
| `Ctrl+a &` | Cerrar ventana |

### Paneles (splits)

| Atajo | Acción |
|-------|--------|
| `Ctrl+a \|` | Dividir **vertical** |
| `Ctrl+a -` | Dividir **horizontal** |
| `Ctrl+a x` | Cerrar el panel actual |
| `Ctrl+a z` | **Zoom** — pantalla completa (toggle) |
| `Ctrl+a {` / `}` | Mover el panel de posición |
| `Alt+↑↓←→` | Redimensionar panel |
| `Ctrl+h/j/k/l` | Navegar paneles (sin prefijo, ver [integración](#navegación-unificada-con-neovim)) |

### Copiar texto

| Atajo | Acción |
|-------|--------|
| `Ctrl+a [` | Entrar a modo copia |
| `Espacio` | Empezar la selección |
| `Enter` | Copiar y salir |
| `Ctrl+a ]` | Pegar |

> 💡 `Ctrl+a z` (zoom) es de los más útiles: te da pantalla completa temporal
> sin tener que cerrar los otros paneles.

---

## Navegación unificada con Neovim

Con `vim-tmux-navigator` + la config de `~/.tmux.conf`, las mismas cuatro teclas
funcionan sin importar dónde estés:

| Atajo | Acción |
|-------|--------|
| `Ctrl+h` | Panel/split de la **izquierda** |
| `Ctrl+j` | Panel/split de **abajo** |
| `Ctrl+k` | Panel/split de **arriba** |
| `Ctrl+l` | Panel/split de la **derecha** |

**El plugin detecta el borde:** si estás en el split más a la izquierda de
Neovim y pulsas `Ctrl+h`, salta al panel de tmux que está a la izquierda. No hay
que cambiar de "modo" mental.

### También funciona en la terminal integrada

Los mismos atajos están mapeados en modo terminal de Neovim, así que desde
`Ctrl+´` puedes volver al código con `Ctrl+k` sin salir del modo terminal.

---

## Terminal integrada vs tmux

Ambas conviven. Cuándo usar cada una:

| Situación | Usa |
|-----------|-----|
| Un comando rápido (`git log`, `ls`, `pip install`) | `Ctrl+´` (toggleterm) |
| Ver contenedores Docker | `Espacio+ld` (LazyDocker flotante) |
| `runserver` que debe sobrevivir el cierre de nvim | Panel de tmux |
| Logs de Docker en seguimiento continuo | Panel de tmux |
| Cambiar entre proyectos completos | Sesiones de tmux |

### Atajos de la terminal integrada

| Atajo | Acción |
|-------|--------|
| `Ctrl+´` | Toggle terminal horizontal |
| `Espacio+tt` | Igual (alternativa) |
| `Espacio+ld` | LazyDocker en ventana flotante |
| `Esc` | Salir del modo terminal a modo normal |
| `i` / `a` | Volver al modo terminal |

---

## Workflow multiproyecto

### Lunes — arrancar el frontend

```bash
tmux new -s frontend
cd ~/Documents/proyecto-web
nvim

# Dividir para el servidor
Ctrl+a -            # panel abajo
npm run dev

Ctrl+k              # volver a Neovim (vim-tmux-navigator)
```

### Martes — hay que tocar el backend sin perder el frontend

```bash
Ctrl+a d                    # detach: el frontend sigue corriendo

tmux new -s backend
cd ~/Documents/api
source .venv/bin/activate
nvim

Ctrl+a -
python manage.py runserver
```

### Saltar entre proyectos

```bash
Ctrl+a s            # lista de sesiones → flechas → Enter
```

### Viernes — ver qué tengo abierto

```bash
tmux ls
# frontend: 2 windows (created Mon Jul 27 09:12:03 2026)
# backend:  2 windows (created Tue Jul 28 10:45:31 2026)
```

### Lunes siguiente — retomar

```bash
tmux attach -t frontend
# Todo intacto: Neovim, archivos abiertos, el dev server corriendo
```

### Layout recomendado por proyecto

```
┌─────────────────────────────────┐
│                                 │
│           Neovim                │  ← Ctrl+a z para zoom
│                                 │
├─────────────────┬───────────────┤
│   runserver     │   terminal    │
│   (logs)        │   (comandos)  │
└─────────────────┴───────────────┘
```

Se construye con: `Ctrl+a -` (dividir abajo) y luego `Ctrl+a |` (dividir ese panel).

---

## Problemas comunes

### Los colores se ven mal dentro de tmux

Falta el `terminal-overrides`. Verifica:

```bash
echo $TERM          # debe ser screen-256color dentro de tmux
tmux info | grep Tc
```

Agrega a `~/.tmux.conf`:

```bash
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",xterm-256color:Tc"
```

### `Ctrl+h/j/k/l` no salta entre tmux y Neovim

Falta el bloque `is_vim` en `~/.tmux.conf` (ver [integración](#integración-con-vim-tmux-navigator)).

### El prefijo `Ctrl+a` choca con "ir al inicio de línea" de bash

Es el trade-off de usar `Ctrl+a`. Alternativas: usar `Ctrl+a a` para enviar el
`Ctrl+a` literal (ya está mapeado con `send-prefix`), o cambiar el prefijo a
`Ctrl+Espacio`:

```bash
set-option -g prefix C-Space
```

---

[⬅️ Volver al README](../README.md) · [Plugins ➡️](plugins.md)
