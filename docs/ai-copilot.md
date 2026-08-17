# 🤖 AI — GitHub Copilot

> Copilot integrated **inside the completion menu**, not as separate ghost text.

**Plugins:** [`copilot.lua`](https://github.com/zbirenbaum/copilot.lua) + [`copilot-cmp`](https://github.com/zbirenbaum/copilot-cmp)
**Config file:** [`lua/plugins/ai.lua`](../lua/plugins/ai.lua)

---

## 📋 Contents

- [How it works](#how-it-works)
- [Shortcuts](#shortcuts)
- [Initial setup](#initial-setup)
- [Enabled filetypes](#enabled-filetypes)
- [Why it's configured this way](#why-its-configured-this-way)
- [Useful commands](#useful-commands)
- [Common problems](#common-problems)
- [AI alternatives](#ai-alternatives)

---

## How it works

Copilot suggestions appear as one more entry in the `nvim-cmp` menu, marked
with the **** icon, next to the LSP results and snippets:

```
┌─────────────────────────────────────┐
│  get_queryset          Method  LSP  │
│   def get_queryset(self):...       │  ← Copilot
│ 󰩫 serializer            Snippet     │
│  queryset             Text        │
└─────────────────────────────────────┘
```

**The upside:** one list, one key. No need to remember whether you accept with
`Tab` (cmp) or `Ctrl+a` (Copilot ghost text), and no suggestions covering each other.

---

## Shortcuts

They're **the same completion keys** — nothing extra to memorize:

| Shortcut | Action |
|----------|--------|
| `Ctrl+Space` | Open the menu manually |
| `Tab` | Next entry (LSP / Copilot / snippet) |
| `Shift+Tab` | Previous entry |
| `Enter` | Accept the selected entry |
| `Ctrl+e` | Close the menu |
| `Ctrl+f` / `Ctrl+b` | Scroll the suggestion's documentation |

> 💡 `Enter` is configured with `select = false`: if you haven't picked
> anything with `Tab`, it inserts a normal newline. It never accepts a
> suggestion by accident.

---

## Initial setup

Requires an **active GitHub Copilot subscription**.

```vim
:Copilot auth
```

1. A code and a URL are shown
2. Open the URL, paste the code, authorize
3. Return to Neovim

```vim
:Copilot status
```

The session is stored in `~/.config/github-copilot/`, so this is a one-time step.

> ⚠️ **Copilot requires Node.js 22+.** If you see
> `Node.js version 22 or newer required`, your shell is resolving an older
> Node — see [troubleshooting.md](troubleshooting.md#copilot).

---

## Enabled filetypes

Copilot is active **only** on the working stack. Everything else is
deliberately off via `["*"] = false`:

| Enabled | |
|---|---|
| ✅ `python` | ✅ `javascript` / `typescript` |
| ✅ `javascriptreact` / `typescriptreact` | ✅ `html` / `htmldjango` |
| ✅ `css` / `scss` | ✅ `lua` |
| ✅ `json` / `yaml` | ✅ `dockerfile` / `sh` |

### 🔒 Why the list is closed

With `["*"] = false`, Copilot **never sends** the contents of files outside the
list. That includes `.env`, `.pem`, `secrets.yaml`, database dumps and anything
it doesn't recognize. This is a deliberate safety decision: buffer content is
transmitted to GitHub's servers to generate the suggestion.

### Adding a filetype

Edit [`lua/plugins/ai.lua`](../lua/plugins/ai.lua):

```lua
filetypes = {
  python = true,
  go = true,        -- ← new
  ["*"] = false,
}
```

To find an open file's filetype:

```vim
:set filetype?
```

---

## Why it's configured this way

The reasoning behind the defaults, in case you want to change them:

### `suggestion = { enabled = false }` and `panel = { enabled = false }`

Copilot's native ghost text is **disabled**. With `nvim-cmp` open — which is
almost always while typing — ghost text sits behind the popup and the two
suggestions fight each other. `copilot-cmp` solves this by moving everything
into the menu.

### Vim keys reclaimed

The previous setup mapped suggestions to `<C-a>`, `<C-w>`, `<C-l>`, `<C-n>`
and `<C-p>`, which are **native Vim keys**:

| Key | Original behaviour it shadowed |
|-----|-------------------------------|
| `Ctrl+w` | Delete previous word (in insert mode) |
| `Ctrl+n` / `Ctrl+p` | Native keyword completion |
| `Ctrl+a` | Insert previously inserted text |

With `copilot-cmp` none of them are needed, so they're free again.

### `lazy = true`

`copilot-cmp` loads as a dependency of `nvim-cmp` (on `InsertEnter`), not at
startup. Copilot only starts once you begin typing.

---

## Useful commands

| Command | Action |
|---------|--------|
| `:Copilot status` | Connection state and current filetype |
| `:Copilot auth` | Authenticate (first time) |
| `:Copilot signout` | Sign out |
| `:Copilot disable` | Disable for this session |
| `:Copilot enable` | Re-enable |

---

## Common problems

### No Copilot suggestions

```vim
" 1. Authenticated?
:Copilot status

" 2. Is the filetype enabled?
:set filetype?
" If it isn't in ai.lua's list, add it

" 3. Did the plugin load? (it loads on InsertEnter)
:Lazy
" copilot.lua should show as loaded after entering insert mode
```

### `Node.js version 22 or newer required`

Your shell is resolving an old Node. Check with `which node` and
`node --version`; if it points at `/usr/bin/node`, make sure nvm is loaded in
your shell config — details in [troubleshooting.md](troubleshooting.md#copilot).

### Suggestions are slow

Normal on large files: Copilot has to send context and wait for a response.
The LSP and snippets appear first because they're local.

### I want the classic ghost text back

In [`lua/plugins/ai.lua`](../lua/plugins/ai.lua), change:

```lua
suggestion = {
  enabled = true,
  auto_trigger = true,
  keymap = { accept = "<M-l>" },  -- use Alt, not Ctrl, to avoid shadowing Vim
},
```

And remove `copilot` from cmp's `sources` in [`lua/plugins/lsp.lua`](../lua/plugins/lsp.lua).

---

## AI alternatives

If you don't have a Copilot subscription, these plugins fit the same setup:

| Plugin | Notes |
|--------|-------|
| [`supermaven-nvim`](https://github.com/supermaven-inc/supermaven-nvim) | Free tier, very fast |
| [`codeium.nvim`](https://github.com/Exafunction/codeium.nvim) | Free for individual use |
| [`minuet-ai.nvim`](https://github.com/milanglacier/minuet-ai.nvim) | Bring your own API key (Claude, OpenAI, local models) |

All of them provide an `nvim-cmp` source, so the integration pattern is identical.

---

[⬅️ Back to the README](../README.md) · [LSP and completion ➡️](lsp-and-completion.md)
