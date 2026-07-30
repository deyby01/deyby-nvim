-- ==========================================
-- DEBUGGER (DAP) - PYTHON / DJANGO
-- ==========================================

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "mfussenegger/nvim-dap-python",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: toggle breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Debug: continuar" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Debug: step over" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Debug: step into" },
      { "<leader>dx", function() require("dap").terminate() end, desc = "Debug: terminar" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Debug: toggle UI" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- UI del debugger
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes",      size = 0.4 },
              { id = "breakpoints", size = 0.2 },
              { id = "stacks",      size = 0.2 },
              { id = "watches",     size = 0.2 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl",    size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
          },
        },
      })

      -- Texto virtual con valores de variables
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        commented = false,
      })

      -- Python: usa el debugpy instalado por Mason
      -- (dap-python detecta solo el .venv del proyecto para ejecutar tu código)
      local mason_debugpy = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      if vim.fn.executable(mason_debugpy) == 1 then
        require("dap-python").setup(mason_debugpy)
      else
        require("dap-python").setup("python3")
      end

      -- Configuración extra: Django runserver con debugger
      table.insert(dap.configurations.python, {
        name = "Django runserver",
        type = "python",
        request = "launch",
        program = vim.fn.getcwd() .. "/manage.py",
        args = { "runserver", "--noreload" },
        django = true,
        justMyCode = false,
      })

      -- Abrir/cerrar UI automáticamente
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}
