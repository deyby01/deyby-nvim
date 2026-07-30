-- ==========================================
-- IA - GITHUB COPILOT
-- ==========================================
-- Las sugerencias aparecen DENTRO del menú de nvim-cmp (via copilot-cmp),
-- así no pelean con el autocompletado ni ocultan el ghost text.

return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        -- Desactivados: copilot-cmp se encarga de mostrar las sugerencias
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          python = true,
          javascript = true,
          typescript = true,
          javascriptreact = true,
          typescriptreact = true,
          html = true,
          htmldjango = true,     -- Templates de Django
          css = true,
          scss = true,
          lua = true,
          json = true,
          yaml = true,
          dockerfile = true,
          sh = true,
          -- Todo lo demás apagado (evita mandar .env y similares a Copilot)
          ["*"] = false,
        },
      })
    end,
  },

  -- Copilot como fuente de nvim-cmp
  {
    "zbirenbaum/copilot-cmp",
    lazy = true,  -- Carga como dependencia de nvim-cmp (InsertEnter)
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
