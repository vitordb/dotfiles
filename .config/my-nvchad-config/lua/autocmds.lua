require "nvchad.autocmds"

-- Aplicar transparência após carregamento do tema
vim.api.nvim_create_autocmd("User", {
  pattern = "NvChadThemeLoaded",
  callback = function()
    vim.defer_fn(function()
      require("transparent").toggle()
    end, 100)
  end,
})
