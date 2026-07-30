# 🐍 Django, DRF y Templates

> Snippets, templates, debugger y tests para el stack Django.

**Relacionado:** [`lua/plugins/lsp.lua`](../lua/plugins/lsp.lua) · [`lua/plugins/debug.lua`](../lua/plugins/debug.lua) · [`lua/plugins/testing.lua`](../lua/plugins/testing.lua)

---

## 📋 Contenido

- [Snippets](#snippets)
- [Templates de Django](#templates-de-django)
- [Emmet en templates](#emmet-en-templates)
- [Debugger](#debugger)
- [Tests con Neotest](#tests-con-neotest)
- [Formateo](#formateo)
- [Workflow típico](#workflow-típico)

---

## Snippets

Provistos por `friendly-snippets` y activados con `filetype_extend`.
Escribe el prefijo, busca la entrada **Snippet** en el menú y acepta con `Enter`.
Salta entre placeholders con `Tab` / `Shift+Tab`.

### En templates (`.html` de Django)

| Escribe | Se expande a |
|---------|--------------|
| `block` | `{% block ... %}{% endblock %}` |
| `extends` | `{% extends "..." %}` |
| `include` | `{% include "..." %}` |
| `for` | `{% for ... in ... %}{% endfor %}` |
| `if` | `{% if ... %}{% endif %}` |
| `ifelse` | `{% if %}...{% else %}...{% endif %}` |
| `url` | `{% url '...' %}` |
| `static` | `{% static '...' %}` |
| `csrf` | `{% csrf_token %}` |
| `var` | `{{ variable }}` |
| `trans` | `{% trans "..." %}` |
| `comment` | `{% comment %}...{% endcomment %}` |
| `with` | `{% with ... %}{% endwith %}` |
| `load` | `{% load ... %}` |

### En Python — Models

| Escribe | Se expande a |
|---------|--------------|
| `model` | Clase `models.Model` con `Meta` y `__str__` |
| `char` / `text` / `int` | `CharField` / `TextField` / `IntegerField` |
| `fk` | `ForeignKey` con `on_delete` |
| `m2m` | `ManyToManyField` |
| `o2o` | `OneToOneField` |
| `datetime` | `DateTimeField` con `auto_now_add` |

### En Python — Forms y Views

| Escribe | Se expande a |
|---------|--------------|
| `form` | `forms.Form` |
| `modelform` | `forms.ModelForm` con `Meta` |
| `view` | Función vista |
| `listview` | `ListView` basada en clase |
| `detailview` | `DetailView` |
| `createview` / `updateview` | Vistas de escritura |

### En Python — DRF

| Escribe | Se expande a |
|---------|--------------|
| `serializer` | `serializers.Serializer` |
| `modelserializer` | `serializers.ModelSerializer` con `Meta` |
| `apiview` | `APIView` con métodos HTTP |
| `viewset` | `ModelViewSet` |

### En Python — URLs

| Escribe | Se expande a |
|---------|--------------|
| `path` | `path('...', view, name='...')` |
| `urlpatterns` | Lista `urlpatterns` completa |
| `include` | `include('app.urls')` |

> 💡 No memorices la lista: escribe las primeras letras (`ser`, `mod`, `blo`)
> y mira lo que ofrece el menú. Son ~360 snippets entre templates y Python.

---

## Templates de Django

### Detección de filetype

Neovim detecta `htmldjango` automáticamente cuando el archivo contiene
sintaxis de template (`{% ... %}`, `{{ ... }}`). Para verificar:

```vim
:set filetype?
```

Si un template queda como `html` plano (por ejemplo, uno que solo tiene HTML
todavía), fuérzalo:

```vim
:set filetype=htmldjango
```

### Qué está activo en un template

| Herramienta | Aporta |
|-------------|--------|
| **LSP `html`** | Autocompletado de tags, atributos, validación |
| **LSP `emmet_ls`** | Expansión de abreviaturas |
| **Snippets Django + HTML** | 168 snippets combinados |
| **Copilot** | Sugerencias de IA (`htmldjango` habilitado) |
| **Treesitter `htmldjango`** | Highlighting correcto de `{% %}` y `{{ }}` |
| **rainbow-delimiters** | Tags HTML coloreados por nivel de anidación |
| **colorizer** | Preview de colores CSS inline |

### Comentar en templates

`gcc` respeta el contexto gracias a `nvim-ts-context-commentstring`:

- Dentro de HTML → `<!-- ... -->`
- Dentro de un bloque Django → `{# ... #}`
- Dentro de `<script>` → `// ...`
- Dentro de `<style>` → `/* ... */`

---

## Emmet en templates

Escribe la abreviatura y acéptala desde el menú de cmp:

| Abreviatura | Genera |
|-------------|--------|
| `div.card` | `<div class="card"></div>` |
| `ul>li*3` | `<ul>` con 3 `<li>` |
| `div#main>p.text*2` | Div con id y 2 párrafos con clase |
| `a[href=#]` | `<a href="#"></a>` |
| `form>input:text+button` | Form con input y botón |

Funciona en `html`, `htmldjango`, `css`, `scss`, `javascript`, `javascriptreact`
y `typescriptreact`.

---

## Debugger

Debugger real con breakpoints, en vez de `print()`. Usa `debugpy` vía `nvim-dap-python`.

### Atajos

| Atajo | Acción |
|-------|--------|
| `Espacio+db` | Poner / quitar **breakpoint** |
| `Espacio+dc` | **Continuar** — o iniciar y elegir configuración |
| `Espacio+do` | **Step over** (siguiente línea) |
| `Espacio+di` | **Step into** (entrar a la función) |
| `Espacio+dx` | Terminar la sesión |
| `Espacio+du` | Toggle de la UI |

### Configuraciones disponibles

Al pulsar `Espacio+dc` sin sesión activa, se elige entre:

| Configuración | Qué hace |
|---------------|----------|
| **Django runserver** | Levanta `manage.py runserver --noreload` con el debugger adjunto |
| **Launch file** | Ejecuta el archivo actual |
| **Attach remote** | Se conecta a un debugpy que ya está escuchando |

### Workflow con Django

```
1. Espacio+db          → breakpoint en la vista que quieres inspeccionar
2. Espacio+dc          → elegir "Django runserver"
3. Hacer la request desde el navegador o curl
   → Neovim se pausa en tu breakpoint
4. Inspeccionar variables en el panel Scopes (izquierda)
5. Espacio+do / Espacio+di  → avanzar paso a paso
6. Espacio+dc          → continuar hasta el siguiente breakpoint
7. Espacio+dx          → terminar
```

> ⚠️ **`--noreload` es necesario**: el autoreload de Django reinicia el proceso
> y el debugger pierde el attach. La config ya lo incluye.

### Paneles de la UI

| Panel | Contenido |
|-------|-----------|
| **Scopes** | Variables locales y globales en el punto de pausa |
| **Breakpoints** | Todos los breakpoints activos |
| **Stacks** | Call stack — cómo se llegó hasta aquí |
| **Watches** | Expresiones que quieras vigilar |
| **REPL** | Consola Python en el contexto pausado |

Además, `nvim-dap-virtual-text` muestra el valor de cada variable **al lado de
su línea** mientras estás pausado.

### Debugging dentro de Docker

Requiere configuración extra de attach remoto. En el contenedor:

```python
# Al inicio de manage.py o settings.py
import debugpy
debugpy.listen(("0.0.0.0", 5678))
```

Expón el puerto en `docker-compose.yml` y agrega a
[`lua/plugins/debug.lua`](../lua/plugins/debug.lua):

```lua
table.insert(dap.configurations.python, {
  name = "Attach Docker",
  type = "python",
  request = "attach",
  connect = { host = "127.0.0.1", port = 5678 },
  pathMappings = {
    { localRoot = vim.fn.getcwd(), remoteRoot = "/app" },  -- ajusta remoteRoot
  },
})
```

---

## Tests con Neotest

Adaptador `neotest-python` con `pytest`, apuntando a `.venv/bin/python`.

### Atajos

| Atajo | Acción |
|-------|--------|
| `Espacio+nt` | Correr el test **bajo el cursor** |
| `Espacio+nf` | Correr todos los tests **del archivo** |
| `Espacio+ns` | Toggle del panel de resultados |
| `Espacio+no` | Ver el **output** del test fallido |

Los resultados aparecen inline: ✅ pasó, ❌ falló, junto a cada test.

### Workflow

```
1. Espacio+ff           → abrir el test_*.py
2. Cursor en un test
3. Espacio+nt           → correr solo ese test
4. Espacio+no           → si falla, ver el traceback completo
5. Espacio+ns           → panel con todos los resultados
```

### Desde la terminal

`Ctrl+´` abre la terminal integrada:

```bash
pytest                          # todos
pytest apps/mi_app/             # una app
pytest -k "nombre_del_test"     # por nombre
pytest -v                       # verbose
pytest --lf                     # solo los que fallaron la última vez
```

### Si usas el runner de Django en vez de pytest

Edita [`lua/plugins/testing.lua`](../lua/plugins/testing.lua):

```lua
require("neotest-python")({
  runner = "django",     -- en vez de "pytest"
  python = ".venv/bin/python",
})
```

---

## Formateo

| Filetype | Formatter | Instalación |
|----------|-----------|-------------|
| `python` | `ruff format` | `pip install ruff` (en el `.venv`) |
| `htmldjango` | `djlint` | `pip install djlint` |

`Espacio+cf` formatea. Como se resuelven desde el `PATH`, cada proyecto usa su
propia configuración (`pyproject.toml`, `.djlintrc`).

```toml
# pyproject.toml
[tool.ruff]
line-length = 100

[tool.djlint]
profile = "django"
indent = 4
```

Más detalles en **[lsp-and-completion.md](lsp-and-completion.md#formateo-con-conformnvim)**.

---

## Workflow típico

```bash
# 1. Entrar al proyecto con el venv activado
cd ~/Documents/mi-proyecto
source .venv/bin/activate
nvim

# 2. Marcar los archivos que vas a tocar (Harpoon)
Espacio+ff → models.py    → Espacio+a
Espacio+ff → views.py     → Espacio+a
Espacio+ff → serializers.py → Espacio+a
# Ahora saltas con Espacio+1 / 2 / 3

# 3. Escribir código
model                     # snippet de modelo
Espacio+ca                # auto-import de lo que falte
Tab                       # aceptar LSP / Copilot / snippet

# 4. Formatear y revisar
Espacio+cf                # ruff format
Espacio+xf                # errores del archivo actual

# 5. Levantar el servidor en un split
Ctrl+´
python manage.py runserver

# 6. Correr los tests
Espacio+nf

# 7. Si algo no cuadra, debugger en vez de prints
Espacio+db → Espacio+dc → "Django runserver"
```

Rutina completa del día a día en **[daily-routine.md](daily-routine.md)**.

---

## Comandos de Django frecuentes

Desde la terminal integrada (`Ctrl+´`):

```bash
# Migraciones
python manage.py makemigrations
python manage.py migrate
python manage.py showmigrations

# Shell y utilidades
python manage.py shell
python manage.py createsuperuser
python manage.py check
python manage.py collectstatic

# Con Docker
docker compose exec web python manage.py migrate
docker compose exec web python manage.py shell
```

---

[⬅️ Volver al README](../README.md) · [Git y GitHub ➡️](git-and-github.md)
