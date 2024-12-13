local lspconfig = require("lspconfig")

-- Настройка pyright для Python
lspconfig.pyright.setup({
    on_attach = function(client, bufnr)
        -- Автоформатирование при сохранении файла
        vim.cmd [[ autocmd BufWritePre <buffer> lua vim.lsp.buf.format() ]]
    end,
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic",  -- Можно установить "off", "basic" или "strict"
            },
        },
    },
})

-- Настройка ts_ls для JavaScript и TypeScript (замена устаревшего tsserver)
lspconfig.ts_ls.setup({
    on_attach = function(client, bufnr)
        -- Отключаем встроенное форматирование, если используется Prettier
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        -- Пример команды для автоимпорта
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        buf_set_keymap("n", "<leader>i", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
    end,
    settings = {
        javascript = {
            format = {
                enable = false,  -- Отключаем форматирование в пользу Prettier
            },
        },
        typescript = {
            format = {
                enable = false,  -- Отключаем форматирование в пользу Prettier
            },
        },
        react = {
            jsx = "react-native",  -- Убедитесь, что jsx установлен в правильный режим
        },
    },
    filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json", ".git")
})

-- Настройка ESLint для всех поддерживаемых файлов (JavaScript, TypeScript, React)
lspconfig.eslint.setup({
    cmd = { "vscode-eslint-language-server", "--stdio" }, 
    on_attach = function(client, bufnr)
        -- Отключаем встроенное форматирование, если ESLint настроен на автоформатирование через Prettier
        client.server_capabilities.documentFormattingProvider = true

        -- Автоматическое исправление ошибок ESLint при сохранении файла
        vim.cmd [[ autocmd BufWritePre <buffer> EslintFixAll ]]

        -- Установка команд для выполнения исправлений и отображения действий LSP
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        buf_set_keymap("n", "<leader>e", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
    end,
    settings = {
        validate = "on",  -- Проверка ESLint включена
        useEslintrc = true,  -- Используем конфигурацию из .eslintrc.js
        codeAction = {
            disableRuleComment = {
                enable = true,
                location = "separateLine"
            },
            showDocumentation = {
                enable = true
            }
        },
    },
})

-- Конфигурация vim.diagnostic.config
vim.diagnostic.config({
    virtual_text = true,  -- Отображение текста ошибки рядом с кодом
    signs = true,         -- Включение значков рядом с номерами строк
    underline = true,     -- Подчеркивание строк с ошибками
    severity_sort = true, -- Сортировка диагностик по степени важности
    float = {             -- Параметры для плавающих окон с ошибками
        border = "rounded",
        source = "always",
    },
})

