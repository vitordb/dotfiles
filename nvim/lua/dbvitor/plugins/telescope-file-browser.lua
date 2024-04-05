return {
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    config = function()
      -- Requerer o módulo do telescope e configurá-lo
      require('telescope').setup {
        defaults = {
          theme = 'center',
          sorting_strategy = 'ascending',
          layout_config = {
            horizontal = {
              prompt_position = 'top',
              preview_width = 0.3,
            },
          },
        },
      }

      -- Configurar o keymap para abrir o file_browser do telescope
      vim.keymap.set('n', '<leader>se', ':Telescope file_browser<CR>')

      -- Carregar a extensão file_browser do telescope
      require('telescope').load_extension 'file_browser'
    end,
  },
}
