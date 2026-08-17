-- ==========================================
-- KEYMAPS
-- ==========================================
-- Only global keymaps live here. Plugin-specific ones are defined next to
-- their plugin in lua/plugins/, using lazy.nvim's `keys` field.

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ==========================================
-- NAVIGATION AND EDITING
-- ==========================================

-- Save the file
keymap("n", "<C-s>", ":w<CR>", opts)

-- Quit without saving
keymap("n", "<C-q>", ":q!<CR>", opts)

-- Move between splits (vim-tmux-navigator extends these to tmux panes)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- ==========================================
-- WINDOW MANAGEMENT (SPLITS) — <leader>w group
-- ==========================================

-- New split to the right
keymap("n", "<leader>wv", ":rightbelow vnew<CR>", { noremap = true, silent = true, desc = "Split right" })

-- New split below
keymap("n", "<leader>ws", ":belowright new<CR>", { noremap = true, silent = true, desc = "Split below" })

-- Close every split but this one
keymap("n", "<leader>wo", ":only<CR>", { noremap = true, silent = true, desc = "Only this split" })

-- Close the current split
keymap("n", "<leader>q", ":close<CR>", { noremap = true, silent = true, desc = "Close split" })

-- Resize NvimTree
keymap("n", "<leader>+", ":NvimTreeResize +5<CR>", { desc = "NvimTree: wider" })
keymap("n", "<leader>-", ":NvimTreeResize -5<CR>", { desc = "NvimTree: narrower" })

-- ==========================================
-- GIT
-- ==========================================

-- Git status
keymap("n", "<leader>gs", ":Git<CR>", opts)

-- Discard changes in the current file
keymap("n", "<leader>gu", ":Git restore %<CR>", { desc = "Git: discard changes in current file" })

-- Discard ALL changes
keymap("n", "<leader>gU", ":Git restore .<CR>", { desc = "Git: discard ALL changes" })

-- ==========================================
-- UTILITIES
-- ==========================================

-- Toggle colorizer (CSS colors)
keymap("n", "<leader>tc", ":ColorizerToggle<CR>", { desc = "Toggle colorizer" })

-- Quickly open the project's .env
keymap("n", "<leader>ve", function()
    vim.cmd("edit .env")
end, { desc = "Edit .env" })

-- Quick exit from INSERT mode (alternative to Esc)
keymap('i', 'jk', '<Esc>', opts)
keymap('i', 'kj', '<Esc>', opts)
