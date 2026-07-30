-- ==========================================
-- PLUGINS DE GIT
-- ==========================================

return {
  -- Vim Fugitive: Comandos de Git
  {
    'tpope/vim-fugitive',
    cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite" },
  },

  -- GitSigns: Ver cambios de Git
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

                -- Navegación entre cambios
                vim.keymap.set('n', ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, {expr=true, buffer = bufnr, desc = "Siguiente cambio"})

                vim.keymap.set('n', '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, {expr=true, buffer = bufnr, desc = "Anterior cambio"})

                -- Acciones sobre cambios
                vim.keymap.set('n', '<leader>hs', gs.stage_hunk, {buffer = bufnr, desc = "Stage hunk"})
                vim.keymap.set('n', '<leader>hr', gs.reset_hunk, {buffer = bufnr, desc = "Reset hunk"})
                vim.keymap.set('n', '<leader>hp', gs.preview_hunk, {buffer = bufnr, desc = "Preview hunk"})
                vim.keymap.set('n', '<leader>hb', function() gs.blame_line{full=true} end, {buffer = bufnr, desc = "Blame line"})

                -- Diff completo
                vim.keymap.set('n', '<leader>hd', function()
                    gs.diffthis()
                end, {buffer = bufnr, desc = "Diff archivo completo"})

                -- Toggle blame
                vim.keymap.set('n', '<leader>tb', function()
                    gs.toggle_current_line_blame()
                end, {buffer = bufnr, desc = "Toggle blame"})
            end
        })
    end
  },
  -- Diffview: Comparar con development (workflow de trabajo)
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    -- Los atajos van en keys (no en config) para que existan
    -- aunque el plugin aún no haya cargado
    keys = {
      { "<leader>gd", ":DiffviewOpen development<CR>", desc = "Git: Diff con development (QA Review)" },
      { "<leader>gD", ":DiffviewOpen origin/development<CR>", desc = "Git: Diff con origin/development" },
      { "<leader>gw", ":DiffviewOpen<CR>", desc = "Git: Diff working tree" },
      { "<leader>gq", ":DiffviewClose<CR>", desc = "Git: Cerrar Diffview" },
      { "<leader>gh", ":DiffviewFileHistory %<CR>", desc = "Git: Historial del archivo" },
      { "<leader>gf", ":DiffviewFileHistory development..HEAD<CR>", desc = "Git: Commits desde development" },
    },
    config = function()
        require("diffview").setup({
            enhanced_diff_hl = true,
            view = {
                default = {
                    layout = "diff2_horizontal",
                    winbar_info = true,  -- ✅ Mostrar nombre de ramas en la parte superior
                },
            },
            file_panel = {
                win_config = {
                    width = 40,  -- Panel de archivos más ancho
                },
            },
            file_history_panel = {
                win_config = {
                    width = 40,
                },
            },
            hooks = {
                -- Mostrar claramente qué rama es cuál
                diff_buf_read = function()
                    vim.opt_local.number = true
                    vim.opt_local.relativenumber = true
                end,
            },
        })

    end,
  },
    -- Git conflict: resolver conflictos fácilmente
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

        -- Atajos
        vim.keymap.set("n", "<leader>co", ":GitConflictChooseOurs<CR>",   { desc = "Conflict: elegir nuestro cambio" })
        vim.keymap.set("n", "<leader>ct", ":GitConflictChooseTheirs<CR>", { desc = "Conflict: elegir su cambio" })
        vim.keymap.set("n", "<leader>cb", ":GitConflictChooseBoth<CR>",   { desc = "Conflict: elegir ambos" })
        vim.keymap.set("n", "<leader>cn", ":GitConflictNextConflict<CR>", { desc = "Conflict: siguiente conflicto" })
        vim.keymap.set("n", "<leader>cp", ":GitConflictPrevConflict<CR>", { desc = "Conflict: conflicto anterior" })
        vim.keymap.set("n", "<leader>cl", ":GitConflictListQf<CR>",       { desc = "Conflict: listar todos" })
      end,
    },
    -- Octo: gestionar PRs e Issues de GitHub desde nvim
    {
      "pwntester/octo.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-tree/nvim-web-devicons",
      },
      cmd = "Octo",
      -- Atajos en keys para que existan antes de cargar el plugin
      keys = {
        { "<leader>opr", ":Octo pr list<CR>", desc = "Octo: listar PRs" },
        { "<leader>opc", ":Octo pr create<CR>", desc = "Octo: crear PR" },
        { "<leader>ois", ":Octo issue list<CR>", desc = "Octo: listar issues" },
        { "<leader>oic", ":Octo issue create<CR>", desc = "Octo: crear issue" },
        { "<leader>or", ":Octo review start<CR>", desc = "Octo: iniciar review" },
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
