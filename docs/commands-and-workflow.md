# ⌨️ Referencia de Comandos

> Todos los atajos y comandos, **agrupados por la herramienta que los provee**.
> Cada sección indica qué plugin es, cuándo se activa y qué hace cada comando.

Para el flujo de trabajo diario, mira **[daily-routine.md](daily-routine.md)**.

---

## 📖 Cómo leer esta guía

| Notación | Significa |
|----------|-----------|
| `Espacio` | La tecla **leader** (barra espaciadora) |
| `Espacio+ff` | Pulsar `Espacio`, soltar, luego `f`, `f` |
| `Ctrl+s` | Mantener `Ctrl` y pulsar `s` |
| `:comando` | Comando Ex: escribir en modo normal y pulsar `Enter` |
| `gd` | Dos teclas seguidas en modo normal |

> 💡 **Si olvidas un atajo:** pulsa `Espacio` y espera — which-key muestra las
> opciones. O usa `Ctrl+p` (Legendary) para buscar cualquier comando por nombre.

---

## 📋 Índice

**Base**
- [Vim nativo — modos](#vim-nativo--modos)
- [Vim nativo — navegación](#vim-nativo--navegación)
- [Vim nativo — edición](#vim-nativo--edición)
- [Vim nativo — buffers, ventanas y pestañas](#vim-nativo--buffers-ventanas-y-pestañas)
- [Vim nativo — registros, macros y marcas](#vim-nativo--registros-macros-y-marcas)
- [Atajos propios de esta config](#atajos-propios-de-esta-config)

**Búsqueda y navegación de proyecto**
- [Telescope](#telescope--fuzzy-finder) · [NvimTree](#nvimtree--explorador-de-archivos) · [Harpoon](#harpoon--marcadores) · [Flash](#flash--salto-rápido) · [Dropbar](#dropbar--breadcrumbs) · [Spectre](#spectre--buscar-y-reemplazar-global)

**Código**
- [LSP](#lsp--inteligencia-de-código) · [nvim-cmp](#nvim-cmp--autocompletado) · [Copilot](#copilot--sugerencias-de-ia) · [Snippets](#snippets) · [conform](#conform--formateo) · [Trouble](#trouble--panel-de-diagnósticos) · [Treesitter](#treesitter) · [Comment](#commentnvim--comentar) · [Surround](#nvim-surround--envolver) · [autopairs](#nvim-autopairs--cierre-automático) · [TODO comments](#todo-comments)

**Git**
- [Fugitive](#fugitive--status-y-commits) · [GitSigns](#gitsigns--hunks-y-blame) · [Diffview](#diffview--diffs-e-historial) · [git-conflict](#git-conflict--conflictos) · [Octo](#octo--github)

**Entorno**
- [ToggleTerm](#toggleterm--terminal) · [Docker](#docker--lazydocker) · [HTML — Live Server](#html--live-server) · [tmux](#tmux) · [auto-session](#auto-session--sesiones) · [Legendary](#legendary--paleta-de-comandos) · [Dashboard](#dashboard) · [which-key](#which-key)

**Ejecución**
- [nvim-dap](#nvim-dap--debugger) · [Neotest](#neotest--tests) · [Markdown Preview](#markdown-preview) · [Colorizer](#colorizer) · [Extras](#extras)

**Referencia**
- [Comandos de gestión](#comandos-de-gestión) · [Cheatsheet alfabético](#cheatsheet-alfabético)

---

# Base

## Vim nativo — modos

**Herramienta:** Vim/Neovim · Siempre activo

| Modo | Cómo entrar | Cómo salir |
|------|-------------|------------|
| **Normal** | `Esc` · `jk` · `kj` | — (modo por defecto) |
| **Insert** | `i` `a` `o` `I` `A` `O` | `Esc` · `jk` · `kj` |
| **Visual** | `v` | `Esc` |
| **Visual línea** | `V` | `Esc` |
| **Visual bloque** | `Ctrl+v` | `Esc` |
| **Command** | `:` | `Esc` · `Ctrl+c` |
| **Terminal** | `i` dentro de una terminal | `Esc` |

### Entrar a modo INSERT

| Atajo | Acción |
|-------|--------|
| `i` / `a` | Insertar **antes** / **después** del cursor |
| `I` / `A` | Insertar al **inicio** / **final** de la línea |
| `o` / `O` | Nueva línea **abajo** / **arriba** e insertar |
| `S` | Borrar la línea e insertar |
| `C` | Borrar hasta el final de línea e insertar |
| `ciw` | Cambiar la palabra completa bajo el cursor |

> ⚠️ **`s` está remapeado a Flash** en esta config. Para el comportamiento
> original de `s` (borrar carácter e insertar), usa `cl`.

---

## Vim nativo — navegación

**Herramienta:** Vim/Neovim · Siempre activo

### Dentro del archivo

| Atajo | Acción |
|-------|--------|
| `h` `j` `k` `l` | Izquierda, abajo, arriba, derecha |
| `w` / `b` | Inicio de la palabra siguiente / anterior |
| `e` | Final de la palabra |
| `W` `B` `E` | Igual, ignorando puntuación |
| `0` / `^` / `$` | Inicio de línea / primer no-blanco / final |
| `gg` / `G` | Inicio / final del archivo |
| `{número}G` | Ir a la línea N (ej. `50G`) |
| `Ctrl+d` / `Ctrl+u` | Media página abajo / arriba |
| `Ctrl+f` / `Ctrl+b` | Página completa abajo / arriba |
| `%` | Saltar al paréntesis/llave/corchete pareja |
| `{` / `}` | Párrafo anterior / siguiente |
| `f{c}` / `F{c}` | Saltar al siguiente / anterior carácter `{c}` en la línea |
| `t{c}` / `T{c}` | Igual, pero se detiene justo antes |
| `;` / `,` | Repetir el último `f`/`t` hacia adelante / atrás |
| `` `` `` | Volver a la posición anterior del cursor |

### Búsqueda

| Atajo | Acción |
|-------|--------|
| `/texto` / `?texto` | Buscar hacia adelante / atrás |
| `n` / `N` | Coincidencia siguiente / anterior |
| `*` / `#` | Buscar la palabra bajo el cursor adelante / atrás |
| `/\<palabra\>` | Buscar la palabra **exacta** |
| `/texto\c` | Buscar ignorando mayúsculas |

> La config usa `ignorecase` + `smartcase`: buscar en minúsculas ignora el caso,
> pero si escribes una mayúscula la búsqueda se vuelve sensible.

---

## Vim nativo — edición

**Herramienta:** Vim/Neovim · Siempre activo

### Copiar, cortar, pegar

| Atajo | Acción |
|-------|--------|
| `yy` | Copiar la línea |
| `y{mov}` | Copiar según movimiento (`yw`, `y$`, `yi(`) |
| `dd` | Cortar la línea |
| `d{mov}` | Cortar según movimiento |
| `D` / `C` | Cortar / cambiar hasta el final de línea |
| `x` / `X` | Borrar el carácter bajo / antes del cursor |
| `p` / `P` | Pegar después / antes del cursor |
| `3yy` / `3dd` | Copiar / cortar 3 líneas |
| `u` / `Ctrl+r` | Deshacer / rehacer |
| `.` | **Repetir la última acción** |

> El portapapeles está integrado con el sistema (`clipboard=unnamedplus`): lo que
> copias en Neovim se pega en el navegador y viceversa.

### Indentar y transformar

| Atajo | Acción |
|-------|--------|
| `>>` / `<<` | Indentar la línea derecha / izquierda |
| `>` / `<` | Indentar la selección (en modo visual) |
| `==` | Auto-indentar la línea |
| `gg=G` | Auto-indentar todo el archivo |
| `J` / `gJ` | Unir con la línea siguiente (con / sin espacio) |
| `~` | Alternar mayúscula/minúscula del carácter |
| `gu{mov}` / `gU{mov}` | A minúsculas / MAYÚSCULAS |

### Reemplazar

| Comando | Acción |
|---------|--------|
| `:%s/viejo/nuevo/g` | Reemplazar en todo el archivo |
| `:%s/viejo/nuevo/gc` | Igual, con confirmación (`y`/`n`/`a`/`q`/`l`) |
| `:s/viejo/nuevo/g` | Solo en la línea actual |
| `:'<,'>s/viejo/nuevo/g` | Solo en la selección visual |
| `:%s/viejo/nuevo/gi` | Ignorando mayúsculas |

Para reemplazar en **todo el proyecto**, usa [Spectre](#spectre--buscar-y-reemplazar-global).

### Edición en bloque (múltiples líneas)

```
Ctrl+v          → modo visual bloque
j / k           → seleccionar líneas
I               → insertar al inicio
{texto}         → escribir
Esc             → se aplica a TODAS las líneas seleccionadas
```

Para agregar al final: `Ctrl+v` → seleccionar → `$` → `A` → texto → `Esc`.

---

## Vim nativo — buffers, ventanas y pestañas

**Herramienta:** Vim/Neovim · Siempre activo

### Guardar y salir

| Atajo / Comando | Acción |
|-----------------|--------|
| `Ctrl+s` | **Guardar** (atajo de esta config) |
| `:w` | Guardar |
| `:wq` · `ZZ` | Guardar y salir |
| `Ctrl+q` | **Salir sin guardar** (atajo de esta config) |
| `:q!` · `ZQ` | Salir sin guardar |
| `:qa` / `:qa!` | Cerrar todo / sin guardar |
| `:wqa` | Guardar todo y cerrar |

### Buffers

| Comando | Acción |
|---------|--------|
| `:e archivo` | Abrir archivo |
| `:bn` / `:bp` | Buffer siguiente / anterior |
| `:bd` | Cerrar el buffer actual |
| `:ls` | Listar buffers |
| `:b nombre` | Ir al buffer por nombre (Tab autocompleta) |

Más rápido: `Espacio+fb` ([Telescope](#telescope--fuzzy-finder)).

### Ventanas (splits)

| Atajo | Acción |
|-------|--------|
| `Ctrl+h` `Ctrl+j` `Ctrl+k` `Ctrl+l` | Moverse entre splits (y paneles de tmux) |
| `Ctrl+w w` | Ciclar |
| `Ctrl+w =` | Igualar tamaños |
| `Ctrl+w _` / `Ctrl+w \|` | Maximizar altura / ancho |
| `:resize +5` | Cambiar altura |
| `:vertical resize +10` | Cambiar ancho |

Ver también los atajos `Espacio+w*` en [Atajos propios](#atajos-propios-de-esta-config).

### Pestañas

| Comando | Acción |
|---------|--------|
| `:tabnew` | Nueva pestaña |
| `gt` / `gT` | Pestaña siguiente / anterior |
| `:tabclose` | Cerrar pestaña |

---

## Vim nativo — registros, macros y marcas

**Herramienta:** Vim/Neovim · Siempre activo

### Macros

```
qa              → empezar a grabar en el registro 'a'
{acciones}      → hacer lo que quieres automatizar
q               → terminar la grabación
@a              → ejecutar una vez
10@a            → ejecutar 10 veces
@@              → repetir el último macro
```

### Registros

| Atajo | Acción |
|-------|--------|
| `"ayy` / `"ap` | Copiar / pegar usando el registro `a` |
| `"0p` | Pegar el último **yank** (no lo borrado) |
| `"+y` / `"+p` | Portapapeles del sistema explícito |
| `:reg` | Ver todos los registros |

### Marcas

| Atajo | Acción |
|-------|--------|
| `ma` | Crear la marca `a` |
| `` `a `` | Saltar a la marca `a` (posición exacta) |
| `` `. `` | Última edición |
| `` `` `` | Posición anterior del cursor |

### Undo avanzado

| Comando | Acción |
|---------|--------|
| `:earlier 5m` | Volver 5 minutos atrás |
| `:later 5m` | Avanzar 5 minutos |
| `U` | Deshacer todos los cambios de la línea |

> El historial de undo es **persistente** (`undofile`): sobrevive al cierre de
> Neovim. Se guarda en `~/.local/state/nvim/undo`.

---

## Atajos propios de esta config

**Herramienta:** [`lua/config/keymaps.lua`](../lua/config/keymaps.lua) · Siempre activo

| Atajo | Acción |
|-------|--------|
| `Ctrl+s` | Guardar |
| `Ctrl+q` | Salir sin guardar |
| `jk` / `kj` | Salir de modo insert (alternativa a `Esc`) |
| `Espacio+wv` | Split nuevo a la **derecha** |
| `Espacio+ws` | Split nuevo **abajo** |
| `Espacio+wo` | Cerrar todos los splits excepto este |
| `Espacio+q` | Cerrar el split actual |
| `Espacio++` / `Espacio+-` | Ampliar / reducir el ancho de NvimTree |
| `Espacio+ve` | Abrir el `.env` del proyecto |
| `Espacio+tc` | Toggle del colorizer |

### Comportamiento automático

**Herramienta:** [`lua/config/autocmds.lua`](../lua/config/autocmds.lua)

| Cuándo | Qué pasa |
|--------|----------|
| Al salir de modo insert | Se **guarda el archivo** automáticamente |
| Al copiar (`y`) | El texto copiado se resalta 200ms |
| Al guardar | Se eliminan los espacios en blanco al final (excepto en markdown, diff y gitcommit) |
| Al enfocar Neovim | Se recarga el archivo si cambió externamente |
| Al abrir `docker-compose*.yml` | Se asigna el filetype para su LSP |

---

# Búsqueda y navegación de proyecto

## Telescope — fuzzy finder

**Plugin:** `telescope.nvim` + `fzf-native` · **Activa:** al pulsar un atajo `Espacio+f*` o `:Telescope`

Buscador difuso de archivos, contenido, buffers y más.

| Atajo | Acción |
|-------|--------|
| `Espacio+ff` | Buscar **archivos** en el proyecto actual |
| `Espacio+fg` | Buscar **contenido** (grep) en el proyecto |
| `Espacio+fb` | Buscar entre **buffers** abiertos |
| `Espacio+fp` | Buscar archivos en **todos** los proyectos (`~/Documents`) |
| `Espacio+fP` | Buscar contenido en **todos** los proyectos |
| `Espacio+ft` | Buscar **TODOs** del proyecto |

### Dentro de Telescope

| Atajo | Acción |
|-------|--------|
| `Ctrl+j` / `Ctrl+k` | Bajar / subir en la lista |
| `Enter` | Abrir |
| `Ctrl+x` / `Ctrl+v` / `Ctrl+t` | Abrir en split horizontal / vertical / pestaña |
| `Ctrl+u` / `Ctrl+d` | Scroll en el preview |
| `Ctrl+q` | Enviar todos los resultados a la quickfix list |
| `Esc` | Cerrar |

### Tips de búsqueda

- **Difusa:** para `models.py` basta escribir `mdpy`
- **Por ruta:** `app/models` filtra por carpeta
- **Excluidos por defecto:** `node_modules`, `.git/`, `dist/`, `build/`, `__pycache__`, `.pyc`
- Para incluirlos: `:Telescope find_files hidden=true no_ignore=true`

---

## NvimTree — explorador de archivos

**Plugin:** `nvim-tree.lua` · **Activa:** `Espacio+e` o `:NvimTreeToggle`

| Atajo | Acción |
|-------|--------|
| `Espacio+e` | Abrir / cerrar el explorador |
| `Espacio++` / `Espacio+-` | Ampliar / reducir el ancho |

### Dentro del árbol

| Tecla | Acción |
|-------|--------|
| `Enter` / `o` | Abrir archivo o expandir carpeta |
| `Tab` | Abrir sin mover el cursor del árbol |
| `a` | **Crear** archivo (termina en `/` para carpeta) |
| `d` | Borrar |
| `r` | Renombrar |
| `x` / `c` / `p` | Cortar / copiar / pegar |
| `y` / `Y` / `gy` | Copiar nombre / ruta relativa / ruta absoluta |
| `H` | Toggle de archivos ocultos |
| `I` | Toggle de archivos ignorados por git |
| `R` | Refrescar |
| `s` / `i` / `t` | Abrir en split vertical / horizontal / pestaña |
| `Ctrl+]` | Hacer de esta carpeta la raíz |
| `Backspace` / `-` | Subir al directorio padre |
| `q` | Cerrar |

### Crear archivos

```
a                        → pulsar 'a'
nombre.py                → archivo
carpeta/                 → carpeta (termina con /)
carpeta/sub/archivo.py   → crea toda la ruta
```

---

## Harpoon — marcadores

**Plugin:** `harpoon` (branch 2) · **Activa:** al pulsar `Espacio+a`, `Espacio+1..4` o `Espacio+hh`

Marca los 4-5 archivos que estás tocando en una tarea y salta entre ellos al instante.

| Atajo | Acción |
|-------|--------|
| `Espacio+a` | **Marcar** el archivo actual |
| `Espacio+1` .. `Espacio+4` | Saltar al archivo marcado 1-4 |
| `Espacio+hh` | Ver / editar la lista de marcados |

En la lista puedes reordenar (`dd` + `p`) o borrar líneas: el orden define los números.

---

## Flash — salto rápido

**Plugin:** `flash.nvim` · **Activa:** `VeryLazy` (tras el arranque)

| Atajo | Acción |
|-------|--------|
| `s` | Saltar a cualquier punto visible |
| `S` | Seleccionar un nodo de Treesitter (función, bloque, string) |

### Cómo funciona

```
s               → activar
co              → escribir 2 letras del destino
{etiqueta}      → aparecen letras sobre cada coincidencia; pulsa la que quieres
```

También funciona como movimiento: `ds` borra hasta donde saltas, `ys` copia.

> ⚠️ `s` reemplaza al `s` nativo de Vim (borrar carácter e insertar). El
> equivalente es `cl`.

---

## Dropbar — breadcrumbs

**Plugin:** `dropbar.nvim` · **Activa:** `BufReadPre`

Barra superior con la ruta del archivo y el símbolo actual (clase → método), navegable.

| Atajo | Acción |
|-------|--------|
| `Espacio+bp` | Navegar por el breadcrumb: elegir un componente y saltar |

Dentro del menú, `q` cierra.

---

## Spectre — buscar y reemplazar global

**Plugin:** `nvim-spectre` · **Activa:** al pulsar `Espacio+S`, `Espacio+sw` o `Espacio+sf`

Reemplazo en todo el proyecto **con preview antes de aplicar**.

| Atajo | Acción |
|-------|--------|
| `Espacio+S` | Abrir el panel |
| `Espacio+sw` | Buscar la palabra bajo el cursor en el proyecto |
| `Espacio+sw` (visual) | Buscar la selección |
| `Espacio+sf` | Buscar solo en el archivo actual |

### Dentro del panel

| Tecla | Acción |
|-------|--------|
| `dd` | Excluir / incluir esa coincidencia del reemplazo |
| `Enter` | Ir al archivo de esa línea |
| `R` | **Aplicar** todos los reemplazos |
| `q` | Cerrar |

> Revisa con `dd` las coincidencias que no quieres tocar **antes** de pulsar `R`.

---

# Código

## LSP — inteligencia de código

**Plugin:** `nvim-lspconfig` + `mason.nvim` · **Activa:** al abrir un archivo (`BufReadPre`)

Los atajos se registran por buffer cuando un servidor se adjunta.

| Atajo | Acción |
|-------|--------|
| `gd` | Ir a la **definición** |
| `gr` | Ver **referencias** (dónde se usa) |
| `gi` | Ir a la implementación |
| `K` | **Hover**: documentación del símbolo |
| `Espacio+rn` | **Renombrar** en todo el proyecto |
| `Espacio+ca` | **Code actions**: auto-import, quick fixes |
| `Espacio+cf` | Formatear (ver [conform](#conform--formateo)) |
| `]d` / `[d` | Diagnóstico siguiente / anterior |

**Servidores incluidos:** pyright, ruff, html, cssls, ts_ls, emmet_ls, jsonls,
yamlls, dockerls, docker-compose, nginx.

📖 Detalles en **[lsp-and-completion.md](lsp-and-completion.md)**.

---

## nvim-cmp — autocompletado

**Plugin:** `nvim-cmp` · **Activa:** `InsertEnter`

Unifica LSP, Copilot, snippets, buffer y rutas en un solo menú.

| Atajo | Acción |
|-------|--------|
| `Ctrl+Space` | Abrir el menú manualmente |
| `Tab` | Siguiente opción · o expandir/avanzar en un snippet |
| `Shift+Tab` | Opción anterior · o retroceder en un snippet |
| `Enter` | Aceptar la opción **seleccionada** |
| `Ctrl+e` | Cerrar |
| `Ctrl+f` / `Ctrl+b` | Scroll en la documentación |

> `Enter` usa `select = false`: si no seleccionaste con `Tab`, hace un salto de
> línea normal.

---

## Copilot — sugerencias de IA

**Plugin:** `copilot.lua` + `copilot-cmp` · **Activa:** `InsertEnter`

Las sugerencias aparecen **dentro del menú de nvim-cmp** con el icono ,
así que se manejan con los mismos atajos de arriba.

| Comando | Acción |
|---------|--------|
| `:Copilot auth` | Autenticar (primera vez) |
| `:Copilot status` | Ver el estado |
| `:Copilot disable` / `:Copilot enable` | Desactivar / reactivar |

📖 Detalles en **[ai-copilot.md](ai-copilot.md)**.

---

## Snippets

**Plugin:** `LuaSnip` + `friendly-snippets` · **Activa:** con nvim-cmp (`InsertEnter`)

Aparecen en el menú marcados como **Snippet**.

| Atajo | Acción |
|-------|--------|
| `Tab` | Expandir · o siguiente placeholder |
| `Shift+Tab` | Placeholder anterior |

**Django/DRF activados:** `block`, `for`, `url`, `static`, `csrf` en templates ·
`model`, `serializer`, `modelform`, `listview` en Python.

📖 Lista completa en **[django.md](django.md#snippets)**.

---

## conform — formateo

**Plugin:** `conform.nvim` · **Activa:** al pulsar `Espacio+cf`

| Atajo | Acción |
|-------|--------|
| `Espacio+cf` | Formatear el archivo (o la selección en visual) |

| Comando | Acción |
|---------|--------|
| `:ConformInfo` | Ver qué formatter se usaría en este buffer |

Usa los formatters de tu `PATH`/`.venv` (ruff, prettier, djlint) con fallback al LSP.

📖 Detalles en **[lsp-and-completion.md](lsp-and-completion.md#formateo-con-conformnvim)**.

---

## Trouble — panel de diagnósticos

**Plugin:** `trouble.nvim` · **Activa:** al pulsar `Espacio+x*` o `:Trouble`

| Atajo | Acción |
|-------|--------|
| `Espacio+xx` | Todos los errores y warnings del proyecto |
| `Espacio+xf` | Solo del archivo actual |
| `Espacio+xq` | Quickfix list |

### Dentro del panel

| Tecla | Acción |
|-------|--------|
| `Enter` | Ir al problema |
| `r` | Refrescar |
| `za` / `zA` | Plegar / desplegar grupo |
| `q` | Cerrar |

---

## Treesitter

**Plugin:** `nvim-treesitter` · **Activa:** inmediato

Parsing real del código: highlighting preciso, indentación correcta y base para
Flash (`S`), rainbow-delimiters, autopairs y comentarios contextuales.

| Comando | Acción |
|---------|--------|
| `:TSUpdate` | Actualizar todos los parsers |
| `:TSInstall {lenguaje}` | Instalar un parser |
| `:TSBufDisable highlight` | Desactivar highlighting en este buffer (archivos enormes) |
| `:InspectTree` | Ver el árbol sintáctico |

**Parsers incluidos:** python, javascript, typescript, tsx, html, htmldjango,
css, scss, json, yaml, toml, bash, dockerfile, nginx, markdown, gitcommit, diff,
lua, vim, vimdoc, query, regex.

---

## Comment.nvim — comentar

**Plugin:** `Comment.nvim` + `ts-context-commentstring` · **Activa:** `BufReadPre`

| Atajo | Acción |
|-------|--------|
| `gcc` | Comentar / descomentar la línea |
| `gc{mov}` | Comentar según movimiento (`gcap` = párrafo) |
| `gc` (visual) | Comentar la selección |
| `gbc` | Comentar en bloque |

**Contextual:** en un template de Django usa `{# #}` dentro de bloques Django,
`<!-- -->` en HTML, `//` dentro de `<script>` y `/* */` dentro de `<style>`.

---

## nvim-surround — envolver

**Plugin:** `nvim-surround` · **Activa:** `VeryLazy`

| Atajo | Acción |
|-------|--------|
| `ysiw"` | Rodear la palabra con `"` |
| `ysiw)` | Rodear la palabra con `()` |
| `yss)` | Rodear la línea completa |
| `cs"'` | **Cambiar** `"texto"` → `'texto'` |
| `cs(}` | Cambiar `(texto)` → `{texto}` |
| `ds"` | **Eliminar** las comillas |
| `ysiwt` | Rodear con un tag HTML (pide el nombre) |

---

## nvim-autopairs — cierre automático

**Plugin:** `nvim-autopairs` · **Activa:** `InsertEnter`

Funciona solo: cierra `()`, `[]`, `{}`, `""`, `''` y respeta el contexto de
Treesitter (no cierra dentro de strings o comentarios).

| Atajo | Acción |
|-------|--------|
| `Alt+e` | **Fast wrap**: envolver lo que sigue con el par |

Extras configurados: espacios simétricos dentro de brackets y f-strings de
Python (`f'`, `f"`).

---

## TODO comments

**Plugin:** `todo-comments.nvim` · **Activa:** `BufReadPre`

Resalta palabras clave en los comentarios y permite buscarlas.

| Palabra | Uso |
|---------|-----|
| `TODO` | Pendiente por implementar |
| `FIXME` / `BUG` / `FIXIT` | Bug conocido |
| `HACK` | Solución temporal |
| `WARN` / `WARNING` | Advertencia |
| `NOTE` / `INFO` | Nota informativa |

| Atajo / Comando | Acción |
|-----------------|--------|
| `Espacio+ft` | Buscar todos los TODOs del proyecto (Telescope) |
| `:TodoTrouble` | Verlos en el panel de Trouble |

```python
# TODO: implementar el endpoint de estadísticas
# FIXME: este queryset genera N+1 queries
# NOTE: esta vista requiere autenticación por token
```

---

# Git

## Fugitive — status y commits

**Plugin:** `vim-fugitive` · **Activa:** `:Git` o `Espacio+gs`

| Atajo | Acción |
|-------|--------|
| `Espacio+gs` | Panel de **git status** interactivo |
| `Espacio+gu` | Descartar cambios del archivo actual |
| `Espacio+gU` | Descartar **todos** los cambios ⚠️ |

**Dentro del panel:** `s` stage · `u` unstage · `=` diff · `cc` commit ·
`ca` amend · `X` descartar · `q` cerrar.

📖 Comandos completos en **[git-and-github.md](git-and-github.md#fugitive--status-y-comandos)**.

---

## GitSigns — hunks y blame

**Plugin:** `gitsigns.nvim` · **Activa:** `BufReadPre` (solo en repos git)

| Atajo | Acción |
|-------|--------|
| `]c` / `[c` | Cambio siguiente / anterior |
| `Espacio+hp` | **Preview** del hunk |
| `Espacio+hs` | **Stage** solo este hunk |
| `Espacio+hr` | **Reset** solo este hunk |
| `Espacio+hb` | **Blame** completo de la línea |
| `Espacio+hd` | Diff del archivo completo |
| `Espacio+tb` | Toggle del blame inline |

📖 Detalles en **[git-and-github.md](git-and-github.md#gitsigns--cambios-línea-por-línea)**.

---

## Diffview — diffs e historial

**Plugin:** `diffview.nvim` · **Activa:** al pulsar `Espacio+g*` o `:DiffviewOpen`

| Atajo | Acción |
|-------|--------|
| `Espacio+gd` | Diff contra `development` |
| `Espacio+gD` | Diff contra `origin/development` |
| `Espacio+gw` | Diff del working tree |
| `Espacio+gh` | Historial del archivo actual |
| `Espacio+gf` | Commits desde `development` hasta `HEAD` |
| `Espacio+gq` | Cerrar |

**Dentro:** `Tab` / `Shift+Tab` entre archivos · `g?` ayuda.

> ⚠️ Los atajos asumen una rama base `development`. Cámbialos en
> [`lua/plugins/git.lua`](../lua/plugins/git.lua) si usas `main`.

---

## git-conflict — conflictos

**Plugin:** `git-conflict.nvim` · **Activa:** `BufReadPre`

| Atajo | Acción |
|-------|--------|
| `Espacio+co` | Elegir **nuestro** cambio (current) |
| `Espacio+ct` | Elegir **su** cambio (incoming) |
| `Espacio+cb` | Elegir **ambos** |
| `Espacio+cn` / `Espacio+cp` | Conflicto siguiente / anterior |
| `Espacio+cl` | Listar todos los conflictos |

📖 Workflow en **[git-and-github.md](git-and-github.md#git-conflict--resolver-conflictos)**.

---

## Octo — GitHub

**Plugin:** `octo.nvim` · **Activa:** al pulsar `Espacio+o*` o `:Octo` · **Requiere:** `gh auth login`

| Atajo | Acción |
|-------|--------|
| `Espacio+opr` | Listar Pull Requests |
| `Espacio+opc` | Crear Pull Request |
| `Espacio+ois` | Listar Issues |
| `Espacio+oic` | Crear Issue |
| `Espacio+or` | Iniciar code review |

📖 Comandos completos en **[git-and-github.md](git-and-github.md#octo--prs-e-issues-de-github)**.

---

# Entorno

## ToggleTerm — terminal

**Plugin:** `toggleterm.nvim` · **Activa:** inmediato

| Atajo | Acción |
|-------|--------|
| `Ctrl+´` | Toggle de la terminal horizontal |
| `Espacio+tt` | Igual (alternativa si `Ctrl+´` no funciona en tu teclado) |
| `Espacio+ld` | **LazyDocker** en ventana flotante |

### Dentro de la terminal

| Atajo | Acción |
|-------|--------|
| `Esc` | Salir a modo normal (sin cerrar la terminal) |
| `i` / `a` | Volver al modo terminal |
| `Ctrl+h/j/k/l` | Moverse a otros splits sin salir del modo terminal |

---

## Docker — LazyDocker

**Herramienta:** [LazyDocker](https://github.com/jesseduffield/lazydocker) vía `toggleterm.nvim` · **Activa:** al pulsar `Espacio+ld`

Interfaz visual para ver contenedores, logs, imágenes y volúmenes sin salir de Neovim.

| Atajo | Acción |
|-------|--------|
| `Espacio+ld` | Abrir **LazyDocker** en ventana flotante |

### Dentro de LazyDocker

| Tecla | Acción |
|-------|--------|
| `Tab` · `[` `]` | Cambiar entre paneles (Containers, Images, Volumes, Logs) |
| `↑` `↓` · `j` `k` | Moverse en la lista |
| `Enter` | Ver detalle / logs del elemento seleccionado |
| `x` | **Menú de acciones** del elemento (lo más útil: lista todo lo posible) |
| `s` | Parar el contenedor |
| `r` | Reiniciar el contenedor |
| `a` | Attach al contenedor |
| `d` | Eliminar (pide confirmación) |
| `/` | Filtrar |
| `q` | Salir de LazyDocker |

> 💡 **Si dudas de una tecla, pulsa `x`**: abre el menú contextual con todas las
> acciones disponibles para lo que tengas seleccionado. Es la forma más segura
> de operar sin memorizar atajos.

### Comandos desde la terminal

Con `Ctrl+´` (terminal integrada) o un panel de tmux:

```bash
# Ver estado
docker ps                          # contenedores corriendo
docker ps -a                       # incluidos los parados
docker compose ps                  # solo los del compose actual

# Logs
docker compose logs -f web         # seguir logs de un servicio
docker compose logs --tail=100 web

# Ciclo de vida
docker compose up -d               # levantar en segundo plano
docker compose down                # bajar todo
docker compose restart web         # reiniciar un servicio
docker compose build web           # reconstruir la imagen

# Entrar al contenedor
docker compose exec web bash
docker compose exec web python manage.py migrate

# Limpieza
docker system df                   # cuánto espacio ocupa Docker
docker system prune                # borrar lo no usado ⚠️
```

### Soporte de LSP

Los archivos de Docker tienen autocompletado y diagnósticos:

| Archivo | Servidor |
|---------|----------|
| `Dockerfile` | `dockerls` |
| `docker-compose*.yml` · `compose*.yml` | `docker_compose_language_service` |

> El filetype de los compose se asigna con un autocomando en
> [`lua/config/autocmds.lua`](../lua/config/autocmds.lua), porque Neovim los
> detecta como YAML genérico y no activaría su servidor.

---

## HTML — Live Server

**Herramienta:** [live-server](https://github.com/tapio/live-server) vía `npx` + `toggleterm.nvim` · **Activa:** al pulsar `Espacio+lv` · **Requiere:** Node.js (ya lo tienes)

Equivalente a la extensión Live Server de VSCode: sirve tus archivos HTML/CSS y
**recarga el navegador solo** cada vez que guardas. Pensado para cursos o
prácticas de HTML/CSS puro que no usan Docker ni un backend.

| Atajo | Acción |
|-------|--------|
| `Espacio+lv` | Abrir **Live Server** en terminal flotante — sirve la carpeta del archivo actual y abre el navegador |

### Cómo se usa

```
1. Abre tu index.html
2. Espacio+lv           → arranca el servidor y abre el navegador solo
3. Esc                  → sales de la terminal flotante, sigue sirviendo en fondo
4. Edita y guarda tu .html o .css
5. Mira el navegador: se refrescó solo
```

`Espacio+lv` otra vez la vuelve a mostrar/ocultar (igual que `Espacio+ld` con
LazyDocker) sin reiniciar el servidor.

### 🖥️ No está "dentro" de Neovim — y así debe ser

Neovim corre en una terminal de texto: no puede dibujar un navegador real
adentro. Lo que hace este atajo es levantar el servidor y abrir tu navegador
del sistema **al lado** de la ventana de Neovim — visualmente es la misma
experiencia que Live Server en VSCode (código a un lado, resultado al otro),
solo que el navegador es una ventana aparte en vez de un panel embebido.

### Detalles técnicos

- Sirve **la carpeta**, no solo el archivo — si tienes `index.html` + `style.css`
  en la misma carpeta, los enlaces relativos funcionan igual que en producción
- El servidor arranca sirviendo la carpeta del archivo que tenías abierto **la
  primera vez** que pulsas `Espacio+lv`. Si cambias a un curso/carpeta distinta,
  reinicia Neovim para que vuelva a capturar la carpeta correcta
- Usa `npx --yes live-server`, no una instalación global — no necesitas
  `sudo` ni tocar nada del sistema

---

## tmux

**Plugin de integración:** `vim-tmux-navigator` · **Activa:** inmediato

| Atajo | Acción |
|-------|--------|
| `Ctrl+h` `Ctrl+j` `Ctrl+k` `Ctrl+l` | Moverse entre splits de Neovim **y** paneles de tmux |

**Prefijo de tmux:** `Ctrl+a` · `Ctrl+a d` detach · `Ctrl+a s` sesiones ·
`Ctrl+a z` zoom · `Ctrl+a |` y `Ctrl+a -` dividir.

📖 Configuración completa en **[tmux.md](tmux.md)**.

---

## auto-session — sesiones

**Plugin:** `auto-session` · **Activa:** inmediato

Guarda y restaura automáticamente los archivos abiertos por **carpeta y rama de git**.

| Atajo | Acción |
|-------|--------|
| `Espacio+ss` | Guardar la sesión manualmente |
| `Espacio+sr` | Restaurar la sesión |
| `Espacio+sd` | Eliminar la sesión de esta carpeta |

Excluido en `~/`, `~/Documents` y `/` para no restaurar sesiones basura.

---

## Legendary — paleta de comandos

**Plugin:** `legendary.nvim` · **Activa:** `VeryLazy`

Buscador difuso de **todos** los atajos y comandos disponibles. El salvavidas
cuando no recuerdas un atajo.

| Atajo | Acción |
|-------|--------|
| `Ctrl+p` | Abrir la paleta |
| `Espacio+lk` | Ver solo los atajos (keymaps) |
| `Espacio+lc` | Ver solo los comandos |

---

## Dashboard

**Plugin:** `dashboard-nvim` · **Activa:** `VimEnter` (al abrir `nvim` sin archivo)

| Tecla | Acción |
|-------|--------|
| `f` | Buscar archivo |
| `r` | Abrir proyecto desde `~/Documents` |
| `g` | Buscar texto |
| `c` | Editar la configuración |
| `p` | Abrir Lazy (plugins) |
| `q` | Salir |
| `1` .. `5` | Abrir uno de los archivos recientes |

---

## which-key

**Plugin:** `which-key.nvim` · **Activa:** `VeryLazy`

Pulsa `Espacio` (o cualquier prefijo) y espera 300ms: aparece un panel con las
opciones disponibles. Grupos definidos:

| Prefijo | Grupo |
|---------|-------|
| `Espacio+f` | Buscar |
| `Espacio+g` | Git |
| `Espacio+h` | Git hunks / Harpoon |
| `Espacio+w` | Ventanas |
| `Espacio+c` | Código / Conflictos |
| `Espacio+d` | Debug |
| `Espacio+n` | Tests |
| `Espacio+s` | Sesión / Spectre |
| `Espacio+x` | Diagnósticos |
| `Espacio+o` | Octo (GitHub) |
| `Espacio+l` | Legendary |
| `Espacio+t` | Toggle |
| `Espacio+m` | Markdown |

---

# Ejecución

## nvim-dap — debugger

**Plugin:** `nvim-dap` + `nvim-dap-python` · **Activa:** al pulsar `Espacio+d*`

| Atajo | Acción |
|-------|--------|
| `Espacio+db` | Poner / quitar breakpoint |
| `Espacio+dc` | Continuar — o iniciar y elegir configuración |
| `Espacio+do` | Step over |
| `Espacio+di` | Step into |
| `Espacio+dx` | Terminar la sesión |
| `Espacio+du` | Toggle de la UI |

**Configuraciones:** "Django runserver", "Launch file", "Attach remote".

📖 Workflow en **[django.md](django.md#debugger)**.

---

## Neotest — tests

**Plugin:** `neotest` + `neotest-python` · **Activa:** al pulsar `Espacio+n*`

| Atajo | Acción |
|-------|--------|
| `Espacio+nt` | Correr el test bajo el cursor |
| `Espacio+nf` | Correr todos los tests del archivo |
| `Espacio+ns` | Toggle del panel de resultados |
| `Espacio+no` | Ver el output del test |

Usa `pytest` con `.venv/bin/python`. Resultados inline: ✅ / ❌.

📖 Detalles en **[django.md](django.md#tests-con-neotest)**.

---

## Markdown Preview

**Plugin:** `markdown-preview.nvim` · **Activa:** al abrir un `.md` (`ft = markdown`)

| Atajo | Acción |
|-------|--------|
| `Espacio+mp` | Abrir el preview en el navegador |
| `Espacio+ms` | Detener el preview |

---

## Colorizer

**Plugin:** `nvim-colorizer.lua` · **Activa:** `BufReadPre`

Pinta el fondo de los colores CSS/hex con su color real.

| Atajo / Comando | Acción |
|-----------------|--------|
| `Espacio+tc` | Toggle |
| `:ColorizerToggle` | Igual |

Activo en css, scss, sass, html, htmldjango, javascript, typescript, jsx, tsx y
lua. Soporta nombres (`red`), `rgb()`, `hsl()`, hex y clases de Tailwind.

---

## Extras

**Plugin:** `cellular-automaton.nvim` · **Activa:** al pulsar el atajo

| Atajo | Acción |
|-------|--------|
| `Espacio+fml` | "Make it rain": el código se derrite 🌧️ |
| `Espacio+gol` | Game of Life sobre tu buffer |

Puro entretenimiento. Cualquier tecla lo detiene.

---

# Referencia

## Comandos de gestión

### Plugins

| Comando | Acción |
|---------|--------|
| `:Lazy` | Abrir el panel de plugins |
| `:Lazy sync` | Actualizar + limpiar + instalar |
| `:Lazy update` | Solo actualizar |
| `:Lazy clean` | Borrar plugins que ya no están en la config |
| `:Lazy restore` | Volver a las versiones de `lazy-lock.json` |
| `:Lazy profile` | Tiempo de carga por plugin |

### LSP y herramientas

| Comando | Acción |
|---------|--------|
| `:Mason` | Gestor de LSPs (`i` instalar, `X` desinstalar, `U` actualizar todos) |
| `:LspInfo` | Servidores adjuntos a este buffer |
| `:LspRestart` | Reiniciar servidores |
| `:LspLog` | Log de errores del LSP |
| `:ConformInfo` | Formatters disponibles y activo |
| `:TSUpdate` | Actualizar parsers de Treesitter |
| `:Copilot status` | Estado de Copilot |

### Diagnóstico

| Comando | Acción |
|---------|--------|
| `:checkhealth` | Diagnóstico completo |
| `:checkhealth lsp` | Solo LSP |
| `:checkhealth telescope` | Solo Telescope |
| `:messages` | Mensajes y errores de la sesión |
| `:version` | Versión de Neovim |
| `:verbose nmap <leader>gd` | Ver si un atajo existe y de dónde viene |

### Utilidades de shell

| Comando | Acción |
|---------|--------|
| `:!comando` | Ejecutar un comando de shell |
| `:read !comando` | Insertar la salida en el buffer |
| `:%!jq` | Formatear todo el JSON del buffer |
| `:sort` / `:sort n` | Ordenar líneas alfabética / numéricamente |
| `:g/^$/d` | Borrar todas las líneas vacías |
| `:args *.py` + `:argdo %s/a/b/g` | Reemplazar en varios archivos |

---

## Cheatsheet alfabético

Todos los atajos con `Espacio`, ordenados. **74 en total.**

| Atajo | Herramienta | Acción |
|-------|-------------|--------|
| `Espacio++` | NvimTree | Ampliar ancho |
| `Espacio+-` | NvimTree | Reducir ancho |
| `Espacio+1..4` | Harpoon | Ir al archivo marcado 1-4 |
| `Espacio+a` | Harpoon | Marcar archivo |
| `Espacio+bp` | Dropbar | Navegar breadcrumb |
| `Espacio+ca` | LSP | Code actions |
| `Espacio+cb` | git-conflict | Elegir ambos cambios |
| `Espacio+cf` | conform | Formatear |
| `Espacio+cl` | git-conflict | Listar conflictos |
| `Espacio+cn` | git-conflict | Conflicto siguiente |
| `Espacio+co` | git-conflict | Elegir nuestro cambio |
| `Espacio+cp` | git-conflict | Conflicto anterior |
| `Espacio+ct` | git-conflict | Elegir su cambio |
| `Espacio+db` | DAP | Toggle breakpoint |
| `Espacio+dc` | DAP | Continuar / iniciar |
| `Espacio+di` | DAP | Step into |
| `Espacio+do` | DAP | Step over |
| `Espacio+du` | DAP | Toggle UI |
| `Espacio+dx` | DAP | Terminar debug |
| `Espacio+e` | NvimTree | Toggle explorador |
| `Espacio+fb` | Telescope | Buscar buffers |
| `Espacio+ff` | Telescope | Buscar archivos |
| `Espacio+fg` | Telescope | Buscar contenido |
| `Espacio+fml` | Extras | Make it rain |
| `Espacio+fp` | Telescope | Archivos en todos los proyectos |
| `Espacio+fP` | Telescope | Contenido en todos los proyectos |
| `Espacio+ft` | todo-comments | Buscar TODOs |
| `Espacio+gd` | Diffview | Diff con development |
| `Espacio+gD` | Diffview | Diff con origin/development |
| `Espacio+gf` | Diffview | Commits desde development |
| `Espacio+gh` | Diffview | Historial del archivo |
| `Espacio+gol` | Extras | Game of Life |
| `Espacio+gq` | Diffview | Cerrar Diffview |
| `Espacio+gs` | Fugitive | Git status |
| `Espacio+gu` | Fugitive | Descartar cambios del archivo |
| `Espacio+gU` | Fugitive | Descartar todos los cambios ⚠️ |
| `Espacio+gw` | Diffview | Diff working tree |
| `Espacio+hb` | GitSigns | Blame de la línea |
| `Espacio+hd` | GitSigns | Diff del archivo |
| `Espacio+hh` | Harpoon | Ver lista de marcados |
| `Espacio+hp` | GitSigns | Preview del hunk |
| `Espacio+hr` | GitSigns | Reset del hunk |
| `Espacio+hs` | GitSigns | Stage del hunk |
| `Espacio+lc` | Legendary | Ver comandos |
| `Espacio+ld` | ToggleTerm | LazyDocker |
| `Espacio+lk` | Legendary | Ver atajos |
| `Espacio+lv` | Live Server | Preview HTML/CSS con auto-recarga |
| `Espacio+mp` | Markdown Preview | Abrir preview |
| `Espacio+ms` | Markdown Preview | Detener preview |
| `Espacio+nf` | Neotest | Tests del archivo |
| `Espacio+no` | Neotest | Output del test |
| `Espacio+ns` | Neotest | Panel de resultados |
| `Espacio+nt` | Neotest | Test bajo el cursor |
| `Espacio+oic` | Octo | Crear issue |
| `Espacio+ois` | Octo | Listar issues |
| `Espacio+opc` | Octo | Crear PR |
| `Espacio+opr` | Octo | Listar PRs |
| `Espacio+or` | Octo | Iniciar review |
| `Espacio+q` | Config | Cerrar split |
| `Espacio+rn` | LSP | Renombrar símbolo |
| `Espacio+S` | Spectre | Abrir panel |
| `Espacio+sd` | auto-session | Eliminar sesión |
| `Espacio+sf` | Spectre | Buscar en archivo actual |
| `Espacio+sr` | auto-session | Restaurar sesión |
| `Espacio+ss` | auto-session | Guardar sesión |
| `Espacio+sw` | Spectre | Buscar palabra en proyecto |
| `Espacio+tb` | GitSigns | Toggle blame inline |
| `Espacio+tc` | Colorizer | Toggle colorizer |
| `Espacio+tt` | ToggleTerm | Toggle terminal |
| `Espacio+ve` | Config | Editar .env |
| `Espacio+wo` | Config | Cerrar otros splits |
| `Espacio+ws` | Config | Split abajo |
| `Espacio+wv` | Config | Split derecha |
| `Espacio+xf` | Trouble | Errores del archivo |
| `Espacio+xq` | Trouble | Quickfix list |
| `Espacio+xx` | Trouble | Errores del proyecto |

### Sin leader

| Atajo | Herramienta | Acción |
|-------|-------------|--------|
| `Ctrl+s` / `Ctrl+q` | Config | Guardar / salir sin guardar |
| `Ctrl+h/j/k/l` | tmux-navigator | Moverse entre splits y paneles |
| `Ctrl+p` | Legendary | Paleta de comandos |
| `Ctrl+´` | ToggleTerm | Terminal |
| `Ctrl+Space` | nvim-cmp | Autocompletado manual |
| `jk` / `kj` | Config | Salir de insert |
| `gd` `gr` `gi` `K` | LSP | Definición, referencias, implementación, hover |
| `]d` / `[d` | LSP | Diagnóstico siguiente / anterior |
| `]c` / `[c` | GitSigns | Cambio siguiente / anterior |
| `s` / `S` | Flash | Salto / salto por Treesitter |
| `gcc` / `gc` | Comment | Comentar línea / selección |
| `ys` `cs` `ds` | nvim-surround | Envolver, cambiar, eliminar |
| `Alt+e` | autopairs | Fast wrap |

---

[⬅️ Volver al README](../README.md) · [Rutina diaria ➡️](daily-routine.md)
