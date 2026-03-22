-- ==========================================
-- DEBUGGER (DAP)
-- ==========================================

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
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

      -- Configuración para C++
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.cpp = {
        {
          name = "Ejecutar programa",
          type = "codelldb",
          request = "launch",
          program = "/tmp/programa",
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }

      dap.configurations.c = dap.configurations.cpp

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

      -- Atajos
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: toggle breakpoint" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: continuar" })
      vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: step over" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: step into" })
      vim.keymap.set("n", "<leader>dx", dap.terminate, { desc = "Debug: terminar" })
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: toggle UI" })
    end,
  },
}
