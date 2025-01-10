local lspconfig = require "lspconfig"

-- Общая настройка обработчиков LSP
local handlers = {
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    focusable = false, -- Отключает захват фокуса
    border = "rounded", -- Красивая рамка для окна
  }),
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    focusable = false, -- Аналогично, без захвата фокуса
    border = "rounded",
  }),
}

-- Настройка pyright для Python
lspconfig.pyright.setup {
  on_attach = function(client, bufnr)
    vim.cmd [[ autocmd BufWritePre <buffer> lua vim.lsp.buf.format() ]]
  end,
  handlers = handlers, -- Используем новые обработчики
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
      },
    },
  },
}

-- Настройка ts_ls для JavaScript и TypeScript
lspconfig.ts_ls.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    buf_set_keymap("n", "<leader>i", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
  end,
  handlers = handlers, -- Используем новые обработчики
  settings = {
    javascript = { format = { enable = false } },
    typescript = { format = { enable = false } },
    react = { jsx = "react-native" },
  },
  filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json", ".git"),
  on_init = function(client)
    client.server_capabilities.semanticTokensProvider = nil
  end,
}

-- Настройка ESLint для всех поддерживаемых файлов
lspconfig.eslint.setup {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
    vim.cmd [[ autocmd BufWritePre <buffer> EslintFixAll ]]
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    buf_set_keymap("n", "<leader>e", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
  end,
  handlers = handlers, -- Используем новые обработчики
  settings = {
    validate = "on",
    useEslintrc = true,
    codeAction = {
      disableRuleComment = { enable = true, location = "separateLine" },
      showDocumentation = { enable = true },
    },
  },
}

-- Настройка LSP для HTML
lspconfig.html.setup {
  cmd = { "/opt/homebrew/bin/vscode-html-language-server", "--stdio" },
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
    vim.cmd [[ autocmd BufWritePre <buffer> lua vim.lsp.buf.format() ]]
  end,
  handlers = handlers, -- Используем новые обработчики
  settings = {
    html = {
      lint = {
        enable = true,
        validate = "on",
      },
      format = { wrapLineLength = 80 },
    },
  },
  filetypes = { "html", "htm" },
}

-- Конфигурация vim.diagnostic.config
vim.diagnostic.config {
  virtual_text = true,
  signs = true,
  underline = true,
  severity_sort = true,
  float = { border = "rounded", source = "always" },
}
