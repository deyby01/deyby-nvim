# 🔀 Git y GitHub

> Todo el flujo de Git sin salir del editor: status, hunks, diffs, conflictos, PRs y reviews.

**Plugins:** `vim-fugitive` · `gitsigns.nvim` · `diffview.nvim` · `git-conflict.nvim` · `octo.nvim`
**Archivo de config:** [`lua/plugins/git.lua`](../lua/plugins/git.lua)

---

## 📋 Contenido

- [Qué herramienta usar para qué](#qué-herramienta-usar-para-qué)
- [Fugitive — status y comandos](#fugitive--status-y-comandos)
- [GitSigns — cambios línea por línea](#gitsigns--cambios-línea-por-línea)
- [Diffview — comparar ramas](#diffview--comparar-ramas)
- [git-conflict — resolver conflictos](#git-conflict--resolver-conflictos)
- [Octo — PRs e Issues de GitHub](#octo--prs-e-issues-de-github)
- [Flujos completos](#flujos-completos)

---

## Qué herramienta usar para qué

Los cinco plugins se solapan un poco. Guía rápida:

| Quiero... | Herramienta | Atajo |
|-----------|-------------|-------|
| Ver qué archivos cambié y hacer commit | **Fugitive** | `Espacio+gs` |
| Ver/stagear cambios de la línea donde estoy | **GitSigns** | `Espacio+hp` `Espacio+hs` |
| Comparar mi rama contra `development` | **Diffview** | `Espacio+gd` |
| Ver el historial de un archivo | **Diffview** | `Espacio+gh` |
| Resolver un conflicto de merge | **git-conflict** | `Espacio+co` `Espacio+ct` |
| Crear o revisar un PR | **Octo** | `Espacio+opc` `Espacio+opr` |

---

## Fugitive — status y comandos

El "panel de control" de Git. `Espacio+gs` abre el status interactivo.

### Atajos

| Atajo | Acción |
|-------|--------|
| `Espacio+gs` | **Git status** (panel interactivo) |
| `Espacio+gu` | Deshacer cambios del **archivo actual** |
| `Espacio+gU` | Deshacer **TODOS** los cambios ⚠️ |

### Dentro del panel de status

| Tecla | Acción |
|-------|--------|
| `s` | **Stage** el archivo bajo el cursor |
| `u` | **Unstage** el archivo |
| `-` | Toggle stage/unstage |
| `=` | Ver el **diff** inline del archivo |
| `cc` | Crear **commit** (abre buffer de mensaje) |
| `ca` | **Amend** al último commit |
| `X` | Descartar los cambios del archivo ⚠️ |
| `dd` | Ver el diff en un split |
| `dv` | Ver el diff en split vertical |
| `q` | Cerrar el panel |

> 💡 Al hacer `cc`, escribe el mensaje y guarda con `Ctrl+s`. Para cancelar el
> commit, cierra el buffer sin guardar (`:q!`).

### Comandos

| Comando | Acción |
|---------|--------|
| `:Git` | Igual que `Espacio+gs` |
| `:Git add %` | Stage del archivo actual |
| `:Git commit -m "mensaje"` | Commit directo |
| `:Git push origin mi-rama` | Push |
| `:Git pull origin development` | Pull |
| `:Git checkout -b feature/algo` | Crear rama |
| `:Git log --oneline` | Historial |
| `:Git blame` | Quién escribió cada línea |
| `:Git restore archivo` | Descartar cambios |

---

## GitSigns — cambios línea por línea

Muestra en la columna izquierda qué líneas agregaste (`│`), modificaste (`│`)
o borraste (`_`), y permite operar hunk por hunk.

### Atajos

| Atajo | Acción |
|-------|--------|
| `]c` | Ir al **siguiente** cambio |
| `[c` | Ir al cambio **anterior** |
| `Espacio+hp` | **Preview** del hunk (ver el diff en un popup) |
| `Espacio+hs` | **Stage** solo este hunk |
| `Espacio+hr` | **Reset** solo este hunk |
| `Espacio+hb` | **Blame** de la línea actual (completo) |
| `Espacio+hd` | **Diff** del archivo completo |
| `Espacio+tb` | Toggle del blame inline en todas las líneas |

> 💡 **Blame inline activo por defecto**: al final de cada línea aparece en gris
> quién la escribió y cuándo. `Espacio+tb` lo apaga si molesta.

### Por qué stagear por hunks

Si tocaste tres cosas distintas en un archivo, puedes hacer tres commits
limpios en vez de uno mezclado:

```
]c              → primer cambio
Espacio+hp      → revisar que sea lo que quieres
Espacio+hs      → stagear solo ese
]c              → siguiente cambio... (o dejarlo para otro commit)
Espacio+gs → cc → commitear solo lo stageado
```

---

## Diffview — comparar ramas

Vista de diff completa, tipo GitHub, para comparar ramas y ver historiales.

### Atajos

| Atajo | Acción |
|-------|--------|
| `Espacio+gd` | Diff contra **`development`** local |
| `Espacio+gD` | Diff contra **`origin/development`** |
| `Espacio+gw` | Diff del **working tree** (cambios sin commitear) |
| `Espacio+gh` | **Historial** del archivo actual |
| `Espacio+gf` | Todos los **commits** desde `development` hasta `HEAD` |
| `Espacio+gq` | **Cerrar** Diffview |

### Dentro de Diffview

| Tecla | Acción |
|-------|--------|
| `Tab` | Siguiente archivo del diff |
| `Shift+Tab` | Archivo anterior |
| `j` / `k` + `Enter` | Navegar y abrir en el panel de archivos |
| `-` | Stage/unstage el archivo |
| `X` | Restaurar el archivo |
| `g?` | Ayuda con todos los atajos |

> ⚠️ **Los atajos asumen una rama base llamada `development`**. Si tu equipo usa
> `main` o `develop`, cámbialos en la sección `keys` de diffview en
> [`lua/plugins/git.lua`](../lua/plugins/git.lua).

### Comandos

```vim
:DiffviewOpen                     " working tree
:DiffviewOpen main                " contra main
:DiffviewOpen HEAD~3              " contra 3 commits atrás
:DiffviewOpen feature-a..feature-b  " entre dos ramas
:DiffviewFileHistory %            " historial del archivo actual
:DiffviewFileHistory              " historial del repo completo
:DiffviewClose
```

---

## git-conflict — resolver conflictos

Cuando hay un conflicto de merge o rebase, resalta las tres partes con colores
y permite elegir con un atajo.

### Atajos

| Atajo | Acción |
|-------|--------|
| `Espacio+co` | Elegir **nuestro** cambio (current / HEAD) |
| `Espacio+ct` | Elegir **su** cambio (incoming) |
| `Espacio+cb` | Elegir **ambos** |
| `Espacio+cn` | Ir al **siguiente** conflicto |
| `Espacio+cp` | Ir al conflicto **anterior** |
| `Espacio+cl` | **Listar** todos los conflictos (quickfix) |

### Workflow

```bash
# 1. El merge falla
:Git merge development
# → CONFLICT

# 2. Ver todos los conflictos del repo
Espacio+cl

# 3. Por cada conflicto
Espacio+cn      → saltar al siguiente
Espacio+co      → me quedo con lo mío
Espacio+ct      → me quedo con lo de la otra rama
Espacio+cb      → me quedo con ambos y edito a mano

# 4. Verificar que no queden marcadores
Espacio+cl      → debe estar vacío

# 5. Commitear la resolución
Espacio+gs → s → cc
```

> 💡 **"Ours" vs "Theirs" en rebase está invertido** respecto a merge: durante
> un rebase, "ours" es la rama base y "theirs" son *tus* commits. Si dudas, mira
> el contenido, no la etiqueta.

---

## Octo — PRs e Issues de GitHub

### Requisito

```bash
sudo apt install gh -y
gh auth login
```

### Atajos

| Atajo | Acción |
|-------|--------|
| `Espacio+opr` | **Listar** Pull Requests |
| `Espacio+opc` | **Crear** un Pull Request |
| `Espacio+ois` | **Listar** Issues |
| `Espacio+oic` | **Crear** un Issue |
| `Espacio+or` | **Iniciar** un code review |

### Comandos

```vim
:Octo pr list
:Octo pr create
:Octo pr checkout        " cambiar a la rama del PR
:Octo pr merge
:Octo issue list
:Octo issue create
:Octo review start
:Octo review submit      " enviar el review
:Octo review discard
:Octo comment add        " comentar en la línea actual
```

### Dentro de un PR o Issue

| Tecla | Acción |
|-------|--------|
| `<localleader>ca` | Agregar comentario |
| `<localleader>ic` | Cerrar issue |
| `<localleader>po` | Abrir el PR en el navegador |
| `<localleader>rp` | Solicitar review |

> El `localleader` también es `Espacio` en esta configuración.

---

## Flujos completos

### Empezar una tarea

```bash
:Git checkout development
:Git pull origin development
:Git checkout -b feature/nombre-tarea
```

### Durante el desarrollo

```bash
]c / [c            # navegar mis cambios
Espacio+hp         # revisar cada hunk
Espacio+gw         # ver el diff completo del working tree
Espacio+gs         # status general
```

### Commit y push

```bash
Espacio+gs         # abrir status
s                  # stagear archivos (o Espacio+hs por hunks)
cc                 # commit → escribir mensaje → Ctrl+s
:Git push origin feature/nombre-tarea
```

### Crear el PR

```bash
Espacio+opc        # desde Neovim

# o desde la terminal
gh pr create --base development --title "..." --body "..."
```

### Revisar un PR asignado

```bash
Espacio+opr        # listar PRs
# Enter en el PR que te toca
Espacio+or         # iniciar review
Espacio+gD         # ver el diff contra origin/development
# comentar con :Octo comment add
:Octo review submit
```

### Antes de pedir merge — auto-review

```bash
Espacio+gf         # ver TODOS mis commits desde development
Espacio+gd         # diff completo contra development
```

Revisar tu propio diff antes de pedir review ahorra rondas de comentarios.

---

[⬅️ Volver al README](../README.md) · [tmux ➡️](tmux.md)
