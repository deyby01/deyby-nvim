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
                "cpp",
                "c",
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
    -- Navegación rápida
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        config = function()
        require("flash").setup({
            modes = {
                search = {
                    enabled = true,
                },
                char = {
                    enabled = true,
                },
            },
        })

        -- Atajos
        vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash: saltar" })
        vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash: treesitter" })
    end,
    },
    -- Todo comments
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "BufReadPre",
        config = function()
            require("todo-comments").setup({
                keywords = {
                    FIX  = { icon = " ", color = "error",   alt = { "FIXME", "BUG", "FIXIT" } },
                    TODO = { icon = " ", color = "info" },
                    HACK = { icon = " ", color = "warning" },
                    WARN = { icon = " ", color = "warning", alt = { "WARNING" } },
                    NOTE = { icon = " ", color = "hint",    alt = { "INFO" } },
                },
            })

            -- Buscar todos los TODOs del proyecto
            vim.keymap.set("n", "<leader>ft", ":TodoTelescope<CR>", { desc = "Buscar TODOs" })
        end,
    },
    -- Surround
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup()
        end,
    },
    -- Trouble: panel de errores y warnings
    {
      "folke/trouble.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      event = "BufReadPre",
      config = function()
        require("trouble").setup({
          modes = {
            diagnostics = {
              auto_close = false,
              auto_open = false,
            },
          },
        })

        -- Atajos
        vim.keymap.set("n", "<leader>xx", ":Trouble diagnostics toggle<CR>", { desc = "Trouble: toggle panel" })
        vim.keymap.set("n", "<leader>xf", ":Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Trouble: errores archivo actual" })
        vim.keymap.set("n", "<leader>xq", ":Trouble qflist toggle<CR>", { desc = "Trouble: quickfix list" })
      end,
    },
    -- Spectre: buscar y reemplazar en proyecto
    {
      "nvim-pack/nvim-spectre",
      dependencies = { "nvim-lua/plenary.nvim" },
      event = "BufReadPre",
      config = function()
        require("spectre").setup({
          color_devicons = true,
          open_cmd = "vnew",
          live_update = false,
          highlight = {
            ui = "String",
            search = "DiffChange",
            replace = "DiffDelete",
          },
        })

        -- Atajos
        vim.keymap.set("n", "<leader>S", function() require("spectre").toggle() end, { desc = "Spectre: toggle" })
        vim.keymap.set("n", "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end, { desc = "Spectre: buscar palabra bajo cursor" })
        vim.keymap.set("v", "<leader>sw", function() require("spectre").open_visual() end, { desc = "Spectre: buscar selección" })
        vim.keymap.set("n", "<leader>sf", function() require("spectre").open_file_search({ select_word = true }) end, { desc = "Spectre: buscar en archivo actual" })
      end,
    },
}
