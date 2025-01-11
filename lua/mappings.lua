require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Маппинг для сохранения файла с лидером s
map({ "i", "n", "v" }, "<leader>s", "<cmd>w<CR>", { silent = true, desc = "Save file" })

-- Перемещение строки вверх
map("n", "<A-Up>", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move line up" })
map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true, desc = "Move line up in insert mode" })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move selected lines up" })

-- Перемещение строки вниз
map("n", "<A-Down>", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move line down" })
map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true, desc = "Move line down in insert mode" })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move selected lines down" })

-- Normal и Visual режим: удаление в черную дыру с помощью <Ctrl-d>
map("n", "<S-d>", '"_d', { desc = "Delete without copying (Normal)" })
map("v", "<S-d>", '"_d', { desc = "Delete selection without copying (Visual)" })

-- Insert режим: удаление символа перед курсором в черную дыру
map("i", "<C-d>", '<C-o>"_x', { desc = "Delete character without copying (Insert)" })

-- Маппинг для сохранения файла по CTRL-S из всех режимов
map({ "i", "n", "v" }, "<leader>s", "<cmd>w<CR>", { silent = true })

-- Маппинг для UNDO на Ctrl-Z в NORMAL, VISUAL и INSERT режимах
map({ "n", "v", "i" }, "<C-z>", "<Esc>u", { noremap = true, silent = true })

-- Маппинг jj для выхода из режима вставки.
map("i", "jj", "<ESC>")

-- Map Ctrl-A to select all text in the current buffer
map("n", "<C-a>", "ggVG", { desc = "Select All Text in Normal Mode" })
map("i", "<C-a>", "<Esc>ggVG", { desc = "Select All Text in Insert Mode" })
map("v", "<C-a>", "<Esc>ggVG", { desc = "Select All Text in Visual Mode" })

-- Map for Huefy (colorpicker)
map("n", "<leader>t", "<cmd>Huefy<CR>", { noremap = true, silent = true, desc = "Open ColorPicker (Huefy)" })

-- Маппинг для переименования переменной с помощью LSP, оно будет изменено во всех местах
map("n", "<leader>rn", function()
  vim.lsp.buf.rename()
end, { desc = "Rename variable across all occurrences" })

-- Маппинг для выхода из всех окон и выхода из Neovim
map("n", "<Esc><Esc>", ":qa!<CR>", { noremap = true, silent = true, desc = "Quit and close all windows Neovim" })
map("n", "<leader>q", ":q<CR>", { noremap = true, silent = true, desc = "Quit Neovim withoutavings" })
--map("n", "<leader>q", ":qa<CR>", { noremap = true, silent = true, desc = "Quit all windows and exit Neovim" })

-- Delete word ander cursos and insert mode
--map("n", "<A-i>", "caw", { noremap = true, silent = true, desc = "Change current word and enter Insert Mode" })
map("n", "<leader>i", "caw", { noremap = true, silent = true, desc = "Change current word and enter Insert Mode" })
map("v", "<leader>i", "c", { noremap = true, silent = true, desc = "Change selected text and enter Insert Mode" })
map("v", "<leader>i", '"_c', { noremap = true, silent = true, desc = "Change selected text and enter Insert Mode" }) -- the same but black hole

-- Delete selected word and paste from a buffer
vim.api.nvim_set_keymap("v", "<leader>ip", '"_diw"+p', { noremap = true, silent = true })

-- Redo
map("n", "<C-r>", "<C-r>", { noremap = true, silent = true, desc = "Redo last undone change" })

--test for leap
-- Настройка маппинга на лидер+Z
vim.api.nvim_set_keymap(
  "n",
  "<Leader>z",
  ":lua require('leap').leap { target_windows = { vim.fn.win_getid() } }<CR>",
  { noremap = true, silent = true }
)

-- Shift + V for "V-line" mode
map("n", "<S-V>", "V", { desc = "Enter Visual Line Mode" })

-- Включить Visual Line Mode при двойном нажатии "v" в Normal режиме
-- vim.keymap.set("n", "v", function()
--   if vim.fn.getcharstr() == "v" then
--     vim.cmd "normal! V"
--   else
--     vim.cmd "normal! v"
--   end
-- end, { noremap = true, silent = true, desc = "Double 'v' to enter Visual Line Mode" })

---
-- " Переход к началу строки в нормальном режиме
vim.keymap.set("n", "H", "^", { noremap = true, silent = true, desc = "Go to the start of the line" })
-- " Переход к концу строки в нормальном режиме
vim.keymap.set("n", "L", "$", { noremap = true, silent = true, desc = "Go to the end of the line" })
-- " Переход к началу строки в визуальном режиме
vim.keymap.set("v", "H", "^", { noremap = true, silent = true, desc = "Go to the start of the line in visual mode" })
-- " Переход к концу строки в визуальном режиме
vim.keymap.set("v", "L", "$", { noremap = true, silent = true, desc = "Go to the end of the line in visual mode" })

---
-- " Переход на 10 строк вниз в обычном режиме
vim.keymap.set("n", "J", "10j", { noremap = true, silent = true, desc = "Move 10 lines down in normal mode" })
-- " Переход на 10 строк вверх в обычном режиме
vim.keymap.set("n", "K", "10k", { noremap = true, silent = true, desc = "Move 10 lines up in normal mode" })
-- " Переход на 10 строк вниз в визуальном режиме
vim.keymap.set("v", "J", "10j", { noremap = true, silent = true, desc = "Move 10 lines down in visual mode" })
-- " Переход на 10 строк вверх в визуальном режиме
vim.keymap.set("v", "K", "10k", { noremap = true, silent = true, desc = "Move 10 lines up in visual mode" })

-- For add comments (file config/comments.lua)
local comment = require "configs.comments" -- Подключение файла comments.lua
vim.keymap.set(
  "n",
  "<leader>c",
  comment.insert_comment,
  { noremap = true, silent = true, desc = "Insert comment at end of line" }
)
