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
}
