-- ==========================================
-- Neovim Configuration
-- ==========================================
-- Modular Neovim setup for Python/Django, JS/TS/React, Docker and nginx.
--
-- Start here:
--   lua/config/user.lua  -- the only file you need to edit after cloning
--
-- Layout:
--   lua/config/   options, keymaps, autocmds
--   lua/plugins/  one file per category (ui, editor, lsp, git, ...)
-- ==========================================

-- Basic options
require("config.options")

-- Keymaps
require("config.keymaps")

-- Autocommands
require("config.autocmds")

-- Plugins (lazy.nvim bootstrap + imports)
require("plugins")
