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
    cmd = {
      "LazyGit", "LazyGitConfig", "LazyGitCurrentFile",
      "LazyGitFilter", "LazyGitFilterCurrentFile",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  { import = "nvchad.blink.lazyspec" },
  {
    "saghen/blink.cmp",
    dependencies = {
      "Kaiser-Yang/blink-cmp-avante",
      "L3MON4D3/LuaSnip",
    },
    opts = function(_, opts)
      -- Desabilita o autocompletar em buffers que não são de edição
      opts.enabled = function()
        -- Verifica o tipo de buffer. Desativa para prompts, terminais e buffers "sem arquivo".
        local buftype = vim.bo.buftype
        if buftype == "prompt" or buftype == "terminal" or buftype == "nofile" then
          return false
        end

        -- Mantém a verificação de filetype como uma proteção extra
        local disable_in_filetypes = {
          ["neo-tree"] = true,
          ["TelescopePrompt"] = true,
          ["lazy"] = true,
          ["mason"] = true,
          ["checkhealth"] = true,
          ["help"] = true,
        }
        if disable_in_filetypes[vim.bo.filetype] then
          return false
        end

        return true
      end

      -- Configuração das fontes, com a correção para o Luasnip
      opts.sources = {
        default = { "avante", "lsp", "snippets", "buffer", "path" },
        providers = {
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
            opts = {
              -- opções para o blink-cmp-avante, se necessário
            },
          },
        },
      }

      -- Nova configuração para o preset de snippets, conforme a mensagem de erro
      opts.snippets = {
        preset = "luasnip",
      }

      -- Mantém seus keymaps personalizados
      opts.keymap = {
        preset = "none",
        ["<C-j>"]     = { "select_next",  "fallback" },
        ["<C-k>"]     = { "select_prev",  "fallback" },
        ["<C-b>"]     = { "scroll_documentation_up",   "fallback" },
        ["<C-f>"]     = { "scroll_documentation_down", "fallback" },
        ["<C-Space>"] = { "show" },
        ["<C-e>"]     = { "hide", "fallback" },
        ["<CR>"]      = { "select_and_accept", "fallback" },
      }
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
          ["<C-b>"] = actions.preview_scrolling_up,
          ["<C-f>"] = actions.preview_scrolling_down,
          ["<C-e>"] = actions.close,
        },
        n = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-b>"] = actions.preview_scrolling_up,
          ["<C-f>"] = actions.preview_scrolling_down,
          ["<C-e>"] = actions.close,
        },
      }
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {},
          },
        },
      }
      require("telescope").load_extension "ui-select"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc", "html", "css",
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
  },

  -- GitHub Copilot (Desabilitado em favor do copilot.lua, que é uma dependência do avante)
  --[[
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      require("configs.copilot")
    end,
  },
  --]]

  --[[ -- Desabilitando o CopilotChat.nvim para testar o avante.nvim
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    cmd = { "CopilotChat", "CopilotChatExplain", "CopilotChatTests", "CopilotChatQuick" },
    opts = {
      debug = false,
      window = {
        layout = 'vertical',
        width = 0.4,
      },
    },
    config = function(_, opts)
      require("CopilotChat").setup(opts)
    end,
  },
  --]]

  --[[ -- Desabilitando também o plugin de UI do Telescope
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {},
          },
        },
      }
      require("telescope").load_extension "ui-select"
    end,
  },
  --]]

  -- Avante.nvim - Experiência de IA semelhante ao Cursor
  {
    "yetone/avante.nvim",
    build = "make", -- ⚠️ Passo de compilação essencial!
    event = "VeryLazy",
    dependencies = {
      -- Dependências Essenciais
      "zbirenbaum/copilot.lua",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      -- Dependências Opcionais (recomendadas para uma experiência completa)
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
      "stevearc/dressing.nvim", -- Melhora a UI para inputs
      {
        "folke/snacks.nvim",
        lazy = false,
        priority = 1000,
        config = function()
          require("snacks").setup()
        end,
      },
      {
        "MeanderingProgrammer/render-markdown.nvim", -- Renderiza markdown no chat
        opts = {
          file_types = { "markdown", "Avante" },
          latex = { enabled = false }, -- Desabilita o suporte a LaTeX
        },
        ft = { "markdown", "Avante" },
      },
      {
        "HakonHarnes/img-clip.nvim", -- Para colar imagens no chat
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
      provider = "copilot", -- Define o provedor padrão
      providers = {
        copilot = {
          -- Nenhuma configuração extra necessária para o Copilot por enquanto
          -- mas a estrutura está aqui para futuras customizações.
        },
      },
      -- Exemplo de como você poderia adicionar outro provedor no futuro
      -- openai = {
      --   api_key = "...",
      --   model = "gpt-4o",
      -- },
    },
    config = function(_, opts)
        require("avante").setup(opts)
        -- Configuração adicional para o copilot.lua
        require("copilot").setup({
          suggestion = {
            enabled = true,
            auto_trigger = true, -- Reativando para o comportamento desejado
            keymap = {
              accept = "<C-l>", -- Definindo o atalho para aceitar
              -- Adicione outros atalhos aqui se desejar no futuro
            },
          },
          panel = { enabled = false }, -- O painel do avante será usado em seu lugar
        })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- adicione quaisquer opções de configuração aqui
    },
    dependencies = {
      -- é necessário para a UI
      "MunifTanjim/nui.nvim",
      -- útil para notificações consistentes
      "rcarriga/nvim-notify",
    },
  },
  -- Go.nvim
  {
    "ray-x/go.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
      "ray-x/guihua.lua",
    },
    event = { "CmdlineEnter", "BufReadPre" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    config = function()
      require("go").setup({
        lsp_cfg = true,
        lsp_gofumpt = true,
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
