-- ==========================================
-- BASIC VIM OPTIONS
-- ==========================================

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Interface
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"     -- always show the sign column (gitsigns won't shift text)
vim.opt.cursorline = true      -- highlight the current line
vim.opt.scrolloff = 8          -- keep context around the cursor when scrolling
vim.opt.laststatus = 3         -- single global statusline
vim.opt.splitkeep = "screen"   -- text doesn't jump when opening splits

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Share the clipboard with the system
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

-- Splits
vim.opt.splitright = true  -- vertical splits open to the right
vim.opt.splitbelow = true  -- horizontal splits open below

-- Reload files changed outside of Neovim
vim.opt.autoread = true

-- Ask instead of failing when quitting with unsaved changes
vim.opt.confirm = true

-- Mouse support
vim.opt.mouse = "a"

-- Response times
vim.opt.updatetime = 250   -- snappier LSP/gitsigns (default: 4000ms)
vim.opt.timeoutlen = 300   -- key prefixes resolve faster (default: 1000ms)

-- Persistent undo history
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- Let sessions store global variables, so Kulala can restore its request
-- history when auto-session reopens a project. Remove "globals" if sessions
-- ever start misbehaving; only Kulala's history depends on it.
vim.opt.sessionoptions:append("globals")

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Skip the ts_context_commentstring module (deprecated in treesitter)
vim.g.skip_ts_context_commentstring_module = true

-- ==========================================
-- PER-FILETYPE INDENTATION
-- ==========================================

-- Force 4 spaces for HTML and related filetypes
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "html", "htmldjango", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.expandtab = true
    end,
})
