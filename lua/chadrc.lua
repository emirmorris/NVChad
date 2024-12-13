---@type ChadrcConfig
local M = {}

-- Настройка темы
M.base46 = {
	theme = "ayu_dark",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

-- Отключение своп-файлов
vim.opt.swapfile = false

return M
