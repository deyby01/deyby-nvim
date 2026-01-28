# 📚 Guía de Referencia - Mi Configuración de Neovim

> **Última actualización:** Enero 2026  
> **Tema:** Dracula  
> **Leader Key:** `Espacio`

---

## 📋 Tabla de Contenidos

- [Atajos Básicos de Vim](#-atajos-básicos-de-vim)
- [Navegación](#-navegación)
- [Edición de Texto](#️-edición-de-texto)
- [Gestión de Archivos](#-gestión-de-archivos)
- [Búsqueda con Telescope](#-búsqueda-con-telescope)
- [Explorador de Archivos (NvimTree)](#-explorador-de-archivos-nvimtree)
- [Marcadores con Harpoon](#-marcadores-con-harpoon)
- [Git con Fugitive](#-git-con-fugitive)
- [Terminal con ToggleTerm](#-terminal-con-toggleterm)
- [LSP y Autocompletado](#-lsp-y-autocompletado)
- [Tmux Integration](#-tmux-integration)
- [Comandos Útiles](#-comandos-útiles)

---

## 🎯 Atajos Básicos de Vim

### Modos de Vim

| Modo | Descripción | Cómo entrar |
|------|-------------|-------------|
| **Normal** | Modo por defecto, para navegar y ejecutar comandos | `Esc` |
| **Insert** | Modo de inserción de texto | `i`, `a`, `o` |
| **Visual** | Modo de selección de texto | `v`, `V`, `Ctrl+v` |
| **Command** | Modo de comandos | `:` |

### Entrar a modo INSERT

| Atajo | Acción |
|-------|--------|
| `i` | Insertar antes del cursor |
| `I` | Insertar al inicio de la línea |
| `a` | Insertar después del cursor |
| `A` | Insertar al final de la línea |
| `o` | Nueva línea abajo y entrar a INSERT |
| `O` | Nueva línea arriba y entrar a INSERT |

### Salir de modo INSERT

| Atajo | Acción |
|-------|--------|
| `Esc` | Volver a modo NORMAL |
| `Ctrl+c` | Volver a modo NORMAL (alternativa) |

---

## 🧭 Navegación

### Navegación básica (modo NORMAL)

| Atajo | Acción |
|-------|--------|
| `h` | Mover cursor izquierda |
| `j` | Mover cursor abajo |
| `k` | Mover cursor arriba |
| `l` | Mover cursor derecha |
| `w` | Saltar al inicio de la siguiente palabra |
| `b` | Saltar al inicio de la palabra anterior |
| `e` | Saltar al final de la palabra |
| `0` | Ir al inicio de la línea |
| `$` | Ir al final de la línea |
| `gg` | Ir al inicio del archivo |
| `G` | Ir al final del archivo |
| `{número}G` | Ir a la línea número (ej: `50G`) |
| `Ctrl+d` | Bajar media página |
| `Ctrl+u` | Subir media página |
| `%` | Saltar al paréntesis/corchete correspondiente |

### Navegación entre ventanas (splits)

| Atajo | Acción |
|-------|--------|
| `Ctrl+h` | Ir a ventana izquierda |
| `Ctrl+j` | Ir a ventana abajo |
| `Ctrl+k` | Ir a ventana arriba |
| `Ctrl+l` | Ir a ventana derecha |

### Crear splits

| Comando | Acción |
|---------|--------|
| `:split` o `:sp` | Dividir horizontalmente |
| `:vsplit` o `:vsp` | Dividir verticalmente |
| `:close` | Cerrar ventana actual |
| `:only` | Cerrar todas excepto la actual |

---

## ✏️ Edición de Texto

### Copiar, Cortar, Pegar

| Atajo | Acción |
|-------|--------|
| `yy` | Copiar línea completa |
| `y{movimiento}` | Copiar (ej: `yw` copia palabra) |
| `dd` | Cortar línea completa |
| `d{movimiento}` | Cortar (ej: `dw` corta palabra) |
| `p` | Pegar después del cursor |
| `P` | Pegar antes del cursor |
| `x` | Borrar carácter bajo el cursor |
| `u` | Deshacer |
| `Ctrl+r` | Rehacer |

### Buscar y reemplazar

| Comando | Acción |
|---------|--------|
| `/texto` | Buscar "texto" hacia adelante |
| `?texto` | Buscar "texto" hacia atrás |
| `n` | Ir a siguiente coincidencia |
| `N` | Ir a anterior coincidencia |
| `:%s/viejo/nuevo/g` | Reemplazar "viejo" por "nuevo" en todo el archivo |
| `:%s/viejo/nuevo/gc` | Igual pero pidiendo confirmación |

### Indentar y formatear

| Atajo | Acción |
|-------|--------|
| `>>` | Indentar línea a la derecha |
| `<<` | Indentar línea a la izquierda |
| `={movimiento}` | Auto-indentar (ej: `gg=G` formatea todo) |
| `J` | Unir línea actual con la siguiente |

---

## 💾 Gestión de Archivos

### Guardar y salir

| Atajo/Comando | Acción |
|---------------|--------|
| `Ctrl+s` | **Guardar archivo** ⭐ |
| `:w` | Guardar archivo |
| `:w nombre.txt` | Guardar como "nombre.txt" |
| `:q` | Salir (si no hay cambios) |
| `Ctrl+q` | **Salir sin guardar** ⭐ |
| `:q!` | Salir sin guardar |
| `:wq` | Guardar y salir |
| `:qa` | Cerrar todas las ventanas |

### Trabajar con buffers

| Comando | Acción |
|---------|--------|
| `:e archivo.txt` | Abrir archivo |
| `:bnext` o `:bn` | Siguiente buffer |
| `:bprev` o `:bp` | Buffer anterior |
| `:bd` | Cerrar buffer actual |
| `:buffers` o `:ls` | Listar todos los buffers |

---

## 🔍 Búsqueda con Telescope

**Telescope** es tu herramienta principal para encontrar archivos y contenido rápidamente.

### Atajos de Telescope

| Atajo | Acción |
|-------|--------|
| `Espacio + ff` | **Buscar archivos** en proyecto actual ⭐ |
| `Espacio + fg` | **Buscar contenido** (grep) en proyecto actual ⭐ |
| `Espacio + fb` | **Buscar entre buffers** abiertos |
| `Espacio + fp` | **Buscar archivos en TODOS los proyectos** (~/Documents) 🚀 |
| `Espacio + fP` | **Buscar contenido en TODOS los proyectos** (~/Documents) 🚀 |

### Navegación dentro de Telescope

| Atajo | Acción |
|-------|--------|
| `Ctrl+j` | Bajar en la lista |
| `Ctrl+k` | Subir en la lista |
| `Enter` | Abrir archivo seleccionado |
| `Esc` | Cerrar Telescope |
| `Ctrl+x` | Abrir en split horizontal |
| `Ctrl+v` | Abrir en split vertical |

---

## 📁 Explorador de Archivos (NvimTree)

**NvimTree** es tu explorador visual de archivos, como el sidebar de VSCode.

### Atajos principales

| Atajo | Acción |
|-------|--------|
| `Espacio + e` | **Abrir/Cerrar NvimTree** ⭐ |

### Dentro de NvimTree

| Atajo | Acción |
|-------|--------|
| `Enter` | Abrir archivo o expandir carpeta |
| `o` | Abrir archivo |
| `a` | Crear archivo/carpeta (termina con `/` para carpeta) |
| `d` | Borrar archivo/carpeta |
| `r` | Renombrar archivo/carpeta |
| `x` | Cortar archivo |
| `c` | Copiar archivo |
| `p` | Pegar archivo |
| `R` | Refrescar árbol |
| `H` | Mostrar/ocultar archivos ocultos |
| `Ctrl+]` | Cambiar directorio raíz a carpeta actual |
| `q` | Cerrar NvimTree |

---

## 🎯 Marcadores con Harpoon

**Harpoon** te permite marcar archivos frecuentes y saltar entre ellos instantáneamente.

### Atajos de Harpoon

| Atajo | Acción |
|-------|--------|
| `Espacio + a` | **Marcar archivo actual** ⭐ |
| `Espacio + h` | **Ver lista de archivos marcados** ⭐ |
| `Espacio + 1` | Saltar al archivo marcado #1 |
| `Espacio + 2` | Saltar al archivo marcado #2 |
| `Espacio + 3` | Saltar al archivo marcado #3 |
| `Espacio + 4` | Saltar al archivo marcado #4 |

### Workflow recomendado

1. Abre tus archivos más importantes del proyecto
2. Marca cada uno con `Espacio + a`
3. Salta entre ellos con `Espacio + 1/2/3/4`
4. No más búsquedas repetitivas 🚀

---

## 🔀 Git con Fugitive

**Fugitive** integra Git directamente en Neovim.

### Atajos de Git

| Atajo/Comando | Acción |
|---------------|--------|
| `Espacio + gs` | **Abrir Git status** ⭐ |
| `:Git add %` | Agregar archivo actual al stage |
| `:Git commit` | Hacer commit |
| `:Git push` | Push a remoto |
| `:Git pull` | Pull desde remoto |
| `:Git log` | Ver historial de commits |
| `:Git diff` | Ver diferencias |
| `:Git blame` | Ver quién escribió cada línea |

### Dentro de Git status

| Atajo | Acción |
|-------|--------|
| `s` | Stage/unstage archivo bajo cursor |
| `u` | Unstage archivo |
| `cc` | Crear commit |
| `=` | Ver diff del archivo |

---

## 💻 Terminal con ToggleTerm

**ToggleTerm** te da una terminal integrada estilo VSCode.

### Atajos de Terminal

| Atajo | Acción |
|-------|--------|
| `Ctrl + ´` | **Toggle terminal horizontal** ⭐ |
| `Espacio + tt` | Abrir terminal horizontal |
| `Espacio + ld` | **Abrir LazyDocker** (flotante) 🐳 |

### Dentro de la terminal

| Atajo | Acción |
|-------|--------|
| `Esc` | Salir del modo terminal (ir a modo NORMAL) |
| `i` o `a` | Volver al modo terminal |
| `Ctrl+h/j/k/l` | Navegar entre ventanas |

### Comandos útiles en terminal

```bash
# Iniciar servidor de desarrollo
python manage.py runserver

# Ver logs de Docker
docker logs -f nombre-contenedor

# Git status
git status

# Correr tests
pytest
```

---

## 🧠 LSP y Autocompletado

**LSP** (Language Server Protocol) te da inteligencia de código: autocompletado, ir a definición, etc.

### Language Servers instalados

- **Python**: Pyright
- **HTML**: HTML Language Server
- **Emmet**: Emmet para HTML/CSS

### Atajos de LSP

| Atajo | Acción |
|-------|--------|
| `gd` | **Ir a definición** ⭐ |
| `gr` | **Ver referencias** (dónde se usa esto) |
| `K` | **Mostrar documentación** (hover) ⭐ |
| `Espacio + rn` | **Renombrar símbolo** |
| `Espacio + ca` | **Ver code actions** (acciones disponibles) |

### Autocompletado (nvim-cmp)

| Atajo | Acción |
|-------|--------|
| `Ctrl+Space` | Activar autocompletado |
| `Ctrl+n` | Siguiente sugerencia |
| `Ctrl+p` | Anterior sugerencia |
| `Enter` | Aceptar sugerencia |
| `Ctrl+e` | Cerrar autocompletado |
| `Ctrl+f` | Scroll down en documentación |
| `Ctrl+b` | Scroll up en documentación |

### Instalar más Language Servers

```vim
:Mason
```

Esto abre el gestor de LSP donde puedes instalar más servidores para otros lenguajes.

---

## 🖥️ Tmux Integration

**Vim-tmux-navigator** permite navegar fluidamente entre paneles de Vim y Tmux.

### Navegación unificada

| Atajo | Acción |
|-------|--------|
| `Ctrl+h` | Ir al panel izquierdo (Vim o Tmux) |
| `Ctrl+j` | Ir al panel abajo (Vim o Tmux) |
| `Ctrl+k` | Ir al panel arriba (Vim o Tmux) |
| `Ctrl+l` | Ir al panel derecha (Vim o Tmux) |

### Comandos básicos de Tmux

**Prefijo de Tmux:** `Ctrl+a`

| Atajo | Acción |
|-------|--------|
| `Ctrl+a \|` | Dividir verticalmente |
| `Ctrl+a -` | Dividir horizontalmente |
| `Ctrl+a c` | Nueva ventana |
| `Ctrl+a n` | Siguiente ventana |
| `Ctrl+a p` | Ventana anterior |
| `Ctrl+a d` | Desconectar de sesión |
| `Ctrl+a s` | Lista de sesiones |
| `Ctrl+a x` | Cerrar panel actual |

### Workflow con Tmux

```bash
# Crear sesión para proyecto frontend
tmux new -s frontend
cd ~/Documents/proyecto-web
nvim

# Crear sesión para backend (en otra terminal)
tmux new -s backend
cd ~/Documents/api
nvim

# Ver sesiones activas
tmux ls

# Adjuntarse a sesión
tmux attach -t frontend

# Dentro de tmux, cambiar de sesión
Ctrl+a s  # y selecciona con flechas
```

---

## 📌 Comandos Útiles

### Información del sistema

| Comando | Acción |
|---------|--------|
| `:checkhealth` | Verificar salud de Neovim |
| `:version` | Ver versión de Neovim |
| `:Lazy` | Abrir gestor de plugins |
| `:Mason` | Abrir gestor de LSP |

### Configuración

| Comando | Acción |
|---------|--------|
| `:e ~/.config/nvim/init.lua` | Editar configuración |
| `:source %` | Recargar archivo actual |
| `:Lazy sync` | Sincronizar plugins |

### Edición masiva

| Comando | Acción |
|---------|--------|
| `Ctrl+v` (visual block) | Selección en columna |
| `I` (después de visual block) | Insertar en múltiples líneas |
| `A` (después de visual block) | Añadir al final de múltiples líneas |

---

## 🎨 Personalización Rápida

### Cambiar tamaño de splits

```vim
:resize +5        " Aumentar altura
:resize -5        " Reducir altura
:vertical resize +5    " Aumentar ancho
:vertical resize -5    " Reducir ancho
```

### Números de línea

```vim
:set number           " Mostrar números
:set relativenumber   " Números relativos
:set nonumber         " Ocultar números
```

---

## 🚀 Tips y Trucos

### Macros

1. Grabar macro: `qa` (graba en registro 'a')
2. Ejecutar acciones
3. Terminar grabación: `q`
4. Ejecutar macro: `@a`
5. Repetir: `@@`

### Marks (Marcas)

| Atajo | Acción |
|-------|--------|
| `ma` | Crear marca 'a' |
| `` `a `` | Ir a marca 'a' |
| `'a` | Ir a línea de marca 'a' |

### Búsqueda incremental

```vim
/palabra    " Buscar mientras escribes
*           " Buscar palabra bajo cursor
#           " Buscar palabra bajo cursor (atrás)
```

### Multi-cursor (Treesitter)

```vim
" Seleccionar palabras iguales
1. Coloca cursor en palabra
2. Ctrl+n para seleccionar siguiente
3. c para cambiar todas
```

---

## 📚 Recursos Adicionales

- **Documentación de Neovim**: `:help`
- **Documentación de plugins**: `:help telescope`, `:help harpoon`, etc.
- **Aprender Vim**: `vimtutor` (en terminal)

---

## 🎯 Workflow Diario Recomendado

1. **Iniciar tmux**: `tmux new -s proyecto`
2. **Abrir Neovim**: `nvim`
3. **Buscar archivo**: `Espacio + ff`
4. **Marcar archivos frecuentes**: `Espacio + a`
5. **Saltar entre archivos**: `Espacio + 1/2/3/4`
6. **Abrir terminal**: `Ctrl + ´`
7. **Git status**: `Espacio + gs`
8. **Buscar en todos los proyectos**: `Espacio + fp`

---

**¡Happy coding! 🚀**

*Esta guía está viva y se actualiza con tu configuración.*
