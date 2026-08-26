-- ==========================================
-- HTTP CLIENT (KULALA) - REST / DRF APIs
-- ==========================================
-- Postman replacement: you write plain-text .http files next to your code,
-- version them with git, and send the requests without leaving nvim.
--
-- A request is just:
--   GET http://127.0.0.1:8000/api/products/
--   Authorization: Token {{token}}
--
-- Variables like {{token}} come from an http-client.env.json file placed
-- next to the .http file (see docs/rest-client.md).

return {
  {
    "mistweaverco/kulala.nvim",

    -- Loaded on .http/.rest files only.
    --
    -- Upstream also suggests "javascript" and "lua" here, for the external
    -- pre/post-request scripts (*.http.js, *.http.lua). That would load the
    -- plugin on EVERY .js/.ts/.lua file you open, which for this config means
    -- every React component and every file in ~/.config/nvim. Not worth it
    -- until you actually write scripted requests.
    ft = { "http", "rest" },

    -- Kulala registers SessionLoadPost/VimLeavePre hooks to persist its
    -- request history. auto-session restores before any .http file is open,
    -- so without this event the hooks would never be registered in time.
    event = { "SessionLoadPost", "VimLeavePre" },

    -- Keymaps in `keys`, per the golden rule: defined here they exist before
    -- the plugin loads, and pressing one is what triggers the load.
    keys = {
      -- Running requests
      { "<leader>Rs", function() require("kulala").run() end, mode = { "n", "v" }, desc = "Kulala: send request under cursor" },
      { "<leader>Ra", function() require("kulala").run_all() end, mode = { "n", "v" }, desc = "Kulala: send all requests in file" },
      { "<leader>Rr", function() require("kulala").replay() end, desc = "Kulala: replay last request" },

      -- Windows
      { "<leader>Ro", function() require("kulala").open() end, desc = "Kulala: open response window" },
      { "<leader>Rq", function() require("kulala").close() end, desc = "Kulala: close response window" },
      { "<leader>Rt", function() require("kulala").toggle_view() end, desc = "Kulala: toggle headers/body" },
      { "<leader>Rb", function() require("kulala").scratchpad() end, desc = "Kulala: scratchpad (throwaway request)" },

      -- Navigating a file with several requests
      { "<leader>Rf", function() require("kulala").search() end, desc = "Kulala: find request" },
      { "<leader>Rn", function() require("kulala").jump_next() end, desc = "Kulala: next request" },
      { "<leader>Rp", function() require("kulala").jump_prev() end, desc = "Kulala: previous request" },

      -- Environments (dev / staging / prod from http-client.env.json)
      { "<leader>Re", function() require("kulala").set_selected_env() end, desc = "Kulala: select environment" },

      -- Interop with curl and the browser
      { "<leader>Rc", function() require("kulala").copy() end, desc = "Kulala: copy request as cURL" },
      { "<leader>RC", function() require("kulala").from_curl() end, desc = "Kulala: paste cURL as request" },
      { "<leader>Ri", function() require("kulala").inspect() end, desc = "Kulala: inspect resolved request" },

      -- Session state (cookies set by Django login, {{vars}} from scripts)
      { "<leader>Rj", function() require("kulala").open_cookies_jar() end, desc = "Kulala: open cookies jar" },
      { "<leader>Rx", function() require("kulala").scripts_clear_global() end, desc = "Kulala: clear global variables" },
    },

    opts = {
      -- Environment named in http-client.env.json to use when none is picked
      default_env = "dev",

      -- "b": the selected environment is per-buffer, so one .http file can sit
      -- on local while another points at staging
      environment_scope = "b",

      ui = {
        -- Response opens in a vertical split to the right, matching splitright
        display_mode = "split",
        split_direction = "vertical",

        -- Start on the response body (the JSON DRF returns), not the headers
        default_view = "body",

        -- Tabs across the top of the response window
        winbar = true,
        default_winbar_panes = { "body", "headers", "verbose", "script_output", "report" },
      },

      -- Pretty-print responses so DRF's JSON is readable
      response_format = {
        indent = 2,
      },

      -- Built-in LSP: completion for HTTP methods, headers and {{variables}}
      lsp = {
        enable = true,
        filetypes = { "http", "rest" },
      },

      -- Restore request history when auto-session restores the workspace.
      -- Requires "globals" in sessionoptions (set in lua/config/options.lua).
      session = {
        restore = true,
      },

      -- Global keymaps are defined in `keys` above, not by the plugin
      global_keymaps = false,

      -- Keymaps INSIDE the response window. Kulala defaults these to
      -- <C-h>/<C-l>, which would shadow the split/tmux navigation from
      -- lua/config/keymaps.lua. Tab cycles the panes instead.
      kulala_keymaps = {
        ["Previous tab"] = { "<S-Tab>", function() require("kulala.ui").show_previous_tab() end },
        ["Next tab"] = { "<Tab>", function() require("kulala.ui").show_next_tab() end },
      },
    },
  },
}
