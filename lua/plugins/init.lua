-- ==========================================
-- LAZY.NVIM - GESTOR DE PLUGINS
-- ==========================================

-- Instalar Lazy.nvim automáticamente
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

-- Cargar todos los plugins de los módulos
require("lazy").setup({
    -- Cargar plugins por categoría
    { import = "plugins.ui" },        -- Temas, lualine, colorizer
    { import = "plugins.editor" },    -- Telescope, NvimTree, Harpoon
    { import = "plugins.lsp" },       -- LSP, autocompletado
    { import = "plugins.git" },       -- Git plugins
    { import = "plugins.terminal" },  -- Terminal y tmux
    { import = "plugins.ai" },        -- Inteligencia artificial
    { import = "plugins.ui_extra" },  -- Plugins adicionales
    { import = "plugins.debug" },     -- Debug
}, {
  -- Configuración de Lazy
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
