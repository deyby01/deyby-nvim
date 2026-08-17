-- ==========================================
-- UI EXTRA
-- ==========================================

return {
  -- Noice: improved cmdline, messages and popups
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
  -- which-key: shows available keymaps as you type a prefix
  {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("which-key").setup({
      delay = 500,  -- popup appears after 500ms
      icons = {
        mappings = true,
      },
      spec = {
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Git hunks / Harpoon" },
        { "<leader>w", group = "Windows" },
        { "<leader>c", group = "Code / Conflicts" },
        { "<leader>d", group = "Debug" },
        { "<leader>n", group = "Tests" },
        { "<leader>s", group = "Session / Spectre" },
        { "<leader>x", group = "Diagnostics" },
        { "<leader>o", group = "Octo (GitHub)" },
        { "<leader>l", group = "Legendary / Live Server" },
        { "<leader>t", group = "Toggle" },
        { "<leader>m", group = "Markdown" },
      },
    })
  end,
  },
}
