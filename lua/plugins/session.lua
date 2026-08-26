-- ==========================================
-- AUTO SESSION
-- ==========================================
-- Saves and restores your open files per directory and git branch.

local user = require("config.user")

return {
  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      -- Never auto-restore in the home folder, the filesystem root, or the
      -- projects root: opening nvim there means browsing, not resuming work.
      local suppressed = vim.deepcopy(user.session_ignore_dirs)
      table.insert(suppressed, user.projects_dir)

      require("auto-session").setup({
        log_level = "error",
        suppressed_dirs = suppressed,
        auto_save = true,
        auto_restore = true,
        git_use_branch_name = true,
      })

      -- Keymaps
      vim.keymap.set("n", "<leader>ss", ":SessionSave<CR>", { desc = "Session: save" })
      vim.keymap.set("n", "<leader>sr", ":SessionRestore<CR>", { desc = "Session: restore" })
      vim.keymap.set("n", "<leader>sd", ":SessionDelete<CR>", { desc = "Session: delete" })
    end,
  },
}
