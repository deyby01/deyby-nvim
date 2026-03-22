-- ==========================================
-- UI EXTRA
-- ==========================================

return {
  -- Noice: UI mejorada
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
        },
        notify = {
          enabled = true,
        },
      })
    end,
  },
  -- Which-key: mostrar atajos
  {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("which-key").setup({
      delay = 500,  -- aparece después de 500ms
      icons = {
        mappings = true,
      },
      spec = {
        { "<leader>f", group = "Buscar" },
        { "<leader>g", group = "Git" },
        { "<leader>r", group = "Ejecutar/Compilar" },
        { "<leader>h", group = "Git hunks" },
        { "<leader>t", group = "Toggle" },
        { "<leader>m", group = "Markdown" },
      },
    })
  end,
  },
}
