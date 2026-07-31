-- ==========================================
-- PLUGINS DEL EDITOR
-- ==========================================

return {
  -- Telescope: Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Buscar archivos" },
      { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Buscar contenido" },
      { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Buscar buffers" },
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({
            cwd = vim.fn.expand("~/Documents"),
            hidden = true,
          })
        end,
        desc = "Buscar archivos en todos los proyectos",
      },
      {
        "<leader>fP",
        function()
          require("telescope.builtin").live_grep({
            cwd = vim.fn.expand("~/Documents"),
          })
        end,
        desc = "Buscar contenido en todos los proyectos",
      },
    },
    config = function()
      local actions = require("telescope.actions")

      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git/", "dist/", "build/", "__pycache__", "%.pyc" },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
      })

      -- Ordenador fzf nativo (mucho más rápido)
      pcall(require("telescope").load_extension, "fzf")
    end
  },

  -- NvimTree: Explorador de archivos
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeResize" },
    keys = {
      { "<leader>e", ":NvimTreeToggle<CR>", silent = true, desc = "Toggle NvimTree" },
    },
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
    end
  },

  -- Harpoon: Marcar archivos frecuentes
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon: marcar archivo" },
      { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon: archivo 1" },
      { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon: archivo 2" },
      { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon: archivo 3" },
      { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon: archivo 4" },
      -- <leader>hh (no <leader>h) para no bloquear los hunks de gitsigns
      { "<leader>hh", function() local h = require("harpoon") h.ui:toggle_quick_menu(h:list()) end, desc = "Harpoon: ver lista" },
    },
    config = function()
      require("harpoon"):setup()
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
                "typescript",
                "tsx",
                "html",
                "css",
                "scss",
                "htmldjango",
                "json",
                "yaml",
                "toml",
                "bash",
                "dockerfile",
                "nginx",
                "markdown",
                "markdown_inline",
                "gitcommit",
                "diff",
                "vim",
                "vimdoc",
                "query",
                "regex",
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
    -- Los atajos van en keys para que existan SIEMPRE, aunque el filetype no
    -- sea markdown. Si estuvieran en config, en un archivo no detectado como
    -- markdown el plugin no cargaría y la tecla no haría nada (fallo silencioso).
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview" },
      { "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", desc = "Stop Markdown Preview" },
    },
    -- init corre ANTES de cargar el plugin: las variables g:mkdp_* se leen
    -- en el momento de la carga, así que en config llegarían tarde.
    init = function()
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
      cmd = "Trouble",
      keys = {
        { "<leader>xx", ":Trouble diagnostics toggle<CR>", silent = true, desc = "Trouble: toggle panel" },
        { "<leader>xf", ":Trouble diagnostics toggle filter.buf=0<CR>", silent = true, desc = "Trouble: errores archivo actual" },
        { "<leader>xq", ":Trouble qflist toggle<CR>", silent = true, desc = "Trouble: quickfix list" },
      },
      config = function()
        require("trouble").setup({
          modes = {
            diagnostics = {
              auto_close = false,
              auto_open = false,
            },
          },
        })
      end,
    },
    -- Spectre: buscar y reemplazar en proyecto
    {
      "nvim-pack/nvim-spectre",
      dependencies = { "nvim-lua/plenary.nvim" },
      keys = {
        { "<leader>S", function() require("spectre").toggle() end, desc = "Spectre: toggle" },
        { "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end, desc = "Spectre: buscar palabra bajo cursor" },
        { "<leader>sw", function() require("spectre").open_visual() end, mode = "v", desc = "Spectre: buscar selección" },
        { "<leader>sf", function() require("spectre").open_file_search({ select_word = true }) end, desc = "Spectre: buscar en archivo actual" },
      },
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
      end,
    },
    -- Cellular Automaton (puro entretenimiento)
    {
      "eandrju/cellular-automaton.nvim",
      cmd = "CellularAutomaton",
      keys = {
        { "<leader>fml", ":CellularAutomaton make_it_rain<CR>", silent = true, desc = "Make it rain" },
        { "<leader>gol", ":CellularAutomaton game_of_life<CR>", silent = true, desc = "Game of life" },
      },
    },
}
