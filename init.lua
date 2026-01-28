-- Mi configuracion de Neovim
--
-- OPCIONES BÁSICAS
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.relativenumber = true
vim.opt.wrap = false

-- BUSQUEDA
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- CLIPBOARD
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

-- LEADER KEY(Tecla para atajos)
vim.g.mapleader = " "

-- COLORES 
vim.opt.termguicolors = true

print("Configuración basicá cargada.")

-- ATAJOS DE TECLADO

-- Guardar archivo 
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true})

-- Salir sin guardar
vim.keymap.set("n", "<C-q>", ":q!<CR>", { noremap = true, silent = true })

-- Navegación entre ventanas (splits)
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })  -- Ventana izquierda
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })  -- Ventana abajo
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })  -- Ventana arriba
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })  -- Ventana derecha

-- GIT STATUS
vim.keymap.set("n", "<leader>gs", ":Git<CR>", { noremap = true, silent = true })

-- LAZY.NVIM (Plugin Manager)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- CARGAR PLUGINS
require("lazy").setup({
  -- Tema de colores: Dracula
  {
    "dracula/vim",
    name = "dracula",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("dracula")
    end
  },

  -- Telescope: Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      
      -- Atajo para buscar archivos
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      -- Atajo para buscar en el contenido
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      -- Atajo para buscar entre buffers abiertos
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
    end
  },

  -- Nvim-tree: Explorador de archivos
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
        },
      })
      
      -- Atajo para abrir/cerrar el explorador
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
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

      -- Marcar archivo actual
      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { noremap = true })
      
      -- Saltar al archivo 1, 2, 3, 4
      vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { noremap = true })
      vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { noremap = true })
      vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { noremap = true })
      vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { noremap = true })
      
      -- Ver lista de archivos marcados
      vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { noremap = true })
    end
  },

  -- Mason: Instalador de Language Servers
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },

  -- Mason-lspconfig: Configuración de LSP con Mason
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright" },
      })
    end
  },

  -- Nvim-lspconfig: Configuración de LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      local lspconfig = require("lspconfig")
      
      -- Configurar Pyright para Python (forma nueva)
      vim.lsp.config("pyright", {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
      })
      vim.lsp.enable("pyright")
      
      -- Atajos para LSP
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    end
  },

  -- Nvim-cmp: Motor de autocompletado
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {"lua", "python", "javascript", "html", "css"},
            highlight = {
                enable = true,
            },
        })
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
        require('lualine').setup({
            options = {
                theme = 'dracula',
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff'},
                lualine_c = {'filename'},
                lualine_x = {'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
            }
        })
    end
  },
  {
    'tpope/vim-fugitive',
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        require("toggleterm").setup({
            size = 15,                   
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
        
        -- Lazydocker (mantener flotante porque es más visual)
        local Terminal = require("toggleterm.terminal").Terminal
        local lazydocker = Terminal:new({ 
            cmd = "lazydocker", 
            hidden = true, 
            direction = "float" 
        })
        vim.keymap.set("n", "<leader>ld", function() lazydocker:toggle() end, {noremap = true, silent = true})
        
        -- Terminal horizontal (estilo VSCode)
        vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", {noremap = true, silent = true})
        
        -- Atajos dentro de la terminal
        function _G.set_terminal_keymaps()
            local opts = {buffer = 0}
            vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)  -- ESC para modo normal
            vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
            vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
            vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
            vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        end
        
        vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end
  }
})
