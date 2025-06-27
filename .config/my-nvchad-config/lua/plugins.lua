return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = { "LazyGit" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = { { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" } },
  },

  -- CONFIGURAÇÃO ÚNICA E DEFINITIVA PARA BLINK.CMP
  {
    "saghen/blink.cmp",
    dependencies = { "L3MON4D3/LuaSnip", "rafamadriz/friendly-snippets" },
    event = "InsertEnter",
    opts = {
      completion = { documentation = { auto_show = false } },
      keymap = {
        preset = "super-tab",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
      },
      sources = { default = { "lsp", "snippets" } },
      snippets = { preset = "luasnip" },
      signature = {
        enabled = true,
        window = { show_documentation = false },
      },
    },
    config = function(_, opts)
      require("blink.cmp").setup(opts)
      
      -- Mapeamentos globais que funcionam com blink.cmp
      local blink = require("blink.cmp")
      
      vim.keymap.set("i", "<C-j>", function()
        if vim.bo.modifiable and blink.is_visible() then
          blink.select_next()
          return ""
        else
          return "<C-n>"
        end
      end, { expr = true, desc = "Next completion item" })
      
      vim.keymap.set("i", "<C-k>", function()
        if vim.bo.modifiable and blink.is_visible() then
          blink.select_prev()
          return ""
        else
          return "<C-p>"
        end
      end, { expr = true, desc = "Previous completion item" })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require("telescope.actions")
      opts.defaults = opts.defaults or {}
      opts.defaults.mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
        n = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
      }
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").load_extension "ui-select"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "vim", "lua", "vimdoc", "html", "css", "go", "gomod" },
    },
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
  },

  -- PLUGINS DE IA - TESTANDO NOICE.NVIM
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- Ativar apenas o cmdline customizado
      cmdline = {
        enabled = true,
        view = "cmdline_popup",
        opts = {},
        format = {
          cmdline = { pattern = "^:", icon = " ", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = "  ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = "  ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
          input = { view = "cmdline_input", icon = " " },
        },
      },
      messages = { enabled = true, view = "notify" },
      popupmenu = { enabled = false },
      lsp = {
        message = { enabled = true, view = "notify" },
        progress = { enabled = true, view = "mini" },
        override = {},
        hover = { enabled = true },
        signature = { enabled = false },
        documentation = { view = "hover", opts = {} }
      },
      presets = {},
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

  -- Go.nvim COM A CONFIGURAÇÃO CORRETA E DEFINITIVA
  {
    "ray-x/go.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-treesitter/nvim-treesitter" },
    event = { "CmdlineEnter", "BufReadPre" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    config = function()
      require("go").setup({
        lsp_cfg = true,
        lsp_gofumpt = true,
        disable_default_keymaps = true,
        lsp_keymaps = false,
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      })
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        group = format_sync_grp,
        callback = function()
          require("go.format").goimports()
        end,
      })
    end,
  },

  -- {
  --   "xiyaowong/transparent.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = require "configs.transparent",
  -- },

  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        max_width = 80,
        max_height = 10,
        stages = "fade",
        timeout = 3000,
        background_colour = "#000000",
      })
    end,
  },

  {
    "yetone/avante.nvim",
    build = "make",
    event = "VeryLazy",
    dependencies = {
      "zbirenbaum/copilot.lua",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
      "stevearc/dressing.nvim",
      {
        "folke/snacks.nvim",
        lazy = false,
        priority = 1000,
        config = function()
          require("snacks").setup()
        end,
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
          latex = { enabled = false },
        },
        ft = { "markdown", "Avante" },
      },
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
    },
    opts = {
      provider = "copilot",
      providers = {
        copilot = {},
      },
    },
    config = function(_, opts)
      -- Check if copilot is available and authenticated before setting up avante
      local function setup_avante()
        -- First check if copilot is available
        local copilot_ok = pcall(require, "copilot")
        if not copilot_ok then
          vim.notify("Copilot not available, disabling avante.nvim", vim.log.levels.WARN)
          return
        end
        
        -- Try to setup avante even if copilot is not authenticated
        -- The plugin will handle the authentication internally
        local avante_ok, avante = pcall(require, "avante")
        if avante_ok then
          avante.setup(opts)
          vim.notify("avante.nvim configured successfully", vim.log.levels.INFO)
        else
          vim.notify("Failed to load avante.nvim", vim.log.levels.WARN)
        end
      end
      
      -- Try to setup with a delay to ensure Copilot is ready
      vim.defer_fn(setup_avante, 1000)
    end,
  },

  {
    "folke/which-key.nvim",
    lazy = false,
    config = function()
      require("which-key").setup({})
      vim.api.nvim_create_user_command("ReloadWhichKey", function()
        require("which-key").setup({})
      end, {})
    end,
  },

  -- Copilot setup - must be before avante.nvim
  {
    "zbirenbaum/copilot.lua",
    event = "VeryLazy",
    config = function()
      -- Only setup copilot if we're in a proper workspace
      local function setup_copilot()
        local ok, copilot = pcall(require, "copilot")
        if ok then
          -- Check if we're in a valid directory
          local cwd = vim.fn.getcwd()
          if cwd and cwd ~= "" and cwd ~= "/" then
            copilot.setup({
              suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                  accept = "<C-l>",
                },
              },
              panel = { enabled = false },
              filetypes = {
                markdown = true,
                help = true,
              },
            })
            
            -- Don't try to authenticate automatically - let user do it manually
            -- This prevents the error messages on startup
          else
            vim.notify("Copilot: Not in a valid workspace directory", vim.log.levels.INFO)
          end
        else
          vim.notify("Failed to load copilot.lua", vim.log.levels.WARN)
        end
      end
      
      -- Try to setup immediately, but also schedule a retry
      setup_copilot()
      vim.defer_fn(setup_copilot, 500)
      
      -- Add a user command to help with authentication
      vim.api.nvim_create_user_command("CopilotAuth", function()
        local ok, copilot = pcall(require, "copilot")
        if ok then
          vim.notify("Starting Copilot authentication...", vim.log.levels.INFO)
          local auth_ok = pcall(function()
            require("copilot.auth").get_oauth_token()
          end)
          if auth_ok then
            vim.notify("Copilot authentication successful!", vim.log.levels.INFO)
          else
            vim.notify("Copilot authentication failed. Please try again.", vim.log.levels.ERROR)
          end
        else
          vim.notify("Copilot not available", vim.log.levels.ERROR)
        end
      end, {})
    end,
  },
}
