-- ==========================================
-- GIT PLUGINS
-- ==========================================

local user = require("config.user")
local base = user.git_base_branch

return {
  -- Vim Fugitive: Git commands and status panel
  {
    'tpope/vim-fugitive',
    cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite" },
  },

  -- GitSigns: per-line git changes
  {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require('gitsigns').setup({
            signs = {
                add          = { text = '│' },
                change       = { text = '│' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signcolumn = true,
            numhl      = false,
            linehl     = false,
            word_diff  = false,
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol',
                delay = 500,
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                -- Navigate between hunks
                vim.keymap.set('n', ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, {expr=true, buffer = bufnr, desc = "Next hunk"})

                vim.keymap.set('n', '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, {expr=true, buffer = bufnr, desc = "Previous hunk"})

                -- Hunk actions
                vim.keymap.set('n', '<leader>hs', gs.stage_hunk, {buffer = bufnr, desc = "Stage hunk"})
                vim.keymap.set('n', '<leader>hr', gs.reset_hunk, {buffer = bufnr, desc = "Reset hunk"})
                vim.keymap.set('n', '<leader>hp', gs.preview_hunk, {buffer = bufnr, desc = "Preview hunk"})
                vim.keymap.set('n', '<leader>hb', function() gs.blame_line{full=true} end, {buffer = bufnr, desc = "Blame line"})

                -- Whole-file diff
                vim.keymap.set('n', '<leader>hd', function()
                    gs.diffthis()
                end, {buffer = bufnr, desc = "Diff whole file"})

                -- Toggle inline blame
                vim.keymap.set('n', '<leader>tb', function()
                    gs.toggle_current_line_blame()
                end, {buffer = bufnr, desc = "Toggle blame"})
            end
        })
    end
  },
  -- Diffview: compare branches and browse file history
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    -- Keymaps live in `keys` (not in `config`) so they exist even before the
    -- plugin has loaded. The base branch comes from lua/config/user.lua.
    keys = {
      { "<leader>gd", ":DiffviewOpen " .. base .. "<CR>", desc = "Git: diff against " .. base },
      { "<leader>gD", ":DiffviewOpen origin/" .. base .. "<CR>", desc = "Git: diff against origin/" .. base },
      { "<leader>gw", ":DiffviewOpen<CR>", desc = "Git: diff working tree" },
      { "<leader>gq", ":DiffviewClose<CR>", desc = "Git: close Diffview" },
      { "<leader>gh", ":DiffviewFileHistory %<CR>", desc = "Git: current file history" },
      { "<leader>gf", ":DiffviewFileHistory " .. base .. "..HEAD<CR>", desc = "Git: commits since " .. base },
    },
    config = function()
        require("diffview").setup({
            enhanced_diff_hl = true,
            view = {
                default = {
                    layout = "diff2_horizontal",
                    winbar_info = true,  -- show branch names in the winbar
                },
            },
            file_panel = {
                win_config = {
                    width = 40,  -- wider file panel
                },
            },
            file_history_panel = {
                win_config = {
                    width = 40,
                },
            },
            hooks = {
                -- Make it obvious which branch each side is
                diff_buf_read = function()
                    vim.opt_local.number = true
                    vim.opt_local.relativenumber = true
                end,
            },
        })

    end,
  },
    -- git-conflict: resolve merge conflicts visually
    {
      "akinsho/git-conflict.nvim",
      version = "*",
      event = "BufReadPre",
      config = function()
        require("git-conflict").setup({
          default_mappings = true,
          default_commands = true,
          disable_diagnostics = false,
          list_opener = "copen",
          highlights = {
            incoming = "DiffAdd",
            current = "DiffText",
          },
        })

        -- Keymaps
        vim.keymap.set("n", "<leader>co", ":GitConflictChooseOurs<CR>",   { desc = "Conflict: choose ours" })
        vim.keymap.set("n", "<leader>ct", ":GitConflictChooseTheirs<CR>", { desc = "Conflict: choose theirs" })
        vim.keymap.set("n", "<leader>cb", ":GitConflictChooseBoth<CR>",   { desc = "Conflict: choose both" })
        vim.keymap.set("n", "<leader>cn", ":GitConflictNextConflict<CR>", { desc = "Conflict: next conflict" })
        vim.keymap.set("n", "<leader>cp", ":GitConflictPrevConflict<CR>", { desc = "Conflict: previous conflict" })
        vim.keymap.set("n", "<leader>cl", ":GitConflictListQf<CR>",       { desc = "Conflict: list all" })
      end,
    },
    -- Octo: manage GitHub PRs and issues from nvim
    {
      "pwntester/octo.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-tree/nvim-web-devicons",
      },
      cmd = "Octo",
      -- Keymaps in `keys` so they exist before the plugin loads
      keys = {
        { "<leader>opr", ":Octo pr list<CR>", desc = "Octo: list PRs" },
        { "<leader>opc", ":Octo pr create<CR>", desc = "Octo: create PR" },
        { "<leader>ois", ":Octo issue list<CR>", desc = "Octo: list issues" },
        { "<leader>oic", ":Octo issue create<CR>", desc = "Octo: create issue" },
        { "<leader>or", ":Octo review start<CR>", desc = "Octo: start review" },
      },
      config = function()
        require("octo").setup({
          enable_builtin = true,
          default_remote = { "upstream", "origin" },
          ssh_aliases = {},
          reaction_viewer_hint_icon = "",
          user_icon = " ",
          timeline_marker = "",
          timeline_indent = "2",
          right_bubble_delimiter = "",
          left_bubble_delimiter = "",
          github_hostname = "",
          snippet_context_lines = 4,
          file_panel = {
            size = 10,
            use_icons = true,
          },
          mappings = {},
        })
      end,
    },
}
