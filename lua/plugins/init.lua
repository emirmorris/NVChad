return {
  -- Плагин для автоформатирования кода
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

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
        skip_tags = { "img", "input", "br", "hr", "area", "base", "col", "embed", "source", "track", "wbr" }
      }
    end,
  },

  -- Treesitter для подсветки синтаксиса и поддержка HTML, CSS, JavaScript, JSX и других языков
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc", "html", "css", "javascript", "typescript", "tsx", "python"
      },
      highlight = {
        enable = true,  -- включает подсветку для всех файлов с поддержкой Treesitter
      },
    },
    build = ":TSUpdate",  -- автоматически обновлять Treesitter
  },



  -- Плагин для работы с цветами и выбором цветовой палитры (volt)
  {
    "nvchad/volt",
    lazy = true,
  },

  -- -- Плагин для цветовой палитры и цветовых команд (minty)
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
      return {}  -- пустой набор опций
    end,
  },

  -- load luasnips + cmp related in insert mode only
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require "nvchad.configs.luasnip"
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require "configs.cmp"
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
  dependencies = { "hrsh7th/nvim-cmp" }
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
            end
        })
      end,
      opts = function()
        local nvim_tree = require "nvim-tree"
        nvim_tree.setup({
          -- любые другие настройки для nvim-tree
        })
        
        return require "nvchad.configs.nvimtree"
      end,
  },

{
    "junegunn/vim-emoji",
    config = function()
      vim.g.emoji_in_emoji_filetypes = { "markdown", "text", "javascript", "typescript", "javascriptreact", "typescriptreact" }
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

  -- ESLint
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.eslint, -- Диагностика ESLint
          null_ls.builtins.formatting.eslint, -- Форматирование ESLint
        },
      })
    end,
  },
  

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
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },



-- leap
  -- {
  --   "ggandor/leap.nvim",
  --   config = function()
  --     local leap = require('leap')
  --     require("leap").add_default_mappings()
  --     leap.opts.case_sensetive = true
  --   end,
  -- },







}
