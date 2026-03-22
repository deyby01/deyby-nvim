-- ==========================================
-- KEYMAPS (ATAJOS DE TECLADO)
-- ==========================================

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ==========================================
-- NAVEGACIÓN Y EDICIÓN
-- ==========================================

-- Guardar archivo
keymap("n", "<C-s>", ":w<CR>", opts)

-- Salir sin guardar
keymap("n", "<C-q>", ":q!<CR>", opts)

-- Navegación entre ventanas (splits)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- ==========================================
-- GESTIÓN DE VENTANAS (SPLITS)
-- ==========================================

-- Panel nuevo a la derecha
keymap("n", "<leader>v", ":rightbelow vnew<CR>", { noremap = true, silent = true, desc = "Panel derecha" })

-- Panel nuevo abajo
keymap("n", "<leader>s", ":belowright new<CR>", { noremap = true, silent = true, desc = "Panel abajo" })

-- Cerrar panel actual
keymap("n", "<leader>q", ":close<CR>", { noremap = true, silent = true, desc = "Cerrar panel" })

-- Cerrar todos excepto el actual
keymap("n", "<leader>o", ":only<CR>", { noremap = true, silent = true, desc = "Solo este panel" })

-- Ajustar tamaño de NvimTree
keymap("n", "<leader>+", ":NvimTreeResize +5<CR>", { desc = "NvimTree: aumentar ancho" })
keymap("n", "<leader>-", ":NvimTreeResize -5<CR>", { desc = "NvimTree: reducir ancho" })

-- ==========================================
-- GIT
-- ==========================================

-- Git status
keymap("n", "<leader>gs", ":Git<CR>", opts)

-- Git: deshacer cambios del archivo actual
keymap("n", "<leader>gu", ":Git restore %<CR>", { desc = "Git: deshacer cambios del archivo actual" })

-- Git: deshacer TODOS los cambios
keymap("n", "<leader>gU", ":Git restore .<CR>", { desc = "Git: deshacer TODOS los cambios" })

-- ==========================================
-- UTILIDADES
-- ==========================================

-- Toggle colorizer (colores CSS)
keymap("n", "<leader>tc", ":ColorizerToggle<CR>", { desc = "Toggle colorizer" })

-- Atajo rápido para editar .env
keymap("n", "<leader>ve", function()
    vim.cmd("edit .env")
end, { desc = "Editar .env" })

-- Salida rápida de modo INSERT (alternativa a ESC)
keymap('i', 'jk', '<Esc>', opts)
keymap('i', 'kj', '<Esc>', opts)

-- ==========================================
-- C++ COMPILAR Y EJECUTAR
-- ==========================================
keymap("n", "<leader>rr", function()
    local file = vim.fn.expand("%:p")  -- ruta absoluta del .cpp
    local name = vim.fn.expand("%:t:r") -- solo el nombre sin extensión
    local out = "/tmp/" .. name
    local cmd = string.format("g++ %s -o %s && %s", file, out, out)
    vim.cmd("split | terminal " .. cmd)
end, { desc = "C++: Compilar y ejecutar" })

-- Solo compilar (sin ejecutar)
keymap("n", "<leader>rc", function()
    local file = vim.fn.expand("%:p")
    local name = vim.fn.expand("%:t:r")
    local out = "/tmp/" .. name
    local cmd = string.format("g++ %s -o %s", file, out)
    vim.cmd("split | terminal " .. cmd)
end, { desc = "C++: Solo compilar" })

-- Ejecutar con makefile en la carpeta actual todos los archivos .cpp
keymap("n", "<leader>rm", function()
    local dir = vim.fn.expand("%:p:h")  -- carpeta del archivo actual
    local cmd = string.format("cd %s && make", dir)
    vim.cmd("split | terminal " .. cmd)
end, { desc = "C++: Ejecutar Makefile" })

keymap("n", "<leader>rC", function()
    local dir = vim.fn.expand("%:p:h")
    local cmd = string.format("cd %s && make compile", dir)
    vim.cmd("split | terminal " .. cmd)
end, { desc = "C++: Solo compilar proyecto completo" })
