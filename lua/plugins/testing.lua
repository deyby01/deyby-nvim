-- ==========================================
-- TESTING (NEOTEST)
-- ==========================================

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            runner = "pytest",
            python = ".venv/bin/python",
          }),
        },
      })

      -- Atajos
      vim.keymap.set("n", "<leader>nt", ":Neotest run<CR>", { desc = "Neotest: correr test bajo cursor" })
      vim.keymap.set("n", "<leader>nf", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Neotest: correr todos los tests del archivo" })
      vim.keymap.set("n", "<leader>ns", function() require("neotest").summary.toggle() end, { desc = "Neotest: toggle panel de resultados" })
      vim.keymap.set("n", "<leader>no", function() require("neotest").output.open() end, { desc = "Neotest: ver output del test" })
    end,
  },
}
