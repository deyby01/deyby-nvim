-- ==========================================
-- LAZY.NVIM - PLUGIN MANAGER
-- ==========================================

-- Bootstrap lazy.nvim automatically
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load every plugin module
require("lazy").setup({
    -- Plugins grouped by category
    { import = "plugins.ui" },        -- theme, lualine, colorizer
    { import = "plugins.editor" },    -- Telescope, NvimTree, Harpoon, Treesitter
    { import = "plugins.lsp" },       -- LSP, completion, formatting
    { import = "plugins.git" },       -- Fugitive, GitSigns, Diffview, Octo
    { import = "plugins.terminal" },  -- terminal, LazyDocker, Live Server, tmux
    { import = "plugins.ai" },        -- GitHub Copilot
    { import = "plugins.ui_extra" },  -- Noice, which-key
    { import = "plugins.debug" },     -- DAP debugger
    { import = "plugins.dashboard" }, -- start screen
    { import = "plugins.session" },   -- auto-session
    { import = "plugins.testing" },   -- Neotest
    { import = "plugins.legendary" }, -- command palette
}, {
  -- lazy.nvim settings
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      -- Legacy vim plugins we don't use
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "netrwPlugin",
      },
    },
  },
})
