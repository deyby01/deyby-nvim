-- ==========================================
-- AI - GITHUB COPILOT
-- ==========================================
-- Suggestions show up INSIDE the nvim-cmp menu (via copilot-cmp), so they
-- don't fight with completion or get hidden behind the popup.

return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        -- Disabled: copilot-cmp is what renders the suggestions
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          python = true,
          javascript = true,
          typescript = true,
          javascriptreact = true,
          typescriptreact = true,
          html = true,
          htmldjango = true,     -- Django templates
          css = true,
          scss = true,
          lua = true,
          json = true,
          yaml = true,
          dockerfile = true,
          sh = true,
          -- Everything else off, so files like .env are never sent to Copilot
          ["*"] = false,
        },
      })
    end,
  },

  -- Copilot as an nvim-cmp source
  {
    "zbirenbaum/copilot-cmp",
    lazy = true,  -- loaded as an nvim-cmp dependency (InsertEnter)
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
