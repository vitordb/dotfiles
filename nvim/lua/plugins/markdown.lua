return {
  -- {
  --   'lukas-reineke/headlines.nvim',
  --   dependencies = 'nvim-treesitter/nvim-treesitter',
  --   config = true, -- or `opts = {}`
  -- },

  -- install without yarn or npm
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
}
