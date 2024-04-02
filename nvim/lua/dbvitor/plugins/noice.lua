return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    config = function()
      -- Configurações de realce e autocmds específicos
      local noice_hl = vim.api.nvim_create_augroup('NoiceHighlights', {})
      local noice_cmd_types = {
        CmdLine = 'Constant',
        Input = 'Constant',
        Calculator = 'Constant',
        Lua = 'Constant',
        Filter = 'Constant',
        Rename = 'Constant',
        Substitute = 'NoiceCmdlinePopupBorderSearch',
        Help = 'Todo',
      }
      vim.api.nvim_clear_autocmds { group = noice_hl }
      vim.api.nvim_create_autocmd('BufEnter', {
        group = noice_hl,
        callback = function()
          for type, hl in pairs(noice_cmd_types) do
            vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorder' .. type, {})
            vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorder' .. type, { link = hl })
          end
          vim.api.nvim_set_hl(0, 'NoiceConfirmBorder', {})
          vim.api.nvim_set_hl(0, 'NoiceConfirmBorder', { link = 'Constant' })
        end,
      })

      -- Definições de estilo para o cmdline
      local cmdline_opts = {
        border = {
          style = 'rounded',
          text = { top = '' },
        },
      }

      -- Configuração do Noice
      local ok, noice = pcall(require, 'noice')
      if not ok then
        return
      end

      noice.setup {
        cmdline = {
          view = 'cmdline_popup',
          format = {
            -- Configurações detalhadas para cada tipo de cmdline
          },
          opts = cmdline_opts,
        },
        messages = {
          view_search = false,
        },
        lsp = {
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true,
          },
          hover = { enabled = true },
          signature = { enabled = true },
          documentation = {
            opts = {
              win_options = {
                concealcursor = 'n',
                conceallevel = 3,
                winhighlight = {
                  Normal = 'Normal',
                  FloatBorder = 'Todo',
                },
              },
            },
          },
        },
        views = {
          split = { enter = true },
          mini = { win_options = { winblend = 100 } },
        },
        presets = {
          long_message_to_split = true,
          lsp_doc_border = true,
        },
        routes = {
          -- Aqui você pode definir rotas específicas para mensagens e comportamentos
        },
      }

      -- Mapeamentos de teclas para funcionalidades de rolagem do LSP
      vim.keymap.set({ 'n', 'i', 's' }, '<c-j>', function()
        if not require('noice.lsp').scroll(4) then
          return '<c-j>'
        end
      end, { silent = true, expr = true })

      vim.keymap.set({ 'n', 'i', 's' }, '<c-k>', function()
        if not require('noice.lsp').scroll(-4) then
          return '<c-k>'
        end
      end, { silent = true, expr = true })
    end,
    dependencies = {
      'muniftanjim/nui.nvim',
      'rcarriga/nvim-notify',
      -- Aqui você deve adicionar qualquer outra dependência necessária
    },
  },
}
