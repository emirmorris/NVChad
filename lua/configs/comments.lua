local M = {}

-- Таблица символов комментариев для разных типов файлов
local comment_symbols = {
  lua = "-- ",
  python = "# ",
  javascript = "// ",
  typescript = "// ",
  html = "<!--  -->", -- Обрамляющий комментарий с пробелом внутри
  css = "/*  */", -- Обрамляющий комментарий с пробелом внутри
  c = "// ",
  cpp = "// ",
  go = "// ",
  rust = "// ",
}

-- Количество пробелов перед комментарием
local spaces_before_comment = " " -- пробел

M.insert_comment = function()
  -- Определяем текущий тип файла
  local filetype = vim.bo.filetype
  -- Берем символ комментария из таблицы, если тип файла не найден, используем "// " по умолчанию
  local comment = comment_symbols[filetype] or "// "

  local line = vim.api.nvim_get_current_line() -- Получаем текущую строку
  local updated_line = line .. spaces_before_comment .. comment
  vim.api.nvim_set_current_line(updated_line)

  -- Перемещаем курсор в нужное место
  local col = #updated_line -- По умолчанию курсор в конце строки

  if filetype == "html" then
    -- Для HTML смещаем курсор на 4 символа влево (между <!-- и -->)
    col = col - 4
  elseif filetype == "css" then
    -- Для CSS смещаем курсор на 3 символа влево (между /* и */)
    col = col - 3
  end

  -- Устанавливаем курсор на новую позицию
  vim.api.nvim_win_set_cursor(0, { vim.fn.line ".", col })

  -- Входим в Insert Mode
  vim.cmd "startinsert!"
end

return M
