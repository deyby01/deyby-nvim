-- ==========================================
-- Neovim Configuration
-- ==========================================
-- Configuración modular de Neovim
-- Autor: deyby-dev
-- Última actualización: Febrero 2026
-- ==========================================

-- Cargar opciones básicas
require("config.options")

-- Cargar keymaps (atajos de teclado)
require("config.keymaps")

-- Cargar autocomandos
require("config.autocmds")

-- Cargar plugins
require("plugins")

print("✨Neovim configurado correctamente")
