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

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?", -- Переопределяем, чтобы команды показывались только по лидер + ?
        function()
          require("which-key").show { global = false }
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    config = function(_, opts)
      require("which-key").setup(opts)

      -- Изменение цветов для различных элементов в пастельных тонах
      vim.api.nvim_set_hl(0, "WhichKey", { fg = "#A3D9A5" }) -- Основной цвет для команд (мятный)
      vim.api.nvim_set_hl(0, "WhichKeyGroup", { fg = "#b6ffcb" }) -- Цвет для групп (пастельный розовый)
      vim.api.nvim_set_hl(0, "WhichKeySeparator", { fg = "#E1D5E7" }) -- Цвет разделителей (светлый сиреневый)
      vim.api.nvim_set_hl(0, "WhichKeyDesc", { fg = "#A8D5E2" }) -- Цвет для описаний команд (небесно-голубой)

      -- Для других режимов (например, Visual) применяем аналогичные цвета
      vim.api.nvim_set_hl(0, "WhichKeyVisual", { fg = "#A3D9A5" }) -- Цвет для команд в Visual Mode (мятный)
      vim.api.nvim_set_hl(0, "WhichKeyGroupVisual", { fg = "#FFB6B9" }) -- Цвет для групп в Visual Mode (пастельный розовый)
      vim.api.nvim_set_hl(0, "WhichKeyDescVisual", { fg = "#A8D5E2" }) -- Цвет для описаний в Visual Mode (небесно-голубой)
    end,
  },

  -- nvim-cmp from nvchad 21 dec 2024. added supermaven.
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
            -- preselect = cmp.PreselectMode.None, -- Убираем автовыбор первого элемента
            mapping = {
              -- Tab переключает на следующий элемент
              ["<Tab>"] = cmp.mapping.select_next_item(),
              ["<S-Tab>"] = cmp.mapping.select_prev_item(),
              -- Enter принимает выбранную подсказку, если она выбрана явно
              ["<CR>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.confirm { select = true } -- Принять явно выбранное предложение
                else
                  fallback() -- Выполняется обычный Enter, если подсказок нет
                end
              end, { "c" }),
              -- Shift-Enter: полное игнорирование подсказки, вводится только текст
            },
            sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
            -- matching = { disallow_symbol_nonprefix_matching = false },
          })
        end,
      },
    },

    -- make supermaven-suggestion the first in suggestion list. When you text code.
    -- opts = function(_, opts)
    --   table.insert(opts.sources, 1, { name = "supermaven" })
    -- end,
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

  -- -- ESLint  (Null-ls been archived)
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
      "nvim-lua/plenary.nvim", -- Необходимо для работы плагина
      "hrsh7th/nvim-cmp", -- Если используется для автодополнения
    },
    config = function()
      -- Отключаем маппинг на Tab
      vim.g.codeium_no_map_tab = true

      -- Настроим клавиши для плагина
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]() -- Должно вызвать функцию
      end, { expr = true, silent = true })

      vim.keymap.set("i", "<C-;>", function()
        return vim.fn
      end, { expr = true, silent = true })

      vim.keymap.set("i", "<C-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })

      vim.keymap.set("i", "<C-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true })

      -- Инициализация Codeium
      require("codeium").setup {
        virtual_text = {
          enabled = true,
          manual = false,
          filetypes = {
            python = true,
            lua = true,
            javascript = true,
            typescript = true,
          },
          default_filetype_enabled = true,
        },
      }
    end,
    lazy = false, -- Указываем, чтобы плагин загружался сразу
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
          python = { "yapf" },
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

  {
    "mfussenegger/nvim-lint",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      local lint = require "lint"

      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>ll", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
      -- "ibhagwan/fzf-lua", -- optional
      -- "echasnovski/mini.pick", -- optional
    },
    config = true,
  },
}
