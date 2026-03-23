# 🚀 Daily Routine - deyby-dev

> Referencia rápida para el día a día de trabajo.
> Para comandos más detallados revisar `commands-and-workflow.md`

---

## 📋 Tabla de Contenidos

- [Inicio del Día](#-inicio-del-día)
- [Navegación y Edición Rápida](#-navegación-y-edición-rápida)
- [Git - Flujo Diario](#-git---flujo-diario)
- [Docker](#-docker)
- [Django](#-django)
- [Buscar y Reemplazar](#-buscar-y-reemplazar)
- [Mover y Editar Código](#-mover-y-editar-código)
- [Final del Día](#-final-del-día)

---

## ☀️ Inicio del Día

```bash
# 1. Entrar al proyecto
nombre-proyecto              # Abre el proyecto con venv activado y nvim

# 2. Revisar estado de git
Espacio+gs                 # Ver qué cambios hay

# 3. Traer últimos cambios de development
:Git pull origin development

# 4. Revisar PRs pendientes de review
Espacio+opr                # Listar PRs en GitHub
```

---

## 🧭 Navegación y Edición Rápida

### Moverse rápido en el archivo

| Atajo | Acción |
|-------|--------|
| `s` + 2 letras | Saltar a cualquier parte del archivo (Flash) ⭐ |
| `gg` | Ir al inicio del archivo |
| `G` | Ir al final del archivo |
| `Ctrl+d` | Bajar media página |
| `Ctrl+u` | Subir media página |
| `gd` | Ir a definición de función/clase ⭐ |
| `gr` | Ver dónde se usa una función/variable ⭐ |
| `K` | Ver documentación de lo que está bajo el cursor |

### Seleccionar y editar

| Atajo | Acción |
|-------|--------|
| `V` | Seleccionar línea completa |
| `Shift+v` + `j/k` | Seleccionar varias líneas |
| `>` | Indentar selección (un tab a la derecha) ⭐ |
| `<` | Quitar indentación (un tab a la izquierda) ⭐ |
| `.` | Repetir la última acción |
| `u` | Deshacer |
| `Ctrl+r` | Rehacer |

### Cortar, copiar, pegar

| Atajo | Acción |
|-------|--------|
| `yy` | Copiar línea actual |
| `dd` | Cortar línea actual |
| `3yy` | Copiar 3 líneas |
| `3dd` | Cortar 3 líneas |
| `p` | Pegar después |
| `P` | Pegar antes |
| `d + s (Flash)` | Cortar hasta donde saltas con Flash |

### Mover bloques de código

```bash
# Seleccionar líneas a mover
Shift+v                    # Entrar modo visual por líneas
j / k                      # Seleccionar las líneas
d                          # Cortar
# Ir a donde quieres pegar
p                          # Pegar

# Indentar múltiples líneas
Shift+v                    # Seleccionar
j / k                      # Extender selección
>                          # Indentar a la derecha
<                          # Indentar a la izquierda
# Tip: presiona . para repetir la indentación
```

---

## 🔀 Git - Flujo Diario

### Empezar una tarea nueva

```bash
# 1. Asegurarte de estar en development actualizado
:Git checkout development
:Git pull origin development

# 2. Crear tu rama
:Git checkout -b feature/nombre-de-la-tarea

# 3. Trabajar en el código...
```

### Durante el desarrollo

```bash
# Ver qué cambié
Espacio+gs                 # Git status completo
]c                         # Saltar al siguiente cambio
[c                         # Saltar al cambio anterior
Espacio+hp                 # Ver diff del cambio actual
Espacio+gw                 # Ver diff completo del working tree
```

### Commit y push

```bash
# Desde fugitive (Espacio+gs)
s                          # Stage archivo bajo cursor
u                          # Unstage archivo
=                          # Ver diff del archivo
cc                         # Hacer commit
# Escribir mensaje y guardar con Ctrl+s

# Push de tu rama
:Git push origin nombre-de-tu-rama
```

### Enviar PR

```bash
# Crear PR desde nvim
Espacio+opc                # Crear PR en GitHub
# O desde terminal
gh pr create --base development --title "título" --body "descripción"
```

### Cuando te asignan un PR para revisar

```bash
Espacio+opr                # Ver lista de PRs
# Enter para abrir el PR
Espacio+or                 # Iniciar review
# Navegar cambios con diffview
Espacio+gD                 # Ver diff con origin/development
# Cuando termines
:Octo review submit
```

### Resolver conflictos

```bash
# Cuando hay conflictos al hacer merge/rebase
Espacio+cn                 # Ir al siguiente conflicto
Espacio+co                 # Quedarse con nuestro cambio
Espacio+ct                 # Quedarse con el cambio entrante
Espacio+cb                 # Quedarse con ambos
Espacio+cl                 # Ver lista de todos los conflictos
```

---

## 🐳 Docker

### Comandos frecuentes en terminal integrada

```bash
# Ver contenedores corriendo
docker ps

# Reiniciar contenedor web (para cargar cambios)
docker-compose restart web

# Entrar al contenedor web
docker exec -it nombre_contenedor bash

# Ver logs del contenedor web
docker logs -f nombre_contenedor

# Levantar todos los servicios
docker-compose up -d

# Bajar todos los servicios
docker-compose down

# Ver logs en tiempo real
docker-compose logs -f web
```

### Con LazyDocker (más visual)

```bash
Espacio+ld                 # Abrir LazyDocker
# Desde ahí puedes reiniciar, ver logs, entrar al contenedor
```

---

## 🐍 Django

### Migraciones

```bash
# Entrar al contenedor primero
docker exec -it nombre_contenedor bash

# Crear migraciones
python manage.py makemigrations

# Aplicar migraciones
python manage.py migrate

# Ver migraciones pendientes
python manage.py showmigrations
```

### Shell y utilidades

```bash
# Shell de Django
python manage.py shell

# Crear superusuario
python manage.py createsuperuser

# Verificar errores del proyecto
python manage.py check

# Colectar archivos estáticos
python manage.py collectstatic
```

### Tests

```bash
# Correr todos los tests
pytest

# Correr tests de una app específica
pytest apps/nombre_app/

# Correr un test específico
pytest -k "nombre_del_test"

# Ver output detallado
pytest -v

# Desde nvim directamente
Espacio+nt                 # Correr test bajo cursor
Espacio+nf                 # Correr todos los tests del archivo
Espacio+ns                 # Ver panel de resultados
```

---

## 🔍 Buscar y Reemplazar

### Búsqueda rápida en el archivo

```bash
/texto                     # Buscar hacia adelante
?texto                     # Buscar hacia atrás
n                          # Siguiente coincidencia
N                          # Anterior coincidencia
*                          # Buscar palabra bajo cursor
```

### Reemplazar en el archivo actual

```bash
:%s/viejo/nuevo/g          # Reemplazar en todo el archivo
:%s/viejo/nuevo/gc         # Reemplazar con confirmación uno a uno
:s/viejo/nuevo/g           # Reemplazar solo en la línea actual
```

### Buscar y reemplazar en TODO el proyecto (Spectre)

```bash
Espacio+S                  # Abrir panel de Spectre
Espacio+sw                 # Buscar palabra bajo cursor en todo el proyecto
Espacio+sf                 # Buscar en archivo actual

# Dentro de Spectre:
# dd → excluir/incluir línea del reemplazo
# R  → aplicar todos los reemplazos
# Enter → ir al archivo de esa línea
```

### Buscar archivos y contenido (Telescope)

```bash
Espacio+ff                 # Buscar archivo por nombre ⭐
Espacio+fg                 # Buscar texto en todo el proyecto ⭐
Espacio+fb                 # Buscar entre buffers abiertos
Espacio+ft                 # Buscar TODOs del proyecto
```

---

## ✏️ Mover y Editar Código

### Operaciones frecuentes

```bash
# Duplicar línea
yy + p                     # Copiar y pegar línea

# Mover línea arriba/abajo
dd + k + p                 # Cortar, subir, pegar

# Borrar hasta el final de línea
D                          # Borra desde cursor hasta fin de línea

# Cambiar una palabra
ciw                        # Borra la palabra y entra a INSERT

# Cambiar hasta el final de línea
C                          # Borra hasta el final y entra a INSERT

# Borrar líneas vacías
:g/^$/d                    # Elimina todas las líneas vacías
```

### Comentar código

```bash
gcc                        # Comentar/descomentar línea actual ⭐
gc + selección visual      # Comentar/descomentar selección ⭐
```

### Surround (envolver con caracteres)

```bash
ysiw"                      # Rodear palabra con comillas ""
ysiw'                      # Rodear palabra con comillas ''
ysiw)                      # Rodear palabra con paréntesis ()
cs"'                       # Cambiar "" por ''
ds"                        # Eliminar las comillas
```

### Formatear código

```bash
Espacio+f                  # Formatear archivo completo con LSP ⭐
gg=G                       # Auto-indentar todo el archivo
==                         # Auto-indentar línea actual
```

### Errores y warnings

```bash
Espacio+xx                 # Ver todos los errores del proyecto ⭐
Espacio+xf                 # Ver errores del archivo actual
]d                         # Ir al siguiente error/warning
[d                         # Ir al error/warning anterior
Espacio+ca                 # Code actions (auto-fix, auto-import) ⭐
```

---

## 🌙 Final del Día

```bash
# 1. Revisar cambios pendientes
Espacio+gs

# 2. Hacer commit si hay cambios
s                          # Stage
cc                         # Commit

# 3. Push de tu rama
:Git push origin nombre-de-tu-rama

# 4. Si terminaste la tarea, crear/actualizar PR
Espacio+opc                # Crear PR
# O actualizar el existente desde GitHub

# 5. Guardar sesión
Espacio+ss                 # Guarda exactamente donde estás

# 6. Salir
:qa                        # Cerrar nvim
```

---

**💡 Tips del día a día:**
- Usa `Ctrl+p` para buscar cualquier comando que no recuerdes (Legendary)
- Usa `Espacio` y espera para ver todos los atajos disponibles (Which-key)
- Usa `TODO:` y `FIXME:` en el código para marcar pendientes y verlos con `Espacio+ft`
- Usa Harpoon (`Espacio+a`) para marcar los archivos que más tocas en cada tarea

---

*Última actualización: Marzo 2026*
