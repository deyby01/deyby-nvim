-- ==========================================
-- LEGENDARY (COMMAND PALETTE)
-- ==========================================

return {
    {
    "mrjones2014/legendary.nvim",
    version = "^2.1.0",
    event = "VeryLazy",
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

      -- Main shortcut
      vim.keymap.set("n", "<C-p>", ":Legendary<CR>", { desc = "Legendary: command palette" })
      vim.keymap.set("n", "<leader>lk", ":Legendary keymaps<CR>", { desc = "Legendary: browse keymaps" })
      vim.keymap.set("n", "<leader>lc", ":Legendary commands<CR>", { desc = "Legendary: browse commands" })
    end,
    },
}
