vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- Bключает относительные номера строк
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wildmenu = true -- Включает автодополнение в командной строке
vim.opt.wildmode = { "longest:full", "full" } -- Настраивает режим автодополнения

vim.cmd "syntax enable" -- Включает подсветку синтаксиса
vim.cmd "filetype plugin indent on" -- Включает автозавершение и плагины

-- Прокрутка вниз
vim.keymap.set("n", "<C-d>", function()
  local scroll = math.floor(vim.api.nvim_win_get_height(0) / 2)
  -- Прокрутка вниз
  vim.cmd("normal! " .. scroll .. "j")
  vim.cmd "normal! zb" -- Перемещаем курсор в нижнюю часть экрана (bottom)
end, { noremap = true, silent = true, desc = "Scroll down with cursor at the bottom" })

vim.keymap.set("v", "<C-d>", function()
  local scroll = math.floor(vim.api.nvim_win_get_height(0) / 2)
  -- Прокрутка вниз в визуальном режиме
  vim.cmd("normal! " .. scroll .. "j")
  vim.cmd "normal! zb" -- Перемещаем курсор в нижнюю часть экрана (bottom)
end, { noremap = true, silent = true, desc = "Scroll down with cursor at the bottom in visual mode" })

-- Прокрутка вверх
vim.keymap.set("n", "<C-u>", function()
  local scroll = math.floor(vim.api.nvim_win_get_height(0) / 2)
  -- Прокрутка вверх
  vim.cmd("normal! " .. scroll .. "k")
  vim.cmd "normal! zt" -- Перемещаем курсор в верхнюю часть экрана (top)
end, { noremap = true, silent = true, desc = "Scroll up with cursor at the top" })

vim.keymap.set("v", "<C-u>", function()
  local scroll = math.floor(vim.api.nvim_win_get_height(0) / 2)
  -- Прокрутка вверх в визуальном режиме
  vim.cmd("normal! " .. scroll .. "k")
  vim.cmd "normal! zt" -- Перемещаем курсор в верхнюю часть экрана (top)
end, { noremap = true, silent = true, desc = "Scroll up with cursor at the top in visual mode" })

-- Прокрутка вниз с сохранением выделения
vim.keymap.set("n", "<C-d>", function()
  local lines = vim.api.nvim_win_get_height(0) / 2
  vim.cmd("normal! " .. lines .. "j")
  vim.cmd "normal! zb"
end, { noremap = true, silent = true, desc = "Scroll down without losing selection" })

-- Прокрутка вверх с сохранением выделения
vim.keymap.set("n", "<C-u>", function()
  local lines = vim.api.nvim_win_get_height(0) / 2
  vim.cmd("normal! " .. lines .. "k")
  vim.cmd "normal! zt"
end, { noremap = true, silent = true, desc = "Scroll up without losing selection" })
--
-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"
-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

-- -- Noise (cmdline popup)
-- require("noice").setup {
--   views = {
--     cmdline_popup = {
--       border = {
--         style = "none", -- Убираем рамку
--         padding = { 2, 3 }, -- Поставить отступы
--       },
--       filter_options = {},
--       win_options = {
--         winhighlight = "NormalFloat:Normal,FloatBorder:None", -- Убираем рамку и ее цвет
--       },
--     },
--   },
-- }

vim.schedule(function()
  require "mappings"
end)
