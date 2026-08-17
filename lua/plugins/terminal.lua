-- ==========================================
-- TERMINAL PLUGINS
-- ==========================================

return {
  -- ToggleTerm: integrated terminal
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        require("toggleterm").setup({
            size = 23,
            open_mapping = [[<c-´>]],
            hide_numbers = true,
            shade_terminals = true,
            start_in_insert = true,
            insert_mappings = true,
            terminal_mappings = true,
            persist_size = true,
            direction = "horizontal",
            close_on_exit = true,
            shell = vim.o.shell,
        })

        -- Lazydocker
        local Terminal = require("toggleterm.terminal").Terminal
        local lazydocker = Terminal:new({
            cmd = "lazydocker",
            hidden = true,
            direction = "float"
        })
        vim.keymap.set("n", "<leader>ld", function() lazydocker:toggle() end, {noremap = true, silent = true, desc = "LazyDocker"})

        -- Live Server: HTML/CSS preview with browser auto-reload, the
        -- equivalent of the VSCode Live Server extension. It serves the folder
        -- of whichever file was open the first time you trigger it.
        local live_server
        vim.keymap.set("n", "<leader>lv", function()
            if not live_server then
                local dir = vim.fn.expand("%:p:h")
                live_server = Terminal:new({
                    cmd = "npx --yes live-server " .. vim.fn.shellescape(dir),
                    hidden = true,
                    direction = "float",
                })
            end
            live_server:toggle()
        end, { noremap = true, silent = true, desc = "Live Server: preview HTML/CSS" })

        -- Horizontal terminal
        vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", {noremap = true, silent = true, desc = "Toggle terminal"})

        -- Keymaps available inside the terminal
        function _G.set_terminal_keymaps()
            local opts = {buffer = 0}
            vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
            vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
            vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
            vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        end

        vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end
  },

  -- vim-tmux-navigator: seamless movement between nvim splits and tmux panes
  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
  },
}
