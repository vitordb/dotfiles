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
      enabled = function()
        return vim.b.completion ~= false
      end,
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
      -- go.nvim chama vim.lsp.condelens (typo dele) no fallback de codelens do
      -- nvim 0.11, e isso estoura ON_ATTACH_ERROR toda vez que o gopls conecta.
      -- Definir o shim antes faz o plugin pegar o caminho bom, sem perder o
      -- codelens. Remover quando o upstream corrigir lua/go/lsp.lua:47.
      if not vim.lsp.codelens.enable then
        vim.lsp.codelens.enable = function(_, opts)
          vim.lsp.codelens.refresh(opts or {})
        end
      end

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

--   {
--   "folke/zen-mode.nvim",
--   opts = {
--     -- your configuration comes here
--     -- or leave it empty to use the default settings
--     -- refer to the configuration section below
--   }
-- },

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

  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter" },
    event = "BufReadPost",
    opts = {
      provider_selector = function()
        return { 'treesitter', 'indent' }
      end,
    },
    config = function(_, opts)
      require('ufo').setup(opts)
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    end,
  },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        relculright = true,
        segments = {
          { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
          { sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true }, click = "v:lua.ScSa" },
          { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
          { sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true }, click = "v:lua.ScSa" },
        }
      })
    end,
  },
}
