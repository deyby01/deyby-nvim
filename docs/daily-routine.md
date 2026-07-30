# 🔁 Rutina Diaria de un Developer

> Los flujos reales del día a día, en el orden en que ocurren.
> Para la referencia completa de atajos, mira **[commands-and-workflow.md](commands-and-workflow.md)**.

---

## 📋 Contenido

1. [Arrancar el día](#1-arrancar-el-día)
2. [Empezar una tarea nueva](#2-empezar-una-tarea-nueva)
3. [Entender código ajeno](#3-entender-código-ajeno)
4. [Escribir código](#4-escribir-código)
5. [Cuando algo no funciona](#5-cuando-algo-no-funciona)
6. [Refactorizar](#6-refactorizar)
7. [Antes de commitear](#7-antes-de-commitear)
8. [Commit y push](#8-commit-y-push)
9. [Abrir el Pull Request](#9-abrir-el-pull-request)
10. [Revisar el PR de otra persona](#10-revisar-el-pr-de-otra-persona)
11. [Resolver conflictos](#11-resolver-conflictos)
12. [Cerrar el día](#12-cerrar-el-día)
13. [Los 15 atajos que usarás el 90% del tiempo](#los-15-atajos-que-usarás-el-90-del-tiempo)

---

## 1. Arrancar el día

```bash
# Sesión de tmux (el servidor sobrevive al cierre de la terminal)
tmux new -s mi-proyecto

cd ~/Documents/mi-proyecto
source .venv/bin/activate     # importante: los linters vienen del venv
nvim
```

auto-session restaura los archivos que tenías abiertos en esta carpeta y rama.

```
Espacio+gs        # ¿en qué estado quedó el repo?
:Git pull origin development
Espacio+opr       # ¿tengo PRs pendientes de revisar?
```

> 💡 Si no usas tmux, `Espacio+ld` te da LazyDocker y `Ctrl+´` una terminal
> integrada. tmux solo hace falta cuando quieres que un proceso sobreviva.

---

## 2. Empezar una tarea nueva

```
:Git checkout development
:Git pull origin development
:Git checkout -b feature/nombre-tarea
```

Marca los archivos que vas a tocar para saltar entre ellos sin buscar:

```
Espacio+ff  → models.py       → Espacio+a
Espacio+ff  → views.py        → Espacio+a
Espacio+ff  → serializers.py  → Espacio+a
Espacio+ff  → tests.py        → Espacio+a

# Ahora:
Espacio+1  Espacio+2  Espacio+3  Espacio+4
```

Levanta el servidor en un panel aparte:

```
Ctrl+a -                       # panel de tmux abajo
python manage.py runserver
Ctrl+k                         # volver a Neovim
```

---

## 3. Entender código ajeno

Lo que más hace un dev: leer código que no escribió.

| Quiero... | Atajo |
|-----------|-------|
| Ver qué hace esta función | `K` (hover) |
| Ir a donde está definida | `gd` |
| Ver **quién la llama** | `gr` (referencias) |
| Volver de donde vine | `Ctrl+o` |
| Buscar un texto en todo el proyecto | `Espacio+fg` |
| Ver la estructura del archivo | `Espacio+bp` (breadcrumbs) |
| Saber quién escribió esta línea y por qué | `Espacio+hb` (blame) |
| Ver el historial completo del archivo | `Espacio+gh` |

### Flujo de exploración típico

```
Espacio+fg  → buscar "PedidoSerializer"
Enter       → abrir el resultado
gd          → ir a la definición de la clase base
Ctrl+o      → volver
gr          → ver todos los sitios que la usan
Espacio+hb  → ¿por qué se escribió así? (blame → commit → PR)
```

> 💡 **`Ctrl+o` / `Ctrl+i`** navegan el jumplist (atrás/adelante). Son la clave
> para explorar sin perderte.

---

## 4. Escribir código

### El ciclo básico

```
i                    # entrar a insert
{escribir}           # LSP + Copilot + snippets sugieren en el mismo menú
Tab / Shift+Tab      # moverse entre opciones
Enter                # aceptar
jk                   # salir de insert (se autoguarda)
```

### Acelerar con snippets

```
model          → clase models.Model completa
serializer     → ModelSerializer de DRF
listview       → vista basada en clase
block          → {% block %}{% endblock %} (en templates)
div.card>ul>li*3  → estructura HTML (Emmet)
```

Lista completa en **[django.md](django.md#snippets)**.

### Cuando falta un import

```
Espacio+ca     → code actions → "Import X from Y"
```

### Formatear antes de seguir

```
Espacio+cf     → ruff / prettier / djlint según el filetype
```

### Edición que ahorra tiempo

| Necesito | Cómo |
|----------|------|
| Cambiar una palabra completa | `ciw` |
| Cambiar hasta el final de línea | `C` |
| Duplicar una línea | `yy` `p` |
| Comentar la línea / selección | `gcc` / `gc` en visual |
| Envolver en comillas | `ysiw"` |
| Cambiar `'` por `"` | `cs'"` |
| Indentar varias líneas | `V` `j j` `>` (y `.` para repetir) |
| Editar N líneas a la vez | `Ctrl+v` → `j j` → `I` → texto → `Esc` |
| Saltar a un punto visible | `s` + 2 letras |
| **Repetir lo último** | `.` |

---

## 5. Cuando algo no funciona

### Primero: ¿qué dice el editor?

```
Espacio+xf     # errores del archivo actual
Espacio+xx     # errores de todo el proyecto
]d / [d        # saltar entre ellos
```

### Debugger en vez de prints

```
Espacio+db     # breakpoint en la línea sospechosa
Espacio+dc     # iniciar → "Django runserver"
# hacer la request desde el navegador → se pausa ahí
Espacio+do     # avanzar línea por línea
# inspeccionar variables en el panel Scopes
Espacio+dx     # terminar
```

Detalles en **[django.md](django.md#debugger)**.

### Los tests

```
Espacio+nt     # correr el test bajo el cursor
Espacio+no     # ver el traceback si falla
Espacio+nf     # correr todo el archivo
```

### ¿Funcionaba antes?

```
Espacio+gh     # historial del archivo: ver qué cambió y cuándo
Espacio+hb     # blame de la línea sospechosa
```

---

## 6. Refactorizar

### Renombrar bien

```
Espacio+rn     # renombra el símbolo en TODO el proyecto vía LSP
```

Es lo correcto para variables, funciones y clases: entiende el scope, no toca
strings ni comentarios que casualmente coincidan.

### Buscar y reemplazar texto

```
Espacio+sw     # buscar la palabra bajo el cursor en todo el proyecto
# revisar la lista, excluir con dd lo que no quieras
R              # aplicar
```

Para strings, URLs, nombres de templates: cosas que el LSP no entiende como símbolos.

### Verificar que no rompiste nada

```
Espacio+xx     # ¿aparecieron errores nuevos?
Espacio+nf     # ¿pasan los tests?
Espacio+gw     # ¿el diff es lo que esperaba?
```

---

## 7. Antes de commitear

**El paso que más rondas de review ahorra:** revisar tu propio diff.

```
Espacio+gw     # diff completo del working tree
Tab            # recorrer archivo por archivo
```

### Checklist mental

```
Espacio+ft     # ¿dejé TODOs o FIXMEs sin resolver?
Espacio+xx     # ¿hay errores o warnings?
Espacio+cf     # ¿está formateado?
Espacio+nf     # ¿pasan los tests?
```

Cosas que suelen colarse y se ven en el diff: `print()` de debug, `console.log`,
credenciales hardcodeadas, código comentado, imports sin usar.

---

## 8. Commit y push

### Commits limpios por hunks

Si tocaste varias cosas en un archivo, sepáralas:

```
]c             # ir al primer cambio
Espacio+hp     # revisarlo
Espacio+hs     # stagear solo ese hunk
]c             # siguiente... (o dejarlo para otro commit)
```

### Commitear

```
Espacio+gs     # panel de status
s              # stagear el archivo bajo el cursor
=              # ver su diff antes de decidir
cc             # commit → escribir mensaje → Ctrl+s
```

### Push

```
:Git push origin feature/nombre-tarea
```

---

## 9. Abrir el Pull Request

Antes de pedirlo, mira el conjunto completo de tus commits:

```
Espacio+gf     # todos los commits desde development hasta HEAD
Espacio+gd     # diff completo contra development
```

Luego:

```
Espacio+opc    # crear el PR desde Neovim
```

O desde la terminal:

```bash
gh pr create --base development --title "..." --body "..."
```

---

## 10. Revisar el PR de otra persona

```
Espacio+opr    # listar PRs
Enter          # abrir el que te asignaron
Espacio+or     # iniciar el review
Espacio+gD     # ver el diff contra origin/development
```

Mientras revisas:

| Quiero | Atajo |
|--------|-------|
| Entender una función que cambió | `gd` / `K` |
| Ver si eso rompe otros sitios | `gr` |
| Comentar en una línea | `:Octo comment add` |
| Ver el contexto histórico | `Espacio+gh` |

```
:Octo review submit
```

---

## 11. Resolver conflictos

```
:Git merge development
# → CONFLICT

Espacio+cl     # ver todos los conflictos del repo
Espacio+cn     # ir al siguiente
Espacio+co     # quedarme con lo mío
Espacio+ct     # quedarme con lo de la otra rama
Espacio+cb     # quedarme con ambos y editar a mano

Espacio+cl     # verificar que la lista quedó vacía
Espacio+nf     # correr los tests: los conflictos mal resueltos compilan pero fallan
Espacio+gs → s → cc
```

> ⚠️ En un **rebase**, "ours" y "theirs" están invertidos respecto a un merge. Si
> dudas, mira el contenido, no la etiqueta.

---

## 12. Cerrar el día

```
Espacio+gs                          # ¿queda algo sin commitear?
s → cc                              # commit de lo que esté listo
:Git push origin mi-rama            # subirlo (respaldo remoto)
Espacio+ss                          # guardar la sesión
:qa                                 # cerrar Neovim
Ctrl+a d                            # detach de tmux (el server sigue vivo)
```

Al día siguiente:

```bash
tmux attach -t mi-proyecto
# todo exactamente como lo dejaste
```

> 💡 Si dejas trabajo a medias, haz un commit `wip:` y súbelo. Un disco que
> muere no avisa.

---

## Los 15 atajos que usarás el 90% del tiempo

Si solo vas a memorizar unos pocos, que sean estos:

| # | Atajo | Acción |
|---|-------|--------|
| 1 | `Espacio+ff` | Buscar archivo |
| 2 | `Espacio+fg` | Buscar texto en el proyecto |
| 3 | `gd` | Ir a la definición |
| 4 | `gr` | Ver referencias |
| 5 | `Ctrl+o` | Volver de donde vine |
| 6 | `K` | Ver documentación |
| 7 | `Espacio+ca` | Code actions (auto-import) |
| 8 | `Espacio+cf` | Formatear |
| 9 | `Espacio+xf` | Errores del archivo |
| 10 | `Espacio+gs` | Git status |
| 11 | `Espacio+hp` | Preview del cambio de git |
| 12 | `s` | Saltar a cualquier punto |
| 13 | `gcc` | Comentar |
| 14 | `.` | Repetir la última acción |
| 15 | `Ctrl+p` | Buscar cualquier comando que olvidaste |

---

## Comandos de terminal frecuentes

Desde `Ctrl+´` o un panel de tmux:

```bash
# Django
python manage.py runserver
python manage.py makemigrations && python manage.py migrate
python manage.py shell
python manage.py createsuperuser

# Docker
docker compose up -d
docker compose logs -f web
docker compose restart web
docker compose exec web python manage.py migrate

# Tests
pytest
pytest -k "nombre_del_test"
pytest --lf                    # solo los que fallaron la última vez

# Frontend
npm run dev
npm run build
```

---

## Tips que marcan diferencia

- **`.` es el atajo más subestimado de Vim.** Haz un cambio, muévete al
  siguiente sitio, `.`. Funciona con casi todo.
- **`Ctrl+p` cuando no recuerdes algo.** Busca por nombre entre todos los atajos
  y comandos. Más rápido que abrir la documentación.
- **Marca con Harpoon al empezar la tarea, no a mitad.** Los 4 archivos que vas
  a tocar los sabes desde el principio.
- **`TODO:` y `FIXME:` en vez de notas mentales.** Los recuperas con `Espacio+ft`.
- **Stagea por hunks (`Espacio+hs`).** Commits pequeños se revisan mejor y se
  revierten sin dolor.
- **Revisa tu propio diff antes de pedir review.** Ahorra la ronda de "quita el
  print" y "sobra ese import".

---

[⬅️ Volver al README](../README.md) · [Referencia de comandos ➡️](commands-and-workflow.md)
