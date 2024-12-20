---@type ChadrcConfig
local M = {}

-- Настройка темы
M.base46 = {
	theme = "material-darker",

  hl_override = {
    ["@number"] = { fg = "#b184ff" },
    ["@operator"] = { fg = "#FF5C82" },
    
    -- ["@variable"] = { fg = "#317afe" },
    -- ["@function"] = { fg = "#00FF00" },
    -- ["@keyword"] = { fg = "#FFFF00" },
    -- ["@method"] = { fg = "#FF00FF" },
    -- ["@string"] = { fg = "#FFA500" },
  }
}

-- Устанавливаем фон для корректной работы с подсветкой синтаксиса
-- vim.o.background = 'dark'  -- Убедитесь, что фон тёмный

-- Отключение своп-файлов
vim.opt.swapfile = false

-- vim.cmd [[
--   highlight clear console
--   highlight console guifg=#06fe39
-- ]]

return M
