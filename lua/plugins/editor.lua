-- ==========================================
-- PLUGINS DEL EDITOR
-- ==========================================

return {
  -- Telescope: Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      local actions = require("telescope.actions")

      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git/", "dist/", "build/", "__pycache__", "*.pyc" },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
      })

      -- Buscar archivos en proyecto actual
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Buscar archivos" })

      -- Buscar contenido en proyecto actual
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Buscar contenido" })

      -- Buscar archivos en TODOS los proyectos
      vim.keymap.set("n", "<leader>fp", function()
        builtin.find_files({
          cwd = vim.fn.expand("~/Documents"),
          hidden = true,
        })
      end, { desc = "Buscar archivos en todos los proyectos" })

      -- Buscar contenido en TODOS los proyectos
      vim.keymap.set("n", "<leader>fP", function()
        builtin.live_grep({
          cwd = vim.fn.expand("~/Documents"),
        })
      end, { desc = "Buscar contenido en todos los proyectos" })

      -- Buscar entre buffers abiertos
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buscar buffers" })
    end
  },

  -- NvimTree: Explorador de archivos
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 35,
          side = "left",
          preserve_window_proportions = false,
        },
        renderer = {
          group_empty = true,
          highlight_git = true,
          indent_markers = {
            enable = true,
          },
        },
        filters = {
          dotfiles = false,
          custom = { "^.git$", "node_modules", "__pycache__" },
        },
        git = {
          enable = true,
          ignore = false,
        },
      })

      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle NvimTree" })
    end
  },

  -- Harpoon: Marcar archivos frecuentes
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon: marcar archivo" })
      vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: archivo 1" })
      vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: archivo 2" })
      vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: archivo 3" })
      vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: archivo 4" })
      vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: ver lista" })
    end
  },

  -- Treesitter: Mejor syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "lua",
                "python",
                "javascript",
                "html",
                "css",
                "htmldjango",
                "markdown",
                "markdown_inline",
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
        })
    end
  },

  -- Markdown Preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    ft = { "markdown" },
    config = function()
        vim.keymap.set('n', '<leader>mp', ':MarkdownPreview<CR>', { desc = 'Markdown Preview' })
        vim.keymap.set('n', '<leader>ms', ':MarkdownPreviewStop<CR>', { desc = 'Stop Markdown Preview' })

        vim.g.mkdp_auto_start = 0
        vim.g.mkdp_auto_close = 1
        vim.g.mkdp_refresh_slow = 0
        vim.g.mkdp_browser = ''
    end
  },

  -- Auto-cerrar paréntesis, llaves, comillas
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
        local autopairs = require("nvim-autopairs")
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")

        autopairs.setup({
            check_ts = true,  -- Usar treesitter
            ts_config = {
                lua = { "string" },
                javascript = { "template_string" },
                java = false,
            },
            disable_filetype = { "TelescopePrompt", "vim" },
            -- Comportamiento al presionar Enter
            fast_wrap = {
                map = '<M-e>',
                chars = { '{', '[', '(', '"', "'" },
                pattern = [=[[%'%"%)%>%]%)%}%,]]=],
                end_key = '$',
                keys = 'qwertyuiopzxcvbnmasdfghjkl',
                check_comma = true,
                highlight = 'Search',
                highlight_grey='Comment'
            },
        })

        -- Integración con nvim-cmp
        cmp.event:on(
            "confirm_done",
            cmp_autopairs.on_confirm_done()
        )

        -- Reglas personalizadas para mejor comportamiento
        local Rule = require("nvim-autopairs.rule")
        local cond = require("nvim-autopairs.conds")

        -- Agregar espacios entre paréntesis cuando presionas espacio
        local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
        autopairs.add_rules({
            Rule(' ', ' ')
                :with_pair(function(opts)
                    local pair = opts.line:sub(opts.col - 1, opts.col)
                    return vim.tbl_contains({
                        brackets[1][1] .. brackets[1][2],
                        brackets[2][1] .. brackets[2][2],
                        brackets[3][1] .. brackets[3][2]
                    }, pair)
                end)
        })

        -- Auto-indentar al presionar Enter entre llaves/paréntesis/corchetes
        for _, bracket in pairs(brackets) do
            autopairs.add_rules({
                Rule(bracket[1] .. ' ', ' ' .. bracket[2])
                    :with_pair(function() return false end)
                    :with_move(function(opts)
                        return opts.prev_char:match('.%' .. bracket[2]) ~= nil
                    end)
                    :use_key(bracket[2])
            })
        end

        -- Regla especial para Python (f-strings)
        autopairs.add_rules({
            Rule("f'", "'", "python"),
            Rule('f"', '"', "python"),
        })
    end
  },
  -- Comentar código fácilmente
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
        -- Configurar ts_context_commentstring PRIMERO
        require("ts_context_commentstring").setup({
            enable_autocmd = false,
        })

        -- Luego configurar Comment.nvim
        require("Comment").setup({
            pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        })
    end,
  },
}
