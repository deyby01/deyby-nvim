-- ==========================================
-- AUTOCOMANDOS
-- ==========================================

-- Guardar automáticamente al salir de modo INSERT
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
        -- Solo buffers normales, con nombre, modificables y con cambios
        if vim.bo.buftype == "" and vim.bo.modifiable and vim.bo.modified and vim.fn.expand("%") ~= "" then
            vim.cmd("silent! write")
        end
    end,
    desc = "Guardar al salir de modo INSERT",
})

-- Recargar archivo cuando cambia externamente (Claude Code, etc)
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
    pattern = "*",
    callback = function()
        local filename = vim.fn.expand("%")
        if filename ~= "" and vim.fn.filereadable(filename) == 1 then
            vim.cmd("checktime")
        end
    end,
    desc = "Recargar archivo si cambió externamente",
})

-- Resaltar al copiar texto (yank)
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.hl.on_yank({ timeout = 200 })
    end,
    desc = "Resaltar al copiar",
})

-- Quitar espacios en blanco al final al guardar
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        -- No tocar filetypes donde el espacio final es significativo
        if vim.tbl_contains({ "markdown", "diff", "gitcommit" }, vim.bo.filetype) then
            return
        end
        local view = vim.fn.winsaveview()
        -- keeppatterns: no contamina el historial de búsqueda ni el registro /
        vim.cmd([[keeppatterns %s/\s\+$//e]])
        vim.fn.winrestview(view)
    end,
    desc = "Eliminar espacios en blanco al guardar",
})

-- Variantes de Markdown que Neovim no detecta solo
-- (.MD en mayúsculas y .mdx caen en filetype "conf" por defecto)
vim.filetype.add({
    extension = {
        MD = "markdown",
        mdx = "markdown",
        mdown = "markdown",
        mkd = "markdown",
    },
})

-- Detectar docker-compose para su language server
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "docker-compose*.yml", "docker-compose*.yaml", "compose*.yml", "compose*.yaml" },
    callback = function()
        vim.bo.filetype = "yaml.docker-compose"
    end,
    desc = "Filetype para docker-compose",
})
