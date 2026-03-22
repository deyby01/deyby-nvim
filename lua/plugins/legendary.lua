-- ==========================================
-- LEGENDARY (PALETA DE COMANDOS)
-- ==========================================

return {
    {
    "mrjones2014/legendary.nvim",
    version = "^2.1.0",
    lazy = false,
    dependencies = {
      "kkharji/sqlite.lua",
    },
    config = function()
      require("legendary").setup({
        extensions = {
          lazy_nvim = true,
          which_key = {
            auto_register = true,
          },
        },
        sort = {
          most_recent_first = true,
          user_items_first = true,
        },
      })

      -- Atajo principal
      vim.keymap.set("n", "<C-p>", ":Legendary<CR>", { desc = "Legendary: paleta de comandos" })
      vim.keymap.set("n", "<leader>lk", ":Legendary keymaps<CR>", { desc = "Legendary: ver atajos" })
      vim.keymap.set("n", "<leader>lc", ":Legendary commands<CR>", { desc = "Legendary: ver comandos" })
    end,
    },
}
