return {

  -- Плагин для работы с LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  -- Плагин для автозакрытия скобок и кавычек
  -- {
  --   "windwp/nvim-autopairs",
  --   config = function()
  --     require("nvim-autopairs").setup {
  --       check_ts = true,  -- включает поддержку Treesitter для лучшего автозакрытия
  --     }
  --   end,
  -- },

  -- -- Плагин для автозакрытия HTML/JSX тегов
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup {
        filetypes = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "jsx", "tsx" },
        skip_tags = { "img", "input", "br", "hr", "area", "base", "col", "embed", "source", "track", "wbr" },
      }
    end,
  },

  -- Treesitter для подсветки синтаксиса и поддержка HTML, CSS, JavaScript, JSX и других языков
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "python",
      },
      highlight = {
        enable = true, -- включает подсветку для всех файлов с поддержкой Treesitter
      },
    },
    build = ":TSUpdate", -- автоматически обновлять Treesitter
  },

  -- Плагин для работы с цветами и выбором цветовой палитры (volt)
  {
    "nvchad/volt",
    lazy = true,
  },

  -- Плагин для цветовой палитры и цветовых команд (minty)
  {
    "nvchad/minty",
    cmd = { "Shades", "Huefy" },
  },

  -- Поддержка интерфейса команд (which-key)
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = function()
      return {} -- пустой набор опций
    end,
  },

  -- load luasnips + cmp related in insert mode only
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "supermaven-inc/supermaven-nvim",
        opts = {},
      },
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        config = function(_, opts)
          require("luasnip").config.set_config(opts)

          local luasnip = require "luasnip"

          luasnip.filetype_extend("javascriptreact", { "html" })
          luasnip.filetype_extend("typescriptreact", { "html" })
          luasnip.filetype_extend("svelte", { "html" })

          require "nvchad.configs.luasnip"
        end,
      },

      {
        "hrsh7th/cmp-cmdline",
        event = "CmdlineEnter",
        config = function()
          local cmp = require "cmp"

          cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = { { name = "buffer" } },
          })

          cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
            matching = { disallow_symbol_nonprefix_matching = false },
          })
        end,
      },
    },

    opts = function(_, opts)
      table.insert(opts.sources, 1, { name = "supermaven" })
    end,
  },
  -- Git интеграция
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require "nvchad.configs.gitsigns"
    end,
  },

  -- Плагин для поиска (telescope)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
      return require "nvchad.configs.telescope"
    end,
  },

  {
    "hrsh7th/cmp-cmdline",
    dependencies = { "hrsh7th/nvim-cmp" },
  },

  -- Плагин для управления файлами (nvim-tree)
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    init = function()
      -- Автокоманда для открытия nvim-tree при запуске
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          require("nvim-tree.api").tree.open()
        end,
      })
    end,
    opts = function()
      local nvim_tree = require "nvim-tree"
      nvim_tree.setup {
        view = { -- doesn't work
          -- width = 20,  -- Здесь установите желаемую ширину
          -- side = 'left',  -- Это может быть 'left' или 'right'
        },
      }

      return require "nvchad.configs.nvimtree"
    end,
  },

  {
    "junegunn/vim-emoji",
    config = function()
      vim.g.emoji_in_emoji_filetypes =
        { "markdown", "text", "javascript", "typescript", "javascriptreact", "typescriptreact" }
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "eslint-lsp",
        "gopls",
        "js-debug-adapter",
        "typescript-language-server",
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "configs.lint"
    end,
  },

  -- -- ESLint
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     local null_ls = require "null-ls"
  --     null_ls.setup {
  --       sources = {
  --         null_ls.builtins.diagnostics.eslint, -- Диагностика ESLint
  --         null_ls.builtins.formatting.eslint, -- Форматирование ESLint
  --       },
  --     }
  --   end,
  -- },

  -- For templates. "!" for html
  {
    "mattn/emmet-vim",
    config = function()
      vim.g.user_emmet_leader_key = ","
    end,
  },

  -- Avante. AI plugin for claud 3.5 sonnet
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- add any opts here
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

  -- leap
  {
    "ggandor/leap.nvim",
    config = function()
      local leap = require "leap"

      -- Дополнительные настройки Leap
      leap.opts.case_sensitive = true

      -- Настроить отображение символов для текущего поиска
      require("leap").opts.highlight_unlabeled = true
      require("leap").opts.highlight_current_target = true
    end,
  },

  -- codeium AI
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup {
        virtual_text = { -- turn on "Ghost text"
          enabled = true,
          manual = false, -- Убедитесь, что это значение false, чтобы текст появлялся автоматически
          filetypes = {
            -- Убедитесь, что для вашего файла включена поддержка
            python = true,
            lua = true,
          },
          default_filetype_enabled = true, -- Включает виртуальный текст для всех типов файлов
        },
      }
    end,
    lazy = false, -- Указываем, что плагин должен загружаться сразу
  },

  -- Formatter
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require "conform"

      conform.setup {
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettierd", "prettier" },
          typescript = { "prettierd", "prettier" },
          javascriptreact = { "prettierd", "prettier" },
          typescriptreact = { "prettierd", "prettier" },
          json = { "prettierd", "prettier" },
          markdown = { "prettierd", "prettier" },
          html = { "htmlbeautifier" },
          bash = { "beautysh" },
          yaml = { "yamlfix" },
          toml = { "taplo" },
          css = { "prettierd", "prettier" },
          xml = { "xmllint" },
          python = { "black", "pylint" }, -- Python: black и pylint
        },
      }

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function()
          require("conform").format {
            lsp_fallback = true,
            async = false,
            timeout_ms = 1000,
          }
        end,
      })

      vim.keymap.set({ "n", "v" }, "<leader>l", function()
        conform.format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        }
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },

  --  CMDline-popup (also see settings in nvim/init.lua)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },

  -- -- Установка ALE с использованием Lazy
  -- require("lazy").setup {
  --   {
  --     "dense-analysis/ale",
  --     event = "BufReadPre", -- Загружается при открытии файла
  --     config = function()
  --       -- Настройка ALE
  --       vim.g.ale_linters = {
  --         javascript = { "eslint_d" },
  --         typescript = { "eslint_d" },
  --         javascriptreact = { "eslint_d" },
  --         typescriptreact = { "eslint_d" },
  --       }
  --
  --       -- vim.g.ale_fixers = { -- fixing (maybe formatter?)
  --       --   javascript = { "eslint" },
  --       --   typescript = { "eslint" },
  --       --   javascriptreact = { "eslint" },
  --       --   typescriptreact = { "eslint" },
  --       -- }
  --
  --       -- Включаем линтинг в реальном времени
  --       vim.g.ale_lint_on_insert_leave = 1 -- Линтинг после выхода из режима вставки
  --       vim.g.ale_lint_on_save = 0 -- Отключаем линтинг при сохранении
  --       vim.g.ale_fix_on_save = 0 -- Отключаем автоматическое исправление при сохранении
  --       vim.g.ale_lint_delay = 200 -- Задержка перед запуском линтинга (в миллисекундах)
  --     end,
  --   },
  -- },
  --
  -- Установка плагина nvim-lint
  -- {
  --   "mfussenegger/nvim-lint",
  --   event = { "BufReadPre", "BufNewFile" }, -- Загружается при открытии или создании файла
  --   config = function()
  --     -- Инициализация линтера
  --     local lint = require "lint"
  --
  --     -- Настройка линтеров для разных типов файлов
  --     lint.linters_by_ft = {
  --       javascript = { "eslint_d" }, -- Для JS используем eslint_d
  --       typescript = { "eslint_d" }, -- Для TS используем eslint_d
  --       javascriptreact = { "eslint_d" }, -- Для JS React используем eslint_d
  --       typescriptreact = { "eslint_d" }, -- Для TS React используем eslint_d
  --     }
  --
  --     -- Автокоманды для линтинга
  --     vim.api.nvim_create_autocmd("BufWritePost", {
  --       pattern = { "*.js", "*.ts", "*.jsx", "*.tsx" }, -- Линтить файлы только с нужными расширениями
  --       callback = function()
  --         require("lint").try_lint() -- Запуск линтинга при сохранении файла
  --       end,
  --     })
  --
  --     -- Горячие клавиши для ручного запуска линтинга
  --     vim.keymap.set("n", "<leader>ll", function()
  --       require("lint").try_lint() -- Запуск линтинга по <leader>ll
  --     end, { desc = "Trigger linting for current file" })
  --   end,
  -- },
}
