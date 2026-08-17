# 🐍 Django, DRF and Templates

> Snippets, templates, debugger and tests for the Django stack.

**Related:** [`lua/plugins/lsp.lua`](../lua/plugins/lsp.lua) · [`lua/plugins/debug.lua`](../lua/plugins/debug.lua) · [`lua/plugins/testing.lua`](../lua/plugins/testing.lua)

---

## 📋 Contents

- [Snippets](#snippets)
- [Django templates](#django-templates)
- [Emmet in templates](#emmet-in-templates)
- [Debugger](#debugger)
- [Tests with Neotest](#tests-with-neotest)
- [Formatting](#formatting)
- [Typical workflow](#typical-workflow)
- [Frequent Django commands](#frequent-django-commands)

---

## Snippets

Provided by `friendly-snippets` and enabled via `filetype_extend`.
Type the prefix, find the **Snippet** entry in the menu and accept with `Enter`.
Move between placeholders with `Tab` / `Shift+Tab`.

### In templates (Django `.html`)

| Type | Expands to |
|------|------------|
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

### In Python — Models

| Type | Expands to |
|------|------------|
| `model` | A `models.Model` class with `Meta` and `__str__` |
| `char` / `text` / `int` | `CharField` / `TextField` / `IntegerField` |
| `fk` | `ForeignKey` with `on_delete` |
| `m2m` | `ManyToManyField` |
| `o2o` | `OneToOneField` |
| `datetime` | `DateTimeField` with `auto_now_add` |

### In Python — Forms and views

| Type | Expands to |
|------|------------|
| `form` | `forms.Form` |
| `modelform` | `forms.ModelForm` with `Meta` |
| `view` | Function-based view |
| `listview` | Class-based `ListView` |
| `detailview` | `DetailView` |
| `createview` / `updateview` | Write views |

### In Python — DRF

| Type | Expands to |
|------|------------|
| `serializer` | `serializers.Serializer` |
| `modelserializer` | `serializers.ModelSerializer` with `Meta` |
| `apiview` | `APIView` with HTTP methods |
| `viewset` | `ModelViewSet` |

### In Python — URLs

| Type | Expands to |
|------|------------|
| `path` | `path('...', view, name='...')` |
| `urlpatterns` | A complete `urlpatterns` list |
| `include` | `include('app.urls')` |

> 💡 Don't memorize the list: type the first few letters (`ser`, `mod`, `blo`)
> and look at what the menu offers. There are ~360 across templates and Python.

---

## Django templates

### Filetype detection

Neovim detects `htmldjango` automatically when the file contains template
syntax (`{% ... %}`, `{{ ... }}`). To check:

```vim
:set filetype?
```

If a template stays as plain `html` — for example one that only has HTML so
far — force it:

```vim
:set filetype=htmldjango
```

### What's active in a template

| Tool | What it brings |
|------|----------------|
| **`html` LSP** | Tag and attribute completion, validation |
| **`emmet_ls` LSP** | Abbreviation expansion |
| **Django + HTML snippets** | 168 combined snippets |
| **Copilot** | AI suggestions (`htmldjango` is enabled) |
| **Treesitter `htmldjango`** | Correct highlighting for `{% %}` and `{{ }}` |
| **rainbow-delimiters** | HTML tags colored by nesting level |
| **colorizer** | Inline CSS color previews |

### Commenting in templates

`gcc` respects the context thanks to `nvim-ts-context-commentstring`:

- Inside HTML → `<!-- ... -->`
- Inside a Django block → `{# ... #}`
- Inside `<script>` → `// ...`
- Inside `<style>` → `/* ... */`

---

## Emmet in templates

Type the abbreviation and accept it from the cmp menu:

| Abbreviation | Produces |
|--------------|----------|
| `div.card` | `<div class="card"></div>` |
| `ul>li*3` | A `<ul>` with three `<li>` |
| `div#main>p.text*2` | Div with an id and two classed paragraphs |
| `a[href=#]` | `<a href="#"></a>` |
| `form>input:text+button` | A form with an input and a button |

Works in `html`, `htmldjango`, `css`, `scss`, `javascript`, `javascriptreact`
and `typescriptreact`.

---

## Debugger

A real debugger with breakpoints, instead of `print()`. Uses `debugpy` via
`nvim-dap-python`.

### Shortcuts

| Shortcut | Action |
|----------|--------|
| `Space+db` | Toggle **breakpoint** |
| `Space+dc` | **Continue** — or start and pick a configuration |
| `Space+do` | **Step over** (next line) |
| `Space+di` | **Step into** (enter the function) |
| `Space+dx` | Terminate the session |
| `Space+du` | Toggle the UI |

### Available configurations

Pressing `Space+dc` with no active session lets you choose:

| Configuration | What it does |
|---------------|--------------|
| **Django runserver** | Runs `manage.py runserver --noreload` with the debugger attached |
| **Launch file** | Runs the current file |
| **Attach remote** | Connects to a debugpy already listening |

### Django workflow

```
1. Space+db          → breakpoint in the view you want to inspect
2. Space+dc          → choose "Django runserver"
3. Make the request from the browser or curl
   → Neovim pauses on your breakpoint
4. Inspect variables in the Scopes panel (left)
5. Space+do / Space+di  → step through
6. Space+dc          → continue to the next breakpoint
7. Space+dx          → finish
```

> ⚠️ **`--noreload` is required**: Django's autoreload restarts the process and
> the debugger loses its attachment. The config already includes it.

### UI panels

| Panel | Contents |
|-------|----------|
| **Scopes** | Local and global variables at the pause point |
| **Breakpoints** | All active breakpoints |
| **Stacks** | Call stack — how execution got here |
| **Watches** | Expressions you want to track |
| **REPL** | A Python console in the paused context |

On top of that, `nvim-dap-virtual-text` shows each variable's value **next to
its line** while you're paused.

### Debugging inside Docker

Needs extra remote-attach configuration. In the container:

```python
# At the top of manage.py or settings.py
import debugpy
debugpy.listen(("0.0.0.0", 5678))
```

Expose the port in `docker-compose.yml` and add this to
[`lua/plugins/debug.lua`](../lua/plugins/debug.lua):

```lua
table.insert(dap.configurations.python, {
  name = "Attach Docker",
  type = "python",
  request = "attach",
  connect = { host = "127.0.0.1", port = 5678 },
  pathMappings = {
    { localRoot = vim.fn.getcwd(), remoteRoot = "/app" },  -- adjust remoteRoot
  },
})
```

---

## Tests with Neotest

The `neotest-python` adapter running `pytest`, pointed at `.venv/bin/python`.

### Shortcuts

| Shortcut | Action |
|----------|--------|
| `Space+nt` | Run the test **under the cursor** |
| `Space+nf` | Run every test **in the file** |
| `Space+ns` | Toggle the results panel |
| `Space+no` | Show the **output** of a failing test |

Results appear inline: ✅ passed, ❌ failed, next to each test.

### Workflow

```
1. Space+ff           → open the test_*.py
2. Cursor on a test
3. Space+nt           → run just that test
4. Space+no           → if it fails, read the full traceback
5. Space+ns           → panel with every result
```

### From the terminal

`Ctrl+´` opens the integrated terminal:

```bash
pytest                          # everything
pytest apps/my_app/             # one app
pytest -k "test_name"           # by name
pytest -v                       # verbose
pytest --lf                     # only what failed last run
```

### If you use Django's runner instead of pytest

Edit [`lua/plugins/testing.lua`](../lua/plugins/testing.lua):

```lua
require("neotest-python")({
  runner = "django",     -- instead of "pytest"
  python = ".venv/bin/python",
})
```

---

## Formatting

| Filetype | Formatter | Install |
|----------|-----------|---------|
| `python` | `ruff format` | `pip install ruff` (inside the `.venv`) |
| `htmldjango` | `djlint` | `pip install djlint` |

`Space+cf` formats. Since they're resolved from `PATH`, each project uses its
own configuration (`pyproject.toml`, `.djlintrc`).

```toml
# pyproject.toml
[tool.ruff]
line-length = 100

[tool.djlint]
profile = "django"
indent = 4
```

More detail in **[lsp-and-completion.md](lsp-and-completion.md#formatting-with-conformnvim)**.

---

## Typical workflow

```bash
# 1. Enter the project with the venv active
cd ~/projects/my-project
source .venv/bin/activate
nvim

# 2. Mark the files you'll be touching (Harpoon)
Space+ff → models.py      → Space+a
Space+ff → views.py       → Space+a
Space+ff → serializers.py → Space+a
# Now jump with Space+1 / 2 / 3

# 3. Write code
model                     # model snippet
Space+ca                  # auto-import whatever is missing
Tab                       # accept LSP / Copilot / snippet

# 4. Format and review
Space+cf                  # ruff format
Space+xf                  # current file diagnostics

# 5. Start the server in a split
Ctrl+´
python manage.py runserver

# 6. Run the tests
Space+nf

# 7. If something's off, debugger instead of prints
Space+db → Space+dc → "Django runserver"
```

The full day-to-day routine is in **[daily-routine.md](daily-routine.md)**.

---

## Frequent Django commands

From the integrated terminal (`Ctrl+´`):

```bash
# Migrations
python manage.py makemigrations
python manage.py migrate
python manage.py showmigrations

# Shell and utilities
python manage.py shell
python manage.py createsuperuser
python manage.py check
python manage.py collectstatic

# With Docker
docker compose exec web python manage.py migrate
docker compose exec web python manage.py shell
```

---

[⬅️ Back to the README](../README.md) · [Git and GitHub ➡️](git-and-github.md)
