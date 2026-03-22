-- ==========================================
-- AUTOCOMPLETADO IA (SUPERMAVEN)
-- ==========================================

return {
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<Tab>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-j>",
        },
        ignore_filetypes = { "TelescopePrompt" },
        color = {
          suggestion_color = "#6272a4",  -- color gris/azulado para sugerencias
          cta_color = "#ff79c6",
        },
        log_level = "off",
        disable_inline_completion = false,
        disable_keymaps = false,
      })
    end,
  },
}
