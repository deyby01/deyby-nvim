-- ==========================================
-- LSP Y AUTOCOMPLETADO
-- ==========================================

return {
  -- Mason: Instalador de LSP (repos nuevos: mason-org)
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall" },
    opts = {},
  },

  -- Mason-lspconfig (v2: automatic_enable activa los servidores instalados)
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    lazy = true,
    opts = {
      ensure_installed = {
        "pyright",                          -- Python type checker
        "ruff",                             -- Python linter/formatter
        "html",
        "cssls",
        "ts_ls",                            -- JS/TS/React
        "emmet_ls",
        "jsonls",
        "yamlls",
        "dockerls",                         -- Dockerfile
        "docker_compose_language_service",  -- docker-compose.yml
        "nginx_language_server",            -- nginx.conf
      },
    },
  },

  -- Nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "mason-org/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        vim.lsp.config("*", { capabilities = capabilities })

        -- Diagnósticos inline
        vim.diagnostic.config({
            virtual_text = false,
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })

        -- Ruff (Linter + Formatter Python)
        -- Se resuelve desde el PATH: si el .venv está activado, usa el ruff
        -- del proyecto con su configuración local
        vim.lsp.config("ruff", {
            cmd = { "ruff", "server" },
            filetypes = { "python" },
            init_options = {
                settings = {
                    configurationPreference = "filesystemFirst",
                    lint = { enable = true },
                    format = { enable = true },
                },
            },
        })

        -- Pyright (Type Checker Python)
        vim.lsp.config("pyright", {
            cmd = { "pyright-langserver", "--stdio" },
            filetypes = { "python" },
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        diagnosticMode = "workspace",
                        useLibraryCodeForTypes = true,
                        typeCheckingMode = "standard",
                    },
                },
            },
        })

        -- HTML (incluye templates de Django)
        vim.lsp.config("html", {
            cmd = { "vscode-html-language-server", "--stdio" },
            filetypes = { "html", "htmldjango" },
            init_options = {
                configurationSection = { "html", "css", "javascript" },
                embeddedLanguages = { css = true, javascript = true },
                provideFormatter = true,
            },
            settings = {
                html = {
                    format = {
                        indentInnerHtml = true,
                        tabSize = 4,              -- 4 espacios
                        insertSpaces = true,
                        wrapLineLength = 120,
                        endWithNewline = true,
                    },
                },
            },
        })

        -- CSS
        vim.lsp.config("cssls", {
            cmd = { "vscode-css-language-server", "--stdio" },
            filetypes = { "css", "scss", "less" },
        })

        -- JavaScript/TypeScript/React
        vim.lsp.config("ts_ls", {
            cmd = { "typescript-language-server", "--stdio" },
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        })

        -- Emmet (expansión de tags: div.card>ul>li*3, etc.)
        vim.lsp.config("emmet_ls", {
            cmd = { "emmet-ls", "--stdio" },
            filetypes = {
                "html", "htmldjango", "css", "scss",
                "javascript", "javascriptreact", "typescriptreact",
            },
        })

        -- Keymaps de LSP
        local function setup_lsp_keymaps(bufnr)
            local opts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, opts)
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client and client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
                end
                setup_lsp_keymaps(args.buf)
            end,
        })
    end
  },

  -- Conform: formateo por filetype (usa los formatters del .venv/PATH,
  -- con fallback al LSP si no existen)
  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>cf",
        function() require("conform").format({ async = true }) end,
        mode = { "n", "v" },
        desc = "Formatear archivo/selección",
      },
    },
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        htmldjango = { "djlint" },
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
    },
  },

  -- nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
        "onsails/lspkind.nvim",
        "zbirenbaum/copilot-cmp",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

        -- Activar snippets de Django (friendly-snippets los trae, pero
        -- hay que extender los filetypes para que aparezcan).
        -- IMPORTANTE: antes de lazy_load(), si no, no se cargan.
        --   htmldjango -> tags de template ({% block %}, {% for %}...) + HTML normal
        --   python     -> modelos, forms, views, serializers DRF...
        luasnip.filetype_extend("htmldjango", { "html" })
        luasnip.filetype_extend("python", { "django", "django-rest" })

        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                -- select = false: Enter solo confirma si seleccionaste algo
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = "copilot", priority = 1100 },
                { name = "nvim_lsp", priority = 1000 },
                { name = "luasnip", priority = 750 },
                { name = "buffer", priority = 500 },
                { name = "path", priority = 250 },
            }),
            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol_text',
                    maxwidth = 50,
                    ellipsis_char = '...',
                    symbol_map = { Copilot = "" },
                })
            },
        })
    end
  },
}
