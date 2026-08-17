-- ==========================================
-- DASHBOARD (START SCREEN)
-- ==========================================

local user = require("config.user")

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

      -- Build the center menu, including working recent-file entries
      local center = {
        {
          icon = icons.files,
          icon_hl = "DashboardIcon",
          desc = "Find file               ",
          desc_hl = "DashboardDesc",
          key = "f",
          key_hl = "DashboardKey",
          action = "Telescope find_files",
        },
        {
          icon = icons.search,
          icon_hl = "DashboardIcon",
          desc = "Open project            ",
          desc_hl = "DashboardDesc",
          key = "r",
          key_hl = "DashboardKey",
          action = function()
            require("telescope.builtin").find_files({
              cwd = user.projects_path(),
              find_command = { "find", user.projects_path(), "-maxdepth", "1", "-type", "d" },
              prompt_title = "Open project",
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
          desc = "Search text             ",
          desc_hl = "DashboardDesc",
          key = "g",
          key_hl = "DashboardKey",
          action = "Telescope live_grep",
        },
        {
          icon = icons.config,
          icon_hl = "DashboardIcon",
          desc = "Configuration           ",
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
          desc = "Quit                    ",
          desc_hl = "DashboardDesc",
          key = "q",
          key_hl = "DashboardKey",
          action = "quit",
        },
        -- Recent files separator
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

      -- Add recent files with working shortcut keys
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

      -- Banner + greeting, both driven by lua/config/user.lua
      local header = { "", "", "", "", "", "" }
      for _, line in ipairs(user.dashboard_header) do
        table.insert(header, line)
      end
      table.insert(header, "")
      table.insert(header, "               Welcome back, " .. user.display_name())
      table.insert(header, "")
      table.insert(header, "")

      require("dashboard").setup({
        theme = "doom",
        hide = {
          statusline = true,
          tabline = true,
          winbar = true,
        },
        config = {
          key_format = " %s",
          header = header,
          center = center,
          footer = {
            "",
            "  nvim · " .. user.display_name(),
            "",
          },
        },
      })

      vim.api.nvim_set_hl(0, "DashboardHeader",    { fg = "#88C0D0" })
      vim.api.nvim_set_hl(0, "DashboardIcon",      { fg = "#81A1C1" })
      vim.api.nvim_set_hl(0, "DashboardDesc",      { fg = "#D8DEE9" })
      vim.api.nvim_set_hl(0, "DashboardKey",       { fg = "#A3BE8C" })
      vim.api.nvim_set_hl(0, "DashboardFooter",    { fg = "#4C566A" })
      vim.api.nvim_set_hl(0, "DashboardSeparator", { fg = "#4C566A" })
      vim.api.nvim_set_hl(0, "DashboardRecent",    { fg = "#8FBCBB" })
    end,
  },
}
