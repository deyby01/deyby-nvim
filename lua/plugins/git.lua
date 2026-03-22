-- ==========================================
-- PLUGINS DE GIT
-- ==========================================

return {
  -- Vim Fugitive: Comandos de Git
  {
    'tpope/vim-fugitive',
  },

  -- GitSigns: Ver cambios de Git
  {
    'lewis6991/gitsigns.nvim',
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

        -- ✅ ATAJOS PERSONALIZADOS (sin chocar con dd)

        -- Comparar con development (TU CASO PRINCIPAL)
        vim.keymap.set("n", "<leader>gd", ":DiffviewOpen development<CR>",
            { desc = "Git: Diff con development (QA Review)" })

        -- Comparar con development remoto
        vim.keymap.set("n", "<leader>gD", ":DiffviewOpen origin/development<CR>",
            { desc = "Git: Diff con origin/development" })

        -- Ver cambios no commiteados (working tree)
        vim.keymap.set("n", "<leader>gw", ":DiffviewOpen<CR>",
            { desc = "Git: Diff working tree" })

        -- Cerrar diffview
        vim.keymap.set("n", "<leader>gq", ":DiffviewClose<CR>",
            { desc = "Git: Cerrar Diffview" })

        -- Ver historial del archivo actual
        vim.keymap.set("n", "<leader>gh", ":DiffviewFileHistory %<CR>",
            { desc = "Git: Historial del archivo" })

        -- Ver todos los commits de tu rama vs development
        vim.keymap.set("n", "<leader>gf", ":DiffviewFileHistory development..HEAD<CR>",
            { desc = "Git: Commits desde development" })
    end,
  },
}
