-- ==========================================
-- AUTOCOMANDOS
-- ==========================================

-- Guardar automáticamente al salir de modo INSERT
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
        if vim.fn.expand("%") ~= "" then
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
        vim.highlight.on_yank({ timeout = 200 })
    end,
    desc = "Resaltar al copiar",
})

-- Quitar espacios en blanco al final al guardar
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
    desc = "Eliminar espacios en blanco al guardar",
})
