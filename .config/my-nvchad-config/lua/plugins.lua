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
      messages = { enabled = false },
      popupmenu = { enabled = false },
      lsp = { progress = { enabled = false }, override = {}, hover = { enabled = false }, signature = { enabled = false }, message = { enabled = false }, documentation = { view = "hover", opts = {} } },
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
        lsp_cfg = false,
        lsp_gofumpt = true,
        disable_default_keymaps = true,
        lsp_keymaps = false,
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
}
