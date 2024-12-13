-- ~/.config/nvim/lua/configs/lint.lua
local lint = require('lint')

lint.linters_by_ft = {
    python = {'flake8'},  -- Используйте свой линтер
    lua = {'luacheck'},
    -- добавьте другие языки, если нужно
}