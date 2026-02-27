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

-- Búsqueda
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Clipboard (compartir con sistema)
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

-- Splits (ventanas)
vim.opt.splitright = true  -- Splits verticales a la derecha
vim.opt.splitbelow = true  -- Splits horizontales abajo

-- Autoguardado
vim.opt.autowrite = true
vim.opt.autowriteall = true
vim.opt.autoread = true

-- Historial de undo persistente
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Skip ts_context_commentstring module (deprecado en treesittier)
vim.g.skip_ts_context_commentstring_module = true
