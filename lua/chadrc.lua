---@type ChadrcConfig
local M = {}

-- Настройка темы
M.base46 = {
	theme = "material-darker",

  hl_override = {
    ["@number"] = { fg = "#b184ff" },
    ["@operator"] = { fg = "#FF5C82" },
    -- Задаём общий фон для "Normal" (фон нормальных областей в редакторе)
    -- ["Normal"] = { bg = "#0b0b11" },  -- Установите желаемый цвет фона здесь
    
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
