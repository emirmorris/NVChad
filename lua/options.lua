require "nvchad.options"

local signs = { Error = " ", Warn = " ", Hint = " ", Info = "󰋼 " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

--vim.opt.encoding = "utf-8"
--vim.opt.fileencoding = "utf-8"
--vim.opt.termguicolors = true

-- Настройка цвета значков
vim.cmd [[ highlight DiagnosticSignError guifg=#FF0000 ]]  -- насыщенный красный цвет для значков ошибок
vim.cmd [[ highlight DiagnosticSignWarn guifg=#FFA500 ]]   -- оранжевый для значков предупреждений
vim.cmd [[ highlight DiagnosticSignHint guifg=#00CED1 ]]   -- бирюзовый для значков подсказок
vim.cmd [[ highlight DiagnosticSignInfo guifg=#1E90FF ]]   -- насыщенный синий для значков информации

-- Настройка цвета текста для диагностик
vim.cmd [[ highlight DiagnosticError guifg=#FF0000 ]]      -- насыщенный красный для текста ошибок
vim.cmd [[ highlight DiagnosticWarn guifg=#FFA500 ]]       -- оранжевый для текста предупреждений
vim.cmd [[ highlight DiagnosticHint guifg=#00CED1 ]]       -- бирюзовый для текста подсказок
vim.cmd [[ highlight DiagnosticInfo guifg=#1E90FF ]]       -- насыщенный синий для текста информации

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
