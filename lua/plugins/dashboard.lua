-- ==========================================
-- DASHBOARD (PANTALLA DE INICIO)
-- ==========================================
return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local icons = {
        files   = "\u{f07c} ",
        search  = "\u{f002} ",
        text    = "\u{f031} ",
        config  = "\u{f013} ",
        plugins = "\u{e7b2} ",
        quit    = "\u{f011} ",
      }

      -- Construir center con recent files funcionales
      local center = {
        {
          icon = icons.files,
          icon_hl = "DashboardIcon",
          desc = "Buscar archivo          ",
          desc_hl = "DashboardDesc",
          key = "f",
          key_hl = "DashboardKey",
          action = "Telescope find_files",
        },
        {
          icon = icons.search,
          icon_hl = "DashboardIcon",
          desc = "Abrir proyecto          ",
          desc_hl = "DashboardDesc",
          key = "r",
          key_hl = "DashboardKey",
          action = function()
            require("telescope.builtin").find_files({
              cwd = vim.fn.expand("~/Documents"),
              find_command = { "find", vim.fn.expand("~/Documents"), "-maxdepth", "1", "-type", "d" },
              prompt_title = "Abrir proyecto",
              attach_mappings = function(_, map)
                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")
                map("i", "<CR>", function(bufnr)
                  local selection = action_state.get_selected_entry()
                  actions.close(bufnr)
                  vim.cmd("cd " .. selection.value)
                  vim.cmd("NvimTreeOpen")
                end)
                return true
              end,
            })
          end,
        },
        {
          icon = icons.text,
          icon_hl = "DashboardIcon",
          desc = "Buscar texto            ",
          desc_hl = "DashboardDesc",
          key = "g",
          key_hl = "DashboardKey",
          action = "Telescope live_grep",
        },
        {
          icon = icons.config,
          icon_hl = "DashboardIcon",
          desc = "Configuración           ",
          desc_hl = "DashboardDesc",
          key = "c",
          key_hl = "DashboardKey",
          action = "edit ~/.config/nvim/init.lua",
        },
        {
          icon = icons.plugins,
          icon_hl = "DashboardIcon",
          desc = "Plugins                 ",
          desc_hl = "DashboardDesc",
          key = "p",
          key_hl = "DashboardKey",
          action = "Lazy",
        },
        {
          icon = icons.quit,
          icon_hl = "DashboardIcon",
          desc = "Salir                   ",
          desc_hl = "DashboardDesc",
          key = "q",
          key_hl = "DashboardKey",
          action = "quit",
        },
        -- Separador Recent Files
        {
          icon = " ",
          icon_hl = "DashboardIcon",
          desc = "━━━━━━━━━━━━  Recent Files  ━━━━━━━━━━━━",
          desc_hl = "DashboardSeparator",
          key = " ",
          key_hl = "DashboardKey",
          action = "",
        },
      }

      -- Agregar recent files con atajos funcionales
      local oldfiles = vim.v.oldfiles or {}
      for i = 1, math.min(5, #oldfiles) do
        local file = oldfiles[i]
        local short = vim.fn.fnamemodify(file, ":~")
        table.insert(center, {
          icon = "\u{f15b} ",
          icon_hl = "DashboardRecent",
          desc = short .. string.rep(" ", math.max(0, 45 - #short)),
          desc_hl = "DashboardDesc",
          key = tostring(i),
          key_hl = "DashboardKey",
          action = "edit " .. file,
        })
      end

      require("dashboard").setup({
        theme = "doom",
        hide = {
          statusline = true,
          tabline = true,
          winbar = true,
        },
        config = {
          key_format = " %s",
          header = {
            "",
            "",
            "",
            "",
            "",
            "",
            "  ██████╗ ███████╗██╗   ██╗██████╗ ██╗   ██╗      ██████╗ ███████╗██╗   ██╗",
            "  ██╔══██╗██╔════╝╚██╗ ██╔╝██╔══██╗╚██╗ ██╔╝      ██╔══██╗██╔════╝╚██╗ ██╔╝",
            "  ██║  ██║█████╗   ╚████╔╝ ██████╔╝ ╚████╔╝ █████╗██║  ██║█████╗   ╚████╔╝ ",
            "  ██║  ██║██╔══╝    ╚██╔╝  ██╔══██╗  ╚██╔╝  ╚════╝██║  ██║██╔══╝    ╚██╔╝  ",
            "  ██████╔╝███████╗   ██║   ██████╔╝   ██║         ██████╔╝███████╗   ██║   ",
            "  ╚═════╝ ╚══════╝   ╚═╝   ╚═════╝    ╚═╝         ╚═════╝ ╚══════╝   ╚═╝   ",
            "",
            "               Bienvenido de vuelta, deyby-dev               ",
            "",
            "",
          },
          center = center,
          footer = {
            "",
            "  nvim · deyby-dev · 2026",
            "",
          },
        },
      })

      vim.api.nvim_set_hl(0, "DashboardHeader",    { fg = "#bd93f9" })
      vim.api.nvim_set_hl(0, "DashboardIcon",      { fg = "#ff79c6" })
      vim.api.nvim_set_hl(0, "DashboardDesc",      { fg = "#f8f8f2" })
      vim.api.nvim_set_hl(0, "DashboardKey",       { fg = "#50fa7b" })
      vim.api.nvim_set_hl(0, "DashboardFooter",    { fg = "#6272a4" })
      vim.api.nvim_set_hl(0, "DashboardSeparator", { fg = "#6272a4" })
      vim.api.nvim_set_hl(0, "DashboardRecent",    { fg = "#8be9fd" })
    end,
  },
}
