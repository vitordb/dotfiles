return {
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPCIONAL: para status do git
      'nvim-tree/nvim-web-devicons', -- OPCIONAL: para ícones de arquivo
    },
    init = function()
      vim.g.barbar_auto_setup = false

      -- Mapeamentos de teclas
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }

      -- Mover para o anterior/seguinte
      map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
      map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
      -- Reordenar para o anterior/seguinte
      map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
      map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
      -- Ir para o buffer na posição...
      map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
      map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
      map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
      map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
      map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
      map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
      map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
      map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
      map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
      map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
      -- Fixar/desfixar buffer
      map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
      -- Fechar buffer
      map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
      -- Modo mágico de escolha de buffer
      map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
      -- Ordenar automaticamente por...
      map('n', '<Space>,b', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
      map('n', '<Space>,d', '<Cmd>BufferOrderByDirectory<CR>', opts)
      map('n', '<Space>,l', '<Cmd>BufferOrderByLanguage<CR>', opts)
      map('n', '<Space>,w', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

      -- buffer pick map
      map('n', '<leader>m', '<cmd>BufferPick<cr>', { noremap = true, silent = true })
    end,

    opts = {
      -- Coloque suas opções de configuração para barbar.nvim aqui
      --
      -- hide = { extensions = true, inactive = true },
      gitsigns = {
        added = { enabled = true, icon = '+' },
        changed = { enabled = true, icon = '~' },
        deleted = { enabled = true, icon = '-' },
      },
      separator_at_end = false,
    },
    version = '^1.0.0',
  },
}
