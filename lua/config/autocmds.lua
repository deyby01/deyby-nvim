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

-- Crear Makefile automáticamente en carpetas nuevas de C++
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = {"*/week_*/*.cpp", "*/tasks_unab_cplus/*/*.cpp"},
    callback = function()
        local dir = vim.fn.expand("%:p:h")
        local makefile = dir .. "/Makefile"

        if vim.fn.filereadable(makefile) == 0 then
            local content = table.concat({
                "CXX = g++",
                "CXXFLAGS = -Wall -Wextra -std=c++17",
                "TARGET = /tmp/programa",
                "SRCS = $(wildcard *.cpp)",
                "",
                "all:",
                "\t$(CXX) $(CXXFLAGS) $(SRCS) -o $(TARGET) && $(TARGET)",
                "",
                "compile:",
                "\t$(CXX) $(CXXFLAGS) $(SRCS) -o $(TARGET)",
                "",
                "clean:",
                "\trm -f $(TARGET)",
            }, "\n")

            local file = io.open(makefile, "w")
            if file then
                file:write(content)
                file:close()
                vim.notify("Makefile creado en " .. dir, vim.log.levels.INFO)
            end
        end
    end,
    desc = "Crear Makefile automáticamente en carpetas week_*",
})
