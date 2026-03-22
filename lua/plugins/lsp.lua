-- ==========================================
-- LSP Y AUTOCOMPLETADO
-- ==========================================

return {
  -- Mason: Instalador de LSP
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },

  -- Mason-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",      -- Python type checker
          "ruff",         -- Python linter/formatter
          "clangd",       -- C/C++
          "html",
          "cssls",
          "ts_ls",
          "emmet_ls",
        },
        automatic_installation = true,
      })
    end
  },

  -- Nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- Diagnósticos inline
        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })

        -- Ruff (Linter + Formatter Python)
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

        -- C/C++
        vim.lsp.config("clangd", {
            cmd = {
                "   clangd",
                "--background-index",
                "--completion-style=detailed",
            },
            filetypes = { "c", "cpp", "objc", "objcpp" },
        })

        -- HTML
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

        -- JavaScript/TypeScript
        vim.lsp.config("ts_ls", {
            cmd = { "typescript-language-server", "--stdio" },
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        })

        -- Emmet
        vim.lsp.config("emmet_ls", {
            cmd = { "emmet-ls", "--stdio" },
            filetypes = { "html", "htmldjango", "css", "scss", "javascript", "javascriptreact" },
        })

        -- Habilitar todos
        vim.lsp.enable({ "ruff", "pyright", "clangd", "html", "cssls", "ts_ls", "emmet_ls" })

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
            vim.keymap.set("n", "<leader>f", function()
                vim.lsp.buf.format({ async = true })
            end, opts)
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client and client.supports_method("textDocument/inlayHint") then
                    vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
                end
                setup_lsp_keymaps(args.buf)
            end,
        })
    end
  },

  -- nvim-cmp (sin cambios)
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
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

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
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
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
                })
            },
        })
    end
  },
}
