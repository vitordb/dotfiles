return {
  { -- Jot - an easy note taking and managing tool for Neovim
    'letieu/jot.lua',
    dependencies = { 'nvim-lua/plenary.nvim' }, -- Dependências necessárias
    config = function()
      -- Configurações do plugin jot.lua

      -- Mapeamento de teclas para abrir o jot
      vim.keymap.set('n', '<leader>fj', function()
        require('jot').open()
      end, { noremap = true, silent = true })

      -- Configuração do jot
      require('jot').setup {
        quit_key = 'q', -- Tecla para sair do jot
        notes_dir = vim.fn.stdpath 'data' .. '/jot', -- Diretório onde as notas serão salvas
        win_opts = {
          focusable = false, -- Se a janela pode ser focada ou não
        },
      }

      -- Aqui, você pode adicionar qualquer outra configuração adicional que deseje para o jot
    end,
  },
}
