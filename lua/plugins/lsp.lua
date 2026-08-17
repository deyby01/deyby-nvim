-- ==========================================
-- LSP, COMPLETION AND FORMATTING
-- ==========================================

return {
  -- Mason: installs language servers, linters and debuggers
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall" },
    opts = {},
  },

  -- mason-lspconfig (v2: automatic_enable turns on whatever Mason installed)
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

        -- Diagnostics display
        vim.diagnostic.config({
            virtual_text = false,
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })

        -- Ruff (Python linter + formatter)
        -- Resolved from PATH: with the project's .venv active it uses that
        -- project's ruff and its local configuration
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

        -- Pyright (Python type checker)
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

        -- HTML (including Django templates)
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
                        tabSize = 4,              -- 4 spaces
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

        -- JavaScript / TypeScript / React
        vim.lsp.config("ts_ls", {
            cmd = { "typescript-language-server", "--stdio" },
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        })

        -- Emmet (abbreviation expansion: div.card>ul>li*3, ...)
        vim.lsp.config("emmet_ls", {
            cmd = { "emmet-ls", "--stdio" },
            filetypes = {
                "html", "htmldjango", "css", "scss",
                "javascript", "javascriptreact", "typescriptreact",
            },
        })

        -- LSP keymaps
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

  -- Conform: per-filetype formatting (uses the formatters from your
  -- .venv/PATH, falling back to the LSP when they aren't installed)
  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>cf",
        function() require("conform").format({ async = true }) end,
        mode = { "n", "v" },
        desc = "Format file/selection",
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

  -- nvim-cmp: completion engine
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

        -- Enable the Django snippets. friendly-snippets ships them, but the
        -- filetypes have to be extended for them to show up.
        -- IMPORTANT: this must run before lazy_load(), otherwise they never load.
        --   htmldjango -> template tags ({% block %}, {% for %}...) plus plain HTML
        --   python     -> models, forms, views, DRF serializers...
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
                -- select = false: Enter only confirms an explicit selection
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
