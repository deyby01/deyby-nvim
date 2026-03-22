-- ==========================================
-- PLUGINS DE INTERFAZ (UI)
-- ==========================================

return {
    -- Tema: Dracula
    {
    "dracula/vim",
    name = "dracula",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("dracula")
    end
    },

    -- Barra de estado (lualine)
    {
    'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
        require('lualine').setup({
            options = {
                theme = 'dracula',
                component_separators = { left = '|', right = '|'},
                section_separators = { left = '', right = ''},
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {
                    'branch',
                    {
                        'diff',
                        colored = true,
                        symbols = {added = ' ', modified = ' ', removed = ' '}
                    }
                },
                lualine_c = {
                    {
                        'filename',
                        path = 1,
                        shorting_target = 40,
                        symbols = {
                            modified = ' ●',
                            readonly = ' ',
                            unnamed = '[Sin nombre]',
                            newfile = ' [Nuevo]',
                        }
                    }
                },
                lualine_x = {
                    {
                        'diagnostics',
                        sources = {'nvim_lsp'},
                        symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '}
                    },
                    'encoding',
                    'fileformat',
                    'filetype'
                },
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    {
                        'filename',
                        path = 1,
                    }
                },
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
        })
    end
    },

    -- Colores para CSS/HTML
    {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
        require("colorizer").setup({
            filetypes = {
                "css",
                "scss",
                "sass",
                "html",
                "htmldjango",
                "javascript",
                "typescript",
                "jsx",
                "tsx",
                "lua",
            },
            user_default_options = {
                names = true,
                rgb_fn = true,
                hsl_fn = true,
                css = true,
                css_fn = true,
                mode = "background",
                tailwind = true,
                RRGGBB = true,
                RRGGBBAA = true,
            },
        })
    end,
    },

    -- Líneas de indentación
    {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
        local highlight = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
        }

        local hooks = require("ibl.hooks")
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#FF6B6B", bold = true })
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#FFD93D", bold = true })
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#6BCF7F", bold = true })
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#FFA500", bold = true })
            vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#00D9FF", bold = true })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C77DFF", bold = true })
            vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#00F5D4", bold = true })
        end)

        require("ibl").setup({
            indent = {
                char = "│",
                tab_char = "│",
            },
            scope = {
                enabled = true,
                show_start = true,
                show_end = true,
                highlight = highlight,
            },
            exclude = {
                filetypes = {
                    "help",
                    "lazy",
                    "mason",
                    "NvimTree",
                    "dashboard",
                },
            },
        })
    end,
    },

    -- Rainbow delimiters (colores para paréntesis/tags)
    {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "BufReadPost",
    config = function()
        local rainbow_delimiters = require('rainbow-delimiters')

        require('rainbow-delimiters.setup').setup({
            strategy = {
                [''] = rainbow_delimiters.strategy['global'],
                vim = rainbow_delimiters.strategy['local'],
                html = rainbow_delimiters.strategy['global'],
                htmldjango = rainbow_delimiters.strategy['global'],
            },
            query = {
                [''] = 'rainbow-delimiters',
                html = 'rainbow-tags',
                htmldjango = 'rainbow-tags',
            },
            highlight = {
                'RainbowDelimiterRed',
                'RainbowDelimiterYellow',
                'RainbowDelimiterBlue',
                'RainbowDelimiterOrange',
                'RainbowDelimiterGreen',
                'RainbowDelimiterViolet',
                'RainbowDelimiterCyan',
            },
        })
    end,
    },
    -- Dropbar: breadcrumbs interactivos
    {
      "Bekaboo/dropbar.nvim",
      event = "BufReadPre",
      dependencies = {
        "nvim-telescope/telescope.nvim",
      },
      config = function()
        require("dropbar").setup({
          bar = {
            hover = true,
            enable = function(buf, win)
              return not vim.api.nvim_win_get_config(win).zindex
                and vim.bo[buf].buftype == ""
                and vim.api.nvim_buf_get_name(buf) ~= ""
                and not vim.wo[win].diff
            end,
          },
          icons = {
            enable = true,
            kinds = {
              file_icon = function(path)
                local ok, devicons = pcall(require, "nvim-web-devicons")
                if ok then
                  local icon, hl = devicons.get_icon(path)
                  return (icon or "") .. " ", hl
                end
                return "", nil
              end,
            },
          },
          menu = {
            quick_navigation = true,
            keymaps = {
              ["q"] = function()
                local menu = require("dropbar.api").get_current_dropbar_menu()
                if menu then menu:close() end
              end,
            },
          },
        })

        vim.keymap.set("n", "<leader>bp", function() require("dropbar.api").pick() end, { desc = "Dropbar: navegar breadcrumb" })
      end,
    },
    -- Modes: colores según modo vim
    {
      "mvllow/modes.nvim",
      event = "BufReadPre",
      config = function()
        require("modes").setup({
          colors = {
            copy   = "#FFD93D",
            delete = "#FF6B6B",
            insert = "#50fa7b",
            visual = "#FFA500",
          },
          line_opacity = 0.15,
          set_cursor = true,
          set_cursorline = true,
          set_number = true,
          ignore_filetypes = {
            "NvimTree",
            "TelescopePrompt",
            "dashboard",
          },
        })
      end,
    },
    -- Tiny inline diagnostic: errores más bonitos
    {
      "rachartier/tiny-inline-diagnostic.nvim",
      event = "BufReadPre",
      priority = 1000,
      config = function()
        require("tiny-inline-diagnostic").setup({
          preset = "modern",
          options = {
            show_source = true,
            throttle = 20,
            softwrap = 15,
            multiple_diag_under_cursor = true,
            multilines = true,
            show_all_diags_on_cursorline = true,
          },
        })
      end,
    },
}
