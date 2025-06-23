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
        preset = "none",
        ["<CR>"] = { "select_and_accept", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-Space>"] = { "show" },
      },
      sources = { default = { "lsp", "snippets" } },
      snippets = { preset = "luasnip" },
    },
    config = function(_, opts)
      require("blink.cmp").setup(opts)
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

  --[[ -- PLUGINS DE IA DESATIVADOS TEMPORARIAMENTE PARA RESOLVER CONFLITO
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = { ["*"] = false },
    },
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
    },
    opts = {
      provider = "copilot",
    },
    config = function(_, opts)
        require("avante").setup(opts)
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  --]]

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
