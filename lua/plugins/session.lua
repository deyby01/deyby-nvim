-- ==========================================
-- AUTO SESSION
-- ==========================================

return {
  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Documents", "/" },
        auto_save_enabled = true,
        auto_restore_enabled = true,
        auto_session_use_git_branch = true,
      })

      -- Atajos
      vim.keymap.set("n", "<leader>ss", ":SessionSave<CR>", { desc = "Session: guardar" })
      vim.keymap.set("n", "<leader>sr", ":SessionRestore<CR>", { desc = "Session: restaurar" })
      vim.keymap.set("n", "<leader>sd", ":SessionDelete<CR>", { desc = "Session: eliminar" })
    end,
  },
}
