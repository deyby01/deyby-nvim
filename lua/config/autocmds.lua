-- ==========================================
-- AUTOCOMMANDS
-- ==========================================

-- Auto-save when leaving INSERT mode
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
        -- Only normal, named, modifiable buffers that actually changed
        if vim.bo.buftype == "" and vim.bo.modifiable and vim.bo.modified and vim.fn.expand("%") ~= "" then
            vim.cmd("silent! write")
        end
    end,
    desc = "Save on leaving INSERT mode",
})

-- Reload the file when it changes on disk (e.g. edited by another tool)
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
    pattern = "*",
    callback = function()
        local filename = vim.fn.expand("%")
        if filename ~= "" and vim.fn.filereadable(filename) == 1 then
            vim.cmd("checktime")
        end
    end,
    desc = "Reload file if changed externally",
})

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.hl.on_yank({ timeout = 200 })
    end,
    desc = "Highlight on yank",
})

-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        -- Skip filetypes where trailing whitespace is meaningful
        if vim.tbl_contains({ "markdown", "diff", "gitcommit" }, vim.bo.filetype) then
            return
        end
        local view = vim.fn.winsaveview()
        -- keeppatterns: don't clobber the search history or the / register
        vim.cmd([[keeppatterns %s/\s\+$//e]])
        vim.fn.winrestview(view)
    end,
    desc = "Strip trailing whitespace on save",
})

-- Markdown variants Neovim doesn't detect on its own
-- (uppercase .MD and .mdx fall back to filetype "conf")
vim.filetype.add({
    extension = {
        MD = "markdown",
        mdx = "markdown",
        mdown = "markdown",
        mkd = "markdown",
    },
})

-- Detect docker-compose files so their language server attaches
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "docker-compose*.yml", "docker-compose*.yaml", "compose*.yml", "compose*.yaml" },
    callback = function()
        vim.bo.filetype = "yaml.docker-compose"
    end,
    desc = "Filetype for docker-compose",
})
