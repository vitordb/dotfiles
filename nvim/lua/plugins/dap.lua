return {

  {
    'mfussenegger/nvim-dap',
    config = function() end,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      require('dapui').setup()
    end,
  },

  {
    'theHamsta/nvim-dap-virtual-text',
    config = function() end,
  },
}
