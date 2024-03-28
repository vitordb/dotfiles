return {
  {
    'github/copilot.vim',
    config = function()
      vim.g.copilot_enabled = false

      vim.api.nvim_create_user_command('ToggleCopilot', function()
        if vim.g.copilot_enabled then
          vim.cmd 'Copilot disable'
          vim.g.copilot_enabled = false
          print 'Copilot desativado'
        else
          vim.cmd 'Copilot enable'
          vim.g.copilot_enabled = true
          print 'Copilot ativado'
        end
      end, {})
    end,
  },
}
