-- ==========================================
-- USER SETTINGS
-- ==========================================
-- This is the only file you need to edit after cloning.
-- Everything else adapts to the values you set here.

local M = {}

-- Where your projects live.
-- Used by the "search across all projects" pickers and by the dashboard's
-- project switcher. Set it to wherever you keep your code.
--   Examples: "~/Documents", "~/projects", "~/dev", "~/work"
M.projects_dir = "~/Documents"

-- Default base branch used by the Diffview shortcuts (<leader>gd, <leader>gD,
-- <leader>gf) to compare your current work against.
--   Common values: "main", "master", "develop", "development"
M.git_base_branch = "development"

-- Name shown in the dashboard greeting and footer.
-- Leave as nil to auto-detect from your system username.
M.name = nil

-- ASCII banner shown at the top of the dashboard.
-- Replace it with your own (https://patorjk.com/software/taag generates these),
-- or set it to {} for no banner at all.
M.dashboard_header = {
    "  ██████╗ ███████╗██╗   ██╗██████╗ ██╗   ██╗      ██████╗ ███████╗██╗   ██╗",
    "  ██╔══██╗██╔════╝╚██╗ ██╔╝██╔══██╗╚██╗ ██╔╝      ██╔══██╗██╔════╝╚██╗ ██╔╝",
    "  ██║  ██║█████╗   ╚████╔╝ ██████╔╝ ╚████╔╝ █████╗██║  ██║█████╗   ╚████╔╝ ",
    "  ██║  ██║██╔══╝    ╚██╔╝  ██╔══██╗  ╚██╔╝  ╚════╝██║  ██║██╔══╝    ╚██╔╝  ",
    "  ██████╔╝███████╗   ██║   ██████╔╝   ██║         ██████╔╝███████╗   ██║   ",
    "  ╚═════╝ ╚══════╝   ╚═╝   ╚═════╝    ╚═╝         ╚═════╝ ╚══════╝   ╚═╝   ",
}

-- Directories where sessions should NOT be auto-restored.
-- Opening nvim in your home folder or in the projects root usually means you
-- are just browsing, not resuming work.
M.session_ignore_dirs = { "~/", "/" }

-- ==========================================
-- Helpers (no need to edit below this line)
-- ==========================================

-- Absolute, expanded path to the projects directory
function M.projects_path()
    return vim.fn.expand(M.projects_dir)
end

-- Display name, falling back to the system username
function M.display_name()
    return M.name or vim.env.USER or vim.env.USERNAME or "developer"
end

return M
