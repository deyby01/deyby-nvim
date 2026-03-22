# 📚 Guía de Referencia Completa - Neovim

> **Última actualización:** Marzo 2026
> **Tema:** Dracula
> **Leader Key:** `Espacio`
> **Estructura:** Modular

---

## 📋 Tabla de Contenidos

- [Atajos Básicos de Vim](#-atajos-básicos-de-vim)
- [Navegación](#-navegación)
- [Edición de Texto](#️-edición-de-texto)
- [Gestión de Archivos y Ventanas](#-gestión-de-archivos-y-ventanas)
- [Búsqueda con Telescope](#-búsqueda-con-telescope)
- [Explorador de Archivos (NvimTree)](#-explorador-de-archivos-nvimtree)
- [Marcadores con Harpoon](#-marcadores-con-harpoon)
- [Git (Fugitive + GitSigns)](#-git-fugitive--gitsigns)
- [Terminal (ToggleTerm)](#-terminal-toggleterm)
- [LSP y Autocompletado](#-lsp-y-autocompletado)
- [C++ - Compilar y Ejecutar](#-c---compilar-y-ejecutar)
- [Debugger (nvim-dap)](#-debugger-nvim-dap)
- [Navegación Rápida (Flash)](#-navegación-rápida-flash)
- [Surround](#-surround)
- [TODO Comments](#-todo-comments)
- [Tmux Integration](#-tmux-integration)
- [Comandos Avanzados](#-comandos-avanzados)
- [Trucos y Tips](#-trucos-y-tips)

---

## 🎯 Atajos Básicos de Vim

### Modos de Vim

| Modo | Descripción | Cómo entrar | Cómo salir |
|------|-------------|-------------|------------|
| **Normal** | Navegación y comandos | `Esc` | N/A (modo por defecto) |
| **Insert** | Inserción de texto | `i` `a` `o` `I` `A` `O` | `Esc` o `jk` o `kj` |
| **Visual** | Selección de texto | `v` `V` `Ctrl+v` | `Esc` |
| **Visual Line** | Selección de líneas completas | `V` | `Esc` |
| **Visual Block** | Selección de bloques | `Ctrl+v` | `Esc` |
| **Command** | Ejecutar comandos Ex | `:` | `Esc` o `Ctrl+c` |

### Entrar a modo INSERT

| Atajo | Acción |
|-------|--------|
| `i` | Insertar **antes** del cursor |
| `I` | Insertar al **inicio** de la línea |
| `a` | Insertar **después** del cursor |
| `A` | Insertar al **final** de la línea |
| `o` | Nueva línea **abajo** y entrar a INSERT |
| `O` | Nueva línea **arriba** y entrar a INSERT |
| `s` | Borrar carácter y entrar a INSERT |
| `S` | Borrar línea y entrar a INSERT |
| `C` | Borrar desde cursor hasta final de línea y entrar a INSERT |

### Salir de modo INSERT

| Atajo | Acción |
|-------|--------|
| `Esc` | Volver a modo NORMAL |
| `jk` | Volver a modo NORMAL (atajo personalizado) ⭐ |
| `kj` | Volver a modo NORMAL (atajo personalizado) ⭐ |
| `Ctrl+c` | Volver a modo NORMAL (alternativa) |
| `Ctrl+[` | Volver a modo NORMAL (nativo de Vim) |

---

## 🧭 Navegación

### Navegación básica (modo NORMAL)

| Atajo | Acción |
|-------|--------|
| `h` | Mover cursor **izquierda** |
| `j` | Mover cursor **abajo** |
| `k` | Mover cursor **arriba** |
| `l` | Mover cursor **derecha** |
| `w` | Saltar al **inicio** de la siguiente palabra |
| `W` | Saltar al inicio de la siguiente PALABRA (ignora puntuación) |
| `b` | Saltar al **inicio** de la palabra anterior |
| `B` | Saltar al inicio de la PALABRA anterior (ignora puntuación) |
| `e` | Saltar al **final** de la palabra |
| `E` | Saltar al final de la PALABRA (ignora puntuación) |
| `0` | Ir al **inicio** de la línea |
| `^` | Ir al **primer carácter no blanco** de la línea |
| `$` | Ir al **final** de la línea |
| `gg` | Ir al **inicio** del archivo |
| `G` | Ir al **final** del archivo |
| `{número}G` | Ir a la **línea número** (ej: `50G` va a línea 50) |
| `{número}gg` | Ir a la línea número (alternativa) |
| `Ctrl+d` | Bajar **media página** |
| `Ctrl+u` | Subir **media página** |
| `Ctrl+f` | Bajar **página completa** |
| `Ctrl+b` | Subir **página completa** |
| `%` | Saltar al **paréntesis/corchete/llave** correspondiente |
| `{` | Saltar al **párrafo anterior** |
| `}` | Saltar al **párrafo siguiente** |
| `(` | Saltar a la **frase anterior** |
| `)` | Saltar a la **frase siguiente** |

### Navegación entre ventanas (splits)

| Atajo | Acción |
|-------|--------|
| `Ctrl+h` | Ir a ventana **izquierda** ⭐ |
| `Ctrl+j` | Ir a ventana **abajo** ⭐ |
| `Ctrl+k` | Ir a ventana **arriba** ⭐ |
| `Ctrl+l` | Ir a ventana **derecha** ⭐ |
| `Ctrl+w w` | Ciclar entre ventanas |
| `Ctrl+w p` | Ir a ventana **anterior** |
| `Ctrl+w =` | **Igualar tamaño** de todas las ventanas |
| `Ctrl+w >` | Aumentar **ancho** de ventana |
| `Ctrl+w <` | Reducir **ancho** de ventana |
| `Ctrl+w +` | Aumentar **altura** de ventana |
| `Ctrl+w -` | Reducir **altura** de ventana |

### Crear y gestionar splits

| Atajo/Comando | Acción |
|---------------|--------|
| `Espacio+v` | Panel nuevo a la **derecha** ⭐ |
| `Espacio+s` | Panel nuevo **abajo** ⭐ |
| `Espacio+q` | **Cerrar** panel actual ⭐ |
| `Espacio+o` | Cerrar **todos** excepto el actual ⭐ |
| `:split` o `:sp` | Dividir **horizontalmente** |
| `:vsplit` o `:vsp` | Dividir **verticalmente** |
| `:close` | Cerrar ventana actual |
| `:only` | Cerrar todas excepto la actual |

### Navegación inteligente

| Atajo | Acción |
|-------|--------|
| `*` | Buscar palabra bajo cursor (hacia adelante) |
| `#` | Buscar palabra bajo cursor (hacia atrás) |
| `f{carácter}` | Saltar al siguiente `{carácter}` en la línea |
| `F{carácter}` | Saltar al anterior `{carácter}` en la línea |
| `t{carácter}` | Saltar **hasta antes** del siguiente `{carácter}` |
| `T{carácter}` | Saltar **hasta antes** del anterior `{carácter}` |
| `;` | Repetir último `f`, `F`, `t`, `T` |
| `,` | Repetir último `f`, `F`, `t`, `T` en dirección opuesta |

---

## ✏️ Edición de Texto

### Copiar, Cortar, Pegar

| Atajo | Acción |
|-------|--------|
| `yy` o `Y` | **Copiar** línea completa |
| `y{movimiento}` | Copiar (ej: `yw` copia palabra, `y$` copia hasta final de línea) |
| `dd` | **Cortar** línea completa |
| `d{movimiento}` | Cortar (ej: `dw` corta palabra, `d$` corta hasta final) |
| `D` | Cortar desde cursor hasta final de línea |
| `p` | **Pegar** después del cursor |
| `P` | Pegar antes del cursor |
| `x` | Borrar carácter bajo el cursor |
| `X` | Borrar carácter antes del cursor |
| `c{movimiento}` | Cambiar (borrar y entrar a INSERT) |
| `C` | Cambiar desde cursor hasta final de línea |
| `u` | **Deshacer** ⭐ |
| `Ctrl+r` | **Rehacer** ⭐ |
| `.` | **Repetir** última acción ⭐ |

### Buscar y reemplazar

| Comando | Acción |
|---------|--------|
| `/texto` | Buscar "texto" hacia **adelante** |
| `?texto` | Buscar "texto" hacia **atrás** |
| `n` | Ir a **siguiente** coincidencia |
| `N` | Ir a **anterior** coincidencia |
| `*` | Buscar palabra bajo cursor (adelante) |
| `#` | Buscar palabra bajo cursor (atrás) |
| `:%s/viejo/nuevo/g` | Reemplazar "viejo" por "nuevo" en **todo el archivo** |
| `:%s/viejo/nuevo/gc` | Igual pero pidiendo **confirmación** |
| `:s/viejo/nuevo/g` | Reemplazar en **línea actual** |
| `:'<,'>s/viejo/nuevo/g` | Reemplazar en **selección visual** |
| `:%s/viejo/nuevo/gi` | Reemplazar ignorando **mayúsculas/minúsculas** |

### Indentar y formatear

| Atajo | Acción |
|-------|--------|
| `>>` | Indentar línea a la **derecha** |
| `<<` | Indentar línea a la **izquierda** |
| `={movimiento}` | **Auto-indentar** (ej: `gg=G` formatea todo el archivo) ⭐ |
| `==` | Auto-indentar **línea actual** |
| `J` | **Unir** línea actual con la siguiente |
| `gJ` | Unir sin agregar espacio |
| `~` | Cambiar **mayúscula/minúscula** del carácter |
| `gu{movimiento}` | Convertir a **minúsculas** |
| `gU{movimiento}` | Convertir a **MAYÚSCULAS** |

### Modo visual (selección)

| Atajo | Acción |
|-------|--------|
| `v` | Modo visual (selección por caracteres) |
| `V` | Modo visual por **líneas** |
| `Ctrl+v` | Modo visual en **bloque** (columnas) |
| `o` | Mover al **otro extremo** de la selección |
| `gv` | **Re-seleccionar** última selección |
| `>` | Indentar selección a la derecha |
| `<` | Indentar selección a la izquierda |
| `=` | Auto-indentar selección |

---

## 💾 Gestión de Archivos y Ventanas

### Guardar y salir

| Atajo/Comando | Acción |
|---------------|--------|
| `Ctrl+s` | **Guardar archivo** ⭐ |
| `:w` | Guardar archivo |
| `:w nombre.txt` | Guardar como "nombre.txt" |
| `:w!` | Guardar **forzado** (sobreescribir archivo de solo lectura) |
| `:q` | Salir (si no hay cambios) |
| `Ctrl+q` | **Salir sin guardar** ⭐ |
| `:q!` | Salir sin guardar (forzado) |
| `:wq` | Guardar **y** salir |
| `:x` | Guardar y salir (solo si hay cambios) |
| `ZZ` | Guardar y salir (atajo rápido) |
| `ZQ` | Salir sin guardar (atajo rápido) |
| `:qa` | Cerrar **todas** las ventanas |
| `:qa!` | Cerrar todas sin guardar |
| `:wqa` | Guardar todo y cerrar todo |

### Trabajar con buffers

| Comando | Acción |
|---------|--------|
| `:e archivo.txt` | Abrir archivo |
| `:e .` | Abrir explorador de archivos (Netrw) |
| `:bnext` o `:bn` | Siguiente buffer |
| `:bprev` o `:bp` | Buffer anterior |
| `:bd` | Cerrar buffer actual |
| `:bd!` | Cerrar buffer forzado |
| `:buffers` o `:ls` | Listar todos los buffers |
| `:b{número}` | Ir al buffer número X |
| `:b nombre` | Ir al buffer por nombre (autocompletado con Tab) |

### Tabs (pestañas)

| Comando | Acción |
|---------|--------|
| `:tabnew` | Nueva **pestaña** |
| `:tabnew archivo` | Abrir archivo en nueva pestaña |
| `gt` | Siguiente pestaña |
| `gT` | Anterior pestaña |
| `{número}gt` | Ir a pestaña número X |
| `:tabclose` | Cerrar pestaña actual |
| `:tabonly` | Cerrar todas excepto la actual |

---

## 🔍 Búsqueda con Telescope

**Telescope** es tu herramienta principal para encontrar archivos y contenido.

### Atajos de Telescope

| Atajo | Acción |
|-------|--------|
| `Espacio+ff` | **Buscar archivos** en proyecto actual ⭐ |
| `Espacio+fg` | **Buscar contenido** (grep) en proyecto actual ⭐ |
| `Espacio+fb` | **Buscar entre buffers** abiertos |
| `Espacio+fp` | **Buscar archivos en TODOS los proyectos** (~/Documents) 🚀 |
| `Espacio+fP` | **Buscar contenido en TODOS los proyectos** 🚀 |
| `Espacio+ft` | **Buscar TODOs** del proyecto 🆕 |

### Navegación dentro de Telescope

| Atajo | Acción |
|-------|--------|
| `Ctrl+j` | **Bajar** en la lista |
| `Ctrl+k` | **Subir** en la lista |
| `Enter` | **Abrir** archivo seleccionado |
| `Ctrl+x` | Abrir en **split horizontal** |
| `Ctrl+v` | Abrir en **split vertical** |
| `Ctrl+t` | Abrir en nueva **pestaña** |
| `Esc` | **Cerrar** Telescope |
| `Ctrl+u` | **Scroll up** en preview |
| `Ctrl+d` | **Scroll down** en preview |
| `Ctrl+q` | Enviar resultados a **quickfix list** |

### Tips de búsqueda en Telescope

- **Búsqueda fuzzy:** No necesitas escribir el nombre completo
  - Buscas `models.py` → puedes escribir `mdpy` o `mopy`
- **Búsqueda en ruta:** Incluye parte de la ruta
  - `app/models` encuentra archivos models.py dentro de app/
- **Búsqueda de contenido:** `Espacio+fg` busca dentro de archivos
  - Perfecto para encontrar funciones, clases, variables

---

## 📁 Explorador de Archivos (NvimTree)

**NvimTree** es tu explorador visual de archivos lateral.

### Atajos principales

| Atajo | Acción |
|-------|--------|
| `Espacio+e` | **Toggle NvimTree** (abrir/cerrar) ⭐ |
| `Espacio++` | **Aumentar ancho** de NvimTree |
| `Espacio+-` | **Reducir ancho** de NvimTree |

### Dentro de NvimTree

| Atajo | Acción |
|-------|--------|
| `Enter` | Abrir archivo o **expandir** carpeta |
| `o` | Abrir archivo |
| `<Tab>` | Abrir archivo pero mantener cursor en NvimTree |
| `a` | **Crear** archivo/carpeta (termina con `/` para carpeta) ⭐ |
| `d` | **Borrar** archivo/carpeta |
| `r` | **Renombrar** archivo/carpeta |
| `x` | **Cortar** archivo |
| `c` | **Copiar** archivo |
| `p` | **Pegar** archivo |
| `m` | **Mover** archivo |
| `y` | Copiar **nombre** del archivo |
| `Y` | Copiar **ruta relativa** |
| `gy` | Copiar **ruta absoluta** |
| `R` | **Refrescar** árbol |
| `H` | **Toggle** archivos ocultos (.env, .git, etc) ⭐ |
| `I` | Toggle archivos ignorados (.gitignore) |
| `Ctrl+]` | Cambiar directorio raíz a carpeta actual |
| `Backspace` | Subir al directorio **padre** |
| `-` | Subir al directorio padre (alternativa) |
| `s` | Abrir en **split vertical** |
| `i` | Abrir en **split horizontal** |
| `t` | Abrir en nueva **pestaña** |
| `q` | **Cerrar** NvimTree |

### Crear archivos y carpetas

```
a                       # Presionar 'a' dentro de NvimTree
nombre.py               # Crear archivo
carpeta/                # Crear carpeta (termina con /)
carpeta/archivo.py      # Crear carpeta + archivo
```

> 💡 **Tip C++:** Al crear un archivo `.cpp` dentro de `week_*` o `tasks_unab_cplus/*/`, se crea automáticamente un `Makefile` en esa carpeta.

---

## 🎯 Marcadores con Harpoon

**Harpoon** te permite marcar archivos frecuentes y saltar entre ellos instantáneamente.

### Atajos de Harpoon

| Atajo | Acción |
|-------|--------|
| `Espacio+a` | **Marcar** archivo actual ⭐ |
| `Espacio+h` | **Ver lista** de archivos marcados ⭐ |
| `Espacio+1` | Saltar al archivo marcado **#1** |
| `Espacio+2` | Saltar al archivo marcado **#2** |
| `Espacio+3` | Saltar al archivo marcado **#3** |
| `Espacio+4` | Saltar al archivo marcado **#4** |

### Workflow recomendado con Harpoon

```bash
# 1. Abrir proyecto y marcar archivos importantes
nvim

Espacio+ff          # Buscar views.py
Espacio+a           # Marcar como #1

Espacio+ff          # Buscar models.py
Espacio+a           # Marcar como #2

Espacio+ff          # Buscar urls.py
Espacio+a           # Marcar como #3

# 2. Ahora puedes saltar entre ellos instantáneamente
Espacio+1           # views.py
Espacio+2           # models.py
Espacio+3           # urls.py

# 3. Ver/editar lista de marcados
Espacio+h
```

---

## 🔀 Git (Fugitive + GitSigns)

Integración completa de Git en Neovim.

### Atajos principales

| Atajo/Comando | Acción |
|---------------|--------|
| `Espacio+gs` | **Git status** ⭐ |
| `Espacio+gu` | **Deshacer cambios** del archivo actual ⭐ |
| `Espacio+gU` | Deshacer **TODOS** los cambios |
| `Espacio+gd` | **Diff con rama development** (QA Review) |
| `Espacio+gD` | Diff con **origin/development** |
| `Espacio+gw` | Diff **working tree** (cambios no commiteados) |
| `Espacio+gq` | **Cerrar** Diffview |
| `Espacio+gh` | **Historial** del archivo actual |
| `Espacio+gf` | **Commits** desde development hasta HEAD |

### GitSigns - Navegación entre cambios

| Atajo | Acción |
|-------|--------|
| `]c` | Ir al **siguiente** cambio ⭐ |
| `[c` | Ir al cambio **anterior** ⭐ |
| `Espacio+hp` | **Preview** del cambio (ver diff) ⭐ |
| `Espacio+hs` | **Stage** el cambio (agregar a git) |
| `Espacio+hr` | **Reset** el cambio (deshacerlo) |
| `Espacio+hb` | **Blame** (ver quién escribió esa línea) |
| `Espacio+hd` | **Diff** del archivo completo |
| `Espacio+tb` | **Toggle** blame en todas las líneas |

### Dentro de Git status (Fugitive)

| Atajo | Acción |
|-------|--------|
| `s` | **Stage/unstage** archivo bajo cursor |
| `u` | **Unstage** archivo |
| `=` | Ver **diff** del archivo |
| `cc` | Crear **commit** |
| `ca` | **Amend** último commit |
| `X` | **Descartar** cambios del archivo |
| `-` | Toggle stage/unstage |
| `dd` | Ver diff en split |
| `dv` | Ver diff en split vertical |

### Comandos Git

| Comando | Acción |
|---------|--------|
| `:Git add %` | Agregar archivo actual |
| `:Git add .` | Agregar todos los archivos |
| `:Git commit` | Hacer commit |
| `:Git commit -m "mensaje"` | Commit con mensaje |
| `:Git push` | Push a remoto |
| `:Git pull` | Pull desde remoto |
| `:Git log` | Ver historial de commits |
| `:Git diff` | Ver diferencias |
| `:Git blame` | Ver quién escribió cada línea |
| `:Git restore archivo` | Deshacer cambios de archivo |
| `:Git restore .` | Deshacer todos los cambios |

---

## 💻 Terminal (ToggleTerm)

Terminal integrada estilo VSCode.

### Atajos de Terminal

| Atajo | Acción |
|-------|--------|
| `Ctrl+´` | **Toggle** terminal horizontal ⭐ |
| `Espacio+tt` | Toggle terminal horizontal |
| `Espacio+ld` | Abrir **LazyDocker** (flotante) 🐳 |

### Dentro de la terminal

| Atajo | Acción |
|-------|--------|
| `Esc` | Salir del modo terminal (ir a modo NORMAL) ⭐ |
| `i` o `a` | Volver al modo terminal |
| `Ctrl+h` | Ir a ventana **izquierda** |
| `Ctrl+j` | Ir a ventana **abajo** |
| `Ctrl+k` | Ir a ventana **arriba** |
| `Ctrl+l` | Ir a ventana **derecha** |

### Comandos útiles en terminal

```bash
# Django
python manage.py runserver
python manage.py migrate
python manage.py makemigrations
python manage.py shell

# Docker
docker ps
docker logs -f nombre-contenedor
docker exec -it nombre-contenedor bash
docker-compose up -d

# Git
git status
git log --oneline
git diff

# Tests
pytest
pytest -v
pytest -k "nombre_test"
```

---

## 🧠 LSP y Autocompletado

**LSP** proporciona inteligencia de código: autocompletado, ir a definición, diagnósticos, etc.

### Atajos de LSP

| Atajo | Acción |
|-------|--------|
| `gd` | **Ir a definición** ⭐ |
| `gr` | **Ver referencias** (dónde se usa) ⭐ |
| `gi` | Ir a **implementación** |
| `K` | **Hover** (mostrar documentación) ⭐ |
| `Espacio+rn` | **Renombrar** símbolo ⭐ |
| `Espacio+ca` | **Code actions** (auto-import, quick fixes) ⭐ |
| `Espacio+f` | **Formatear** código |
| `[d` | Ir al **diagnóstico anterior** (error/warning) |
| `]d` | Ir al **siguiente diagnóstico** |

### Autocompletado (nvim-cmp + Supermaven)

| Atajo | Acción |
|-------|--------|
| `Ctrl+Space` | Activar autocompletado **manual** |
| `Tab` | **Aceptar sugerencia de Supermaven** o siguiente opción de cmp ⭐ |
| `Ctrl+j` | Aceptar siguiente **palabra** de Supermaven |
| `Ctrl+]` | **Descartar** sugerencia de Supermaven |
| `Shift+Tab` | Sugerencia **anterior** de cmp ⭐ |
| `Enter` | **Aceptar** sugerencia de cmp ⭐ |
| `Ctrl+e` | **Cerrar** autocompletado |
| `Ctrl+f` | Scroll **down** en documentación |
| `Ctrl+b` | Scroll **up** en documentación |

### Uso de Code Actions (Auto-import)

```python
# Ejemplo: Auto-importar en Python
# 1. Escribes código sin importar
User.objects.all()  # User no está importado

# 2. Posicionas cursor sobre "User"
# 3. Presionas Espacio+ca
# 4. Seleccionas: "Import User from django.contrib.auth.models"
# 5. ¡Listo! Se importa automáticamente
```

### Instalar más LSPs

```vim
:Mason
# Buscar con / y presionar 'i' para instalar
```

### LSPs instalados

| LSP | Lenguaje |
|-----|----------|
| `pyright` | Python (type checker) |
| `ruff` | Python (linter + formatter) |
| `clangd` | C / C++ |
| `html` | HTML |
| `cssls` | CSS / SCSS |
| `ts_ls` | JavaScript / TypeScript |
| `emmet_ls` | Emmet (HTML/CSS) |

### Verificar LSP activo

```vim
:LspInfo        # Ver LSPs adjuntos al buffer actual
:LspLog         # Ver logs de LSP
:checkhealth lsp   # Verificar salud de LSP
```

---

## ⚙️ C++ - Compilar y Ejecutar

### Atajos de C++

| Atajo | Acción |
|-------|--------|
| `Espacio+rr` | **Compilar y ejecutar** archivo actual (un solo .cpp) ⭐ |
| `Espacio+rc` | **Solo compilar** archivo actual (sin ejecutar) |
| `Espacio+rm` | **Compilar y ejecutar** todos los .cpp con Makefile ⭐ |
| `Espacio+rC` | **Solo compilar** proyecto completo con Makefile |

### Makefile automático

Al crear un archivo `.cpp` dentro de las carpetas:
- `week_*/` → para ejercicios semanales
- `tasks_unab_cplus/*/` → para tareas de la universidad

Se crea automáticamente un `Makefile` con esta estructura:

```makefile
CXX = g++
CXXFLAGS = -Wall -std=c++17
TARGET = /tmp/programa
SRCS = $(wildcard *.cpp)

all:
    $(CXX) $(CXXFLAGS) $(SRCS) -o $(TARGET) && $(TARGET)

compile:
    $(CXX) $(CXXFLAGS) $(SRCS) -o $(TARGET)

clean:
    rm -f $(TARGET)
```

### Estructura recomendada para C++

```
cpp-universidad/
├── week_one/
│   ├── Makefile          # Creado automáticamente
│   ├── main.cpp
│   ├── figura.h
│   └── figura.cpp
├── week_two/
│   ├── Makefile          # Creado automáticamente
│   └── main.cpp
tasks_unab_cplus/
├── first_task/
│   ├── Makefile          # Creado automáticamente
│   ├── main.cpp
│   └── clase.h
```

### Workflow C++ con múltiples archivos

```bash
# 1. Crear carpeta en NvimTree
# 2. Crear main.cpp → Makefile se genera solo
# 3. Crear archivos .h y .cpp adicionales
# 4. Compilar y ejecutar todo junto
Espacio+rm          # Compila todos los .cpp y ejecuta

# Si solo quieres ver errores sin ejecutar
Espacio+rC          # Solo compila el proyecto completo
```

---

## 🐛 Debugger (nvim-dap)

Debugger integrado para C++ con breakpoints y ejecución paso a paso.

> **Importante:** Antes de debuggear, compilar con `Espacio+rm` para generar `/tmp/programa`.

### Atajos del Debugger

| Atajo | Acción |
|-------|--------|
| `Espacio+db` | **Toggle breakpoint** (poner/quitar) ⭐ |
| `Espacio+dc` | **Continuar** hasta siguiente breakpoint ⭐ |
| `Espacio+do` | **Step over** (siguiente línea sin entrar a función) |
| `Espacio+di` | **Step into** (entrar a función) |
| `Espacio+dx` | **Terminar** sesión de debug |
| `Espacio+du` | **Toggle UI** del debugger |

### Workflow de debugging

```bash
# 1. Compilar primero
Espacio+rm

# 2. Poner breakpoints en líneas importantes
Espacio+db          # En la línea donde quieres pausar

# 3. Iniciar debug
Espacio+dc          # Abre la UI y ejecuta hasta el breakpoint

# 4. Inspeccionar variables en el panel izquierdo (Scopes)

# 5. Navegar
Espacio+do          # Siguiente línea
Espacio+di          # Entrar a función
Espacio+dc          # Continuar hasta siguiente breakpoint

# 6. Terminar
Espacio+dx
```

---

## ⚡ Navegación Rápida (Flash)

**Flash** te permite saltar a cualquier parte del código en 2-3 teclas.

### Atajos de Flash

| Atajo | Acción |
|-------|--------|
| `s` | **Saltar** a cualquier parte del archivo ⭐ |
| `S` | Saltar usando **Treesitter** (selección de nodos) |

### Cómo usar Flash

```bash
# 1. Presiona 's' en modo NORMAL
s

# 2. Escribe 2 letras de donde quieres ir
# Ejemplo: quieres ir a una línea con "cout"
co

# 3. Aparecen etiquetas en todas las coincidencias
# Presiona la letra de la etiqueta y saltas directo ahí
```

---

## 🔤 Surround

**nvim-surround** permite manipular paréntesis, comillas, llaves y tags fácilmente.

### Atajos de Surround

| Atajo | Acción |
|-------|--------|
| `cs"'` | **Cambiar** `"hola"` → `'hola'` |
| `cs({` | **Cambiar** `(hola)` → `{ hola }` |
| `ds"` | **Eliminar** comillas → `"hola"` → `hola` |
| `ysiw"` | **Rodear** palabra con comillas → `"hola"` |
| `ysiw)` | **Rodear** palabra con paréntesis → `(hola)` |
| `yss)` | **Rodear** línea completa con paréntesis |
| `yssb` | **Rodear** línea con `{}` |

---

## 📝 TODO Comments

Resalta y organiza notas en tu código.

### Palabras clave soportadas

| Keyword | Ícono | Color | Uso |
|---------|-------|-------|-----|
| `TODO` | ✓ | Azul | Cosas pendientes de implementar |
| `FIXME` | ✗ | Rojo | Bugs conocidos |
| `NOTE` | ★ | Verde | Notas informativas |
| `HACK` | ⚠ | Amarillo | Soluciones temporales |
| `WARN` | ⚠ | Amarillo | Advertencias |
| `BUG` | ✗ | Rojo | Alias de FIXME |

### Uso en código

```cpp
// TODO: implementar el método calcularArea()
// FIXME: este loop tiene off-by-one error
// NOTE: esta clase hereda de Figura
// HACK: solución temporal hasta el próximo sprint
int main() { ... }
```

### Buscar TODOs

```vim
Espacio+ft          # Abrir Telescope con todos los TODOs del proyecto
```

---

## 🖥️ Tmux Integration

**Vim-tmux-navigator** permite navegar fluidamente entre Vim y Tmux.

### Navegación unificada Vim + Tmux

| Atajo | Acción |
|-------|--------|
| `Ctrl+h` | Ir al panel **izquierdo** (Vim o Tmux) ⭐ |
| `Ctrl+j` | Ir al panel **abajo** (Vim o Tmux) ⭐ |
| `Ctrl+k` | Ir al panel **arriba** (Vim o Tmux) ⭐ |
| `Ctrl+l` | Ir al panel **derecha** (Vim o Tmux) ⭐ |

### Comandos de Tmux

**Prefijo:** `Ctrl+a`

| Atajo | Acción |
|-------|--------|
| `Ctrl+a \|` | Dividir **verticalmente** |
| `Ctrl+a -` | Dividir **horizontalmente** |
| `Ctrl+a c` | Nueva **ventana** |
| `Ctrl+a n` | **Siguiente** ventana |
| `Ctrl+a p` | Ventana **anterior** |
| `Ctrl+a {número}` | Ir a ventana número X |
| `Ctrl+a d` | **Desconectar** de sesión (detach) |
| `Ctrl+a s` | Lista de **sesiones** |
| `Ctrl+a w` | Lista de **ventanas** |
| `Ctrl+a x` | **Cerrar** panel actual |
| `Ctrl+a &` | Cerrar ventana actual |
| `Ctrl+a r` | **Recargar** configuración |
| `Ctrl+a z` | **Zoom** panel actual (toggle fullscreen) |
| `Alt+↑↓←→` | Cambiar tamaño de panel |

### Workflow diario con Tmux

```bash
# LUNES - Crear sesión para proyecto frontend
tmux new -s frontend
cd ~/Documents/proyecto-web
nvim

# Dividir para ver terminal
Ctrl+a -
# Arriba: Neovim
# Abajo: Terminal para runserver

# MARTES - Necesitas trabajar en backend
Ctrl+a d              # Desconectar (todo sigue corriendo)
tmux new -s backend   # Nueva sesión
cd ~/Documents/api
nvim

# Cambiar entre proyectos
Ctrl+a s              # Lista de sesiones
# Selecciona con flechas y Enter

# VIERNES - Ver todas tus sesiones
tmux ls

# LUNES SIGUIENTE - Volver exactamente donde lo dejaste
tmux attach -t frontend
# ¡Todo sigue abierto! Nvim, archivos, terminal
```

---

## 📌 Comandos Avanzados

### Información del sistema

| Comando | Acción |
|---------|--------|
| `:checkhealth` | Verificar **salud** de Neovim |
| `:version` | Ver **versión** de Neovim |
| `:Lazy` | Abrir gestor de **plugins** |
| `:Mason` | Abrir gestor de **LSP** |
| `:messages` | Ver **mensajes** del sistema |
| `:e $MYVIMRC` | Editar **configuración** |

### Configuración

| Comando | Acción |
|---------|--------|
| `:source %` | **Recargar** archivo actual |
| `:Lazy sync` | **Sincronizar** plugins |
| `:Lazy clean` | **Limpiar** plugins no usados |
| `:Lazy update` | **Actualizar** todos los plugins |
| `:TSUpdate` | Actualizar **parsers** de Treesitter |
| `:LspRestart` | **Reiniciar** LSP |
| `:SupermavenUseFree` | Activar **Supermaven** gratis |

### Edición masiva con Visual Block

```vim
# Insertar en múltiples líneas:
1. Ctrl+v              # Modo visual block
2. Selecciona líneas (j/k)
3. I                   # Insertar al inicio
4. Escribe el texto
5. Esc                 # Se aplicará a todas las líneas

# Agregar al final de múltiples líneas:
1. Ctrl+v
2. Selecciona líneas
3. $                   # Ir al final
4. A                   # Append
5. Escribe el texto
6. Esc

# Comentar múltiples líneas:
1. Ctrl+v
2. Selecciona líneas
3. I                   # Insert
4. #                   # Carácter de comentario
5. Esc
```

### Cambiar tamaño de ventanas

| Comando | Acción |
|---------|--------|
| `:resize +5` | Aumentar **altura** +5 |
| `:resize -5` | Reducir altura -5 |
| `:vertical resize +10` | Aumentar **ancho** +10 |
| `:vertical resize -10` | Reducir ancho -10 |
| `Ctrl+w =` | **Igualar** todas las ventanas |
| `Ctrl+w _` | Maximizar altura de ventana actual |
| `Ctrl+w \|` | Maximizar ancho de ventana actual |

### Números de línea

| Comando | Acción |
|---------|--------|
| `:set number` | Mostrar números |
| `:set relativenumber` | Números **relativos** |
| `:set nonumber` | Ocultar números |
| `:set norelativenumber` | Desactivar relativos |

---

## 🚀 Trucos y Tips

### Macros (grabación de acciones)

```vim
# Grabar macro:
qa                      # Empezar a grabar en registro 'a'
{realizar acciones}     # Lo que quieras automatizar
q                       # Terminar grabación

# Ejecutar macro:
@a                      # Ejecutar macro 'a' una vez
10@a                    # Ejecutar macro 10 veces
@@                      # Repetir último macro ejecutado

# Ejemplo práctico:
qa                      # Grabar
I# <Esc>j              # Agregar # al inicio y bajar
q                       # Terminar
10@a                    # Comentar 10 líneas
```

### Marks (marcas personales)

```vim
# Crear marca:
ma                      # Crear marca 'a' en posición actual

# Saltar a marca:
`a                      # Saltar a marca 'a' (posición exacta)
'a                      # Saltar a línea de marca 'a'

# Marcas especiales automáticas:
``                      # Última posición del cursor
`.                      # Última edición
`[                      # Inicio de última modificación
`]                      # Final de última modificación
```

### Búsqueda avanzada

```vim
/palabra                # Buscar "palabra"
/\<palabra\>            # Buscar palabra COMPLETA (no "palabras")
/palabra\c              # Buscar ignorando mayúsculas
/palabra\C              # Buscar respetando mayúsculas
*                       # Buscar palabra bajo cursor
#                       # Buscar palabra bajo cursor (atrás)
g*                      # Buscar palabra bajo cursor (parcial)
```

### Reemplazar con confirmación

```vim
:%s/viejo/nuevo/gc      # Reemplazar en todo el archivo
# Opciones durante confirmación:
y - yes (reemplazar)
n - no (saltar)
a - all (reemplazar todos sin preguntar)
q - quit (terminar)
l - last (reemplazar este y terminar)
```

### Deshacer/rehacer avanzado

```vim
u                       # Deshacer
Ctrl+r                  # Rehacer
U                       # Deshacer todos los cambios de la línea
:earlier 5m             # Volver 5 minutos atrás
:later 5m               # Ir 5 minutos adelante
:undo 10                # Volver al estado de undo #10
```

### Copiar/pegar con registros

```vim
# Registros nombrados:
"ayy                    # Copiar línea al registro 'a'
"ap                     # Pegar desde registro 'a'

# Registros especiales:
"0p                     # Último texto copiado (yank)
"1p                     # Último texto borrado
"+y                     # Copiar al portapapeles del sistema
"+p                     # Pegar desde portapapeles del sistema
:reg                    # Ver todos los registros
```

### Edición de múltiples archivos

```vim
:args *.py              # Abrir todos los .py como argumentos
:argdo %s/viejo/nuevo/g # Ejecutar comando en todos los archivos
:wall                   # Guardar todos los archivos
```

### Colorizer (colores CSS)

```vim
Espacio+tc              # Toggle colorizer (activar/desactivar)
:ColorizerToggle        # Mismo efecto
```

### Utilidades varias

```vim
Espacio+ve              # Editar archivo .env rápidamente
:!comando               # Ejecutar comando de shell
:read !comando          # Insertar salida de comando en buffer
:.!comando              # Filtrar línea actual por comando
:%!jq                   # Formatear JSON en todo el archivo
:sort                   # Ordenar líneas alfabéticamente
:sort n                 # Ordenar líneas numéricamente
```

---

## 🎯 Workflow Diario Completo

### Inicio del día

```bash
# 1. Iniciar sesión de Tmux
tmux new -s trabajo

# 2. Abrir Neovim en proyecto
cd ~/Documents/mi-proyecto
nvim

# 3. Abrir archivos frecuentes con Harpoon
Espacio+ff              # Buscar views.py
Espacio+a               # Marcar
Espacio+ff              # Buscar models.py
Espacio+a               # Marcar

# 4. Dividir terminal para servidor
Ctrl+a -                # Panel abajo
python manage.py runserver

# 5. Volver a Neovim
Ctrl+k
```

### Durante el día

```bash
# Buscar archivo rápido
Espacio+ff              # Buscar por nombre

# Buscar texto en proyecto
Espacio+fg              # Buscar contenido

# Saltar entre archivos marcados
Espacio+1               # views.py
Espacio+2               # models.py

# Navegar rápido dentro del archivo
s                       # Flash: saltar a cualquier parte

# Ver cambios de Git
]c                      # Siguiente cambio
Espacio+hp              # Ver diff

# Auto-importar
Espacio+ca              # Code actions

# Terminal rápida
Ctrl+´                  # Toggle terminal
```

### Final del día

```bash
# Commit de cambios
Espacio+gs              # Git status
s                       # Stage archivos
cc                      # Commit

# Desconectar (todo sigue corriendo)
Ctrl+a d

# Cerrar terminal
exit
```

### Próximo día

```bash
# Reconectar a sesión
tmux attach -t trabajo

# ¡Todo está exactamente como lo dejaste!
```

---

## 📚 Recursos de Ayuda

### Dentro de Neovim

```vim
:help                   # Ayuda general
:help telescope         # Ayuda de plugin específico
:help lsp               # Ayuda de LSP
:help :comando          # Ayuda de comando Ex
:helpgrep término       # Buscar en ayuda
```

### Tutoriales

```bash
vimtutor                # Tutorial interactivo (30 min)
```

### Verificar configuración

```vim
:checkhealth            # Verificar salud completa
:checkhealth lsp        # Verificar solo LSP
:checkhealth telescope  # Verificar solo Telescope
```

---

## 💡 Tips Finales

### Día 1-7: Fundamentos
- Domina movimientos: `h` `j` `k` `l` `w` `b` `0` `$`
- Practica entrar/salir de INSERT: `i` `a` `Esc`
- Aprende copiar/pegar: `yy` `dd` `p`
- Usa `Espacio+ff` para buscar archivos

### Semana 2: Productividad
- Domina Git: `]c` `[c` `Espacio+hp`
- Usa Harpoon: marca archivos con `Espacio+a`
- Aprende splits: `Espacio+v` `Espacio+s`
- Practica terminal: `Ctrl+´`
- Navega rápido con Flash: `s`

### Mes 1: Maestría
- LSP completo: `gd` `gr` `Espacio+ca`
- Debugger C++: `Espacio+db` `Espacio+dc`
- Tmux para múltiples proyectos
- Macros para tareas repetitivas
- Personaliza atajos según tu workflow

---

**¡Happy coding! 🚀**

*Guía viva - Se actualiza con cada mejora de configuración*
*Última actualización: Marzo 2026*
