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
}
