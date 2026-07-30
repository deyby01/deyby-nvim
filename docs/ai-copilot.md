# 🤖 IA — GitHub Copilot

> Copilot integrado **dentro del menú de autocompletado**, no como texto fantasma aparte.

**Plugins:** [`copilot.lua`](https://github.com/zbirenbaum/copilot.lua) + [`copilot-cmp`](https://github.com/zbirenbaum/copilot-cmp)
**Archivo de config:** [`lua/plugins/ai.lua`](../lua/plugins/ai.lua)

---

## 📋 Contenido

- [Cómo funciona](#cómo-funciona)
- [Atajos](#atajos)
- [Configuración inicial](#configuración-inicial)
- [Filetypes habilitados](#filetypes-habilitados)
- [Por qué esta configuración](#por-qué-esta-configuración)
- [Comandos útiles](#comandos-útiles)
- [Problemas comunes](#problemas-comunes)

---

## Cómo funciona

Las sugerencias de Copilot aparecen como una entrada más en el menú de
`nvim-cmp`, marcadas con el icono ****, junto a las del LSP y los snippets:

```
┌─────────────────────────────────────┐
│  get_queryset          Method  LSP  │
│   def get_queryset(self):...       │  ← Copilot
│ 󰩫 serializer            Snippet     │
│  queryset             Text        │
└─────────────────────────────────────┘
```

**Ventaja:** una sola lista, una sola tecla. No hay que recordar si aceptas
con `Tab` (cmp) o con `Ctrl+a` (ghost text de Copilot), ni pelear con
sugerencias que se tapan entre sí.

---

## Atajos

Son los **mismos del autocompletado**, no hay teclas extra que memorizar:

| Atajo | Acción |
|-------|--------|
| `Ctrl+Space` | Abrir el menú manualmente |
| `Tab` | Siguiente opción (LSP / Copilot / snippet) |
| `Shift+Tab` | Opción anterior |
| `Enter` | Aceptar la opción seleccionada |
| `Ctrl+e` | Cerrar el menú |
| `Ctrl+f` / `Ctrl+b` | Scroll en la documentación de la sugerencia |

> 💡 `Enter` está configurado con `select = false`: si no seleccionaste nada
> con `Tab`, hace un salto de línea normal. No acepta sugerencias por accidente.

---

## Configuración inicial

Requiere una **suscripción activa de GitHub Copilot**.

```vim
:Copilot auth
```

1. Se muestra un código y una URL
2. Abre la URL, pega el código, autoriza
3. Vuelve a Neovim

```vim
:Copilot status
```

La sesión queda guardada en `~/.config/github-copilot/`, así que solo se hace una vez.

---

## Filetypes habilitados

Copilot está activo **solo** en el stack de trabajo. Todo lo demás está
apagado a propósito con `["*"] = false`:

| Habilitado | |
|---|---|
| ✅ `python` | ✅ `javascript` / `typescript` |
| ✅ `javascriptreact` / `typescriptreact` | ✅ `html` / `htmldjango` |
| ✅ `css` / `scss` | ✅ `lua` |
| ✅ `json` / `yaml` | ✅ `dockerfile` / `sh` |

### 🔒 Por qué la lista es cerrada

Con `["*"] = false`, Copilot **no envía** el contenido de archivos que no
estén en la lista. Eso incluye `.env`, `.pem`, `secrets.yaml`, dumps de base
de datos y cualquier cosa que no reconozca. Es una decisión de seguridad
deliberada: el contenido del buffer viaja a los servidores de GitHub para
generar la sugerencia.

### Agregar un filetype

Edita [`lua/plugins/ai.lua`](../lua/plugins/ai.lua):

```lua
filetypes = {
  python = true,
  go = true,        -- ← nuevo
  ["*"] = false,
}
```

Para saber el filetype de un archivo abierto:

```vim
:set filetype?
```

---

## Por qué esta configuración

Detalles de las decisiones, por si quieres cambiarlas:

### `suggestion = { enabled = false }` y `panel = { enabled = false }`

El ghost text nativo de Copilot está **desactivado**. Con `nvim-cmp` abierto
(que es casi siempre al escribir), el ghost text queda oculto detrás del menú
y las sugerencias se pisan. `copilot-cmp` resuelve esto llevando todo al menú.

### Teclas de Vim recuperadas

La configuración anterior mapeaba las sugerencias a `<C-a>`, `<C-w>`, `<C-l>`,
`<C-n>`, `<C-p>`, que son teclas **nativas de Vim**:

| Tecla | Función original que se pisaba |
|-------|-------------------------------|
| `Ctrl+w` | Borrar palabra anterior (en insert) |
| `Ctrl+n` / `Ctrl+p` | Autocompletado de palabras nativo |
| `Ctrl+a` | Insertar el último texto insertado |

Al usar `copilot-cmp` no se necesita ninguna, así que quedan libres.

### `lazy = true`

`copilot-cmp` carga como dependencia de `nvim-cmp` (evento `InsertEnter`), no
al arrancar. Copilot solo se inicia cuando empiezas a escribir.

---

## Comandos útiles

| Comando | Acción |
|---------|--------|
| `:Copilot status` | Estado de la conexión y del filetype actual |
| `:Copilot auth` | Autenticar (primera vez) |
| `:Copilot signout` | Cerrar sesión |
| `:Copilot disable` | Desactivar temporalmente en la sesión |
| `:Copilot enable` | Reactivar |

---

## Problemas comunes

### No aparecen sugerencias de Copilot

```vim
" 1. ¿Está autenticado?
:Copilot status

" 2. ¿El filetype está habilitado?
:set filetype?
" Si no está en la lista de ai.lua, agrégalo

" 3. ¿Cargó el plugin? (carga en InsertEnter)
:Lazy
" copilot.lua debe aparecer como cargado tras entrar a modo insert
```

### Las sugerencias tardan

Normal en archivos grandes: Copilot necesita mandar contexto y esperar
respuesta. El LSP y los snippets aparecen antes porque son locales.

### Quiero volver al ghost text clásico

En [`lua/plugins/ai.lua`](../lua/plugins/ai.lua), cambia:

```lua
suggestion = {
  enabled = true,
  auto_trigger = true,
  keymap = { accept = "<M-l>" },  -- usa Alt, no Ctrl, para no pisar Vim
},
```

Y quita `copilot` de las `sources` de cmp en [`lua/plugins/lsp.lua`](../lua/plugins/lsp.lua).

---

## Alternativas de IA

Si no tienes suscripción de Copilot, plugins compatibles con esta config:

| Plugin | Notas |
|--------|-------|
| [`supermaven-nvim`](https://github.com/supermaven-inc/supermaven-nvim) | Tier gratuito, muy rápido |
| [`codeium.nvim`](https://github.com/Exafunction/codeium.nvim) | Gratis para uso individual |
| [`minuet-ai.nvim`](https://github.com/milanglacier/minuet-ai.nvim) | Usa tu propia API key (Claude, OpenAI, local) |

Todos tienen fuente para `nvim-cmp`, así que el patrón de integración es el mismo.

---

[⬅️ Volver al README](../README.md) · [LSP y autocompletado ➡️](lsp-and-completion.md)
