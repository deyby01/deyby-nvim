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
    keys = {
      { "<leader>nt", ":Neotest run<CR>", silent = true, desc = "Neotest: correr test bajo cursor" },
      { "<leader>nf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Neotest: correr todos los tests del archivo" },
      { "<leader>ns", function() require("neotest").summary.toggle() end, desc = "Neotest: toggle panel de resultados" },
      { "<leader>no", function() require("neotest").output.open() end, desc = "Neotest: ver output del test" },
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
    end,
  },
}
