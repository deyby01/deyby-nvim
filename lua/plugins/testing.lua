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
      { "<leader>nt", ":Neotest run<CR>", silent = true, desc = "Neotest: run nearest test" },
      { "<leader>nf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Neotest: run all tests in file" },
      { "<leader>ns", function() require("neotest").summary.toggle() end, desc = "Neotest: toggle results panel" },
      { "<leader>no", function() require("neotest").output.open() end, desc = "Neotest: show test output" },
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
