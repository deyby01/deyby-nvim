-- ==========================================
-- OPCIONES BÁSICAS DE VIM
-- ==========================================

-- Números de línea
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentación
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Interfaz
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"     -- Columna de signos siempre visible (gitsigns no desplaza el texto)
vim.opt.cursorline = true      -- Resaltar línea actual
vim.opt.scrolloff = 8          -- Contexto al hacer scroll
vim.opt.laststatus = 3         -- Una sola statusline global
vim.opt.splitkeep = "screen"   -- El texto no salta al abrir splits

-- Búsqueda
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Clipboard (compartir con sistema)
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

-- Splits (ventanas)
vim.opt.splitright = true  -- Splits verticales a la derecha
vim.opt.splitbelow = true  -- Splits horizontales abajo

-- Recargar archivos cambiados externamente (Claude Code, etc)
vim.opt.autoread = true

-- Confirmación en vez de error al salir con cambios sin guardar
vim.opt.confirm = true

-- Ratón habilitado
vim.opt.mouse = "a"

-- Tiempos de respuesta
vim.opt.updatetime = 250   -- LSP/gitsigns más reactivos (default: 4000ms)
vim.opt.timeoutlen = 300   -- Los prefijos de atajos responden antes (default: 1000ms)

-- Historial de undo persistente
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Skip ts_context_commentstring module (deprecado en treesittier)
vim.g.skip_ts_context_commentstring_module = true

-- ==========================================
-- INDENTACIÓN POR TIPO DE ARCHIVO
-- ==========================================

-- Forzar 4 espacios para HTML y archivos relacionados
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "html", "htmldjango", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.expandtab = true
    end,
})
