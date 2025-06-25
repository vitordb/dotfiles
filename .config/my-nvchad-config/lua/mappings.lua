require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { silent = true })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { silent = true })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { silent = true })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { silent = true })

map("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "Format file" })

--[[ -- Mapeamentos do CopilotChat desabilitados
map("n", "<leader>cc", "<cmd>CopilotChatToggle<CR>", { desc = "Alternar chat do Copilot" })
map(
  "v",
  "<leader>ce",
  ":<C-u>CopilotChatExplain<CR>",
  { desc = "Copilot: Explicar código selecionado" }
)
map(
  "v",
  "<leader>ct",
  ":<C-u>CopilotChatTests<CR>",
  { desc = "Copilot: Gerar testes para o código" }
)
map("n", "<leader>cq", function()
  vim.ui.input({ prompt = "Copilot: " }, function(input)
    if input then
      vim.cmd("CopilotChat " .. input)
    end
  end)
end, { desc = "Copilot: Chat rápido (prompt)" })
--]]

-- Mapeamentos para Avante.nvim
map("n", "<leader>at", function() require("avante").toggle() end, { desc = "Avante: Alternar painel de chat" })
map("v", "<leader>ae", function() require("avante").edit() end, { desc = "Avante: Editar código selecionado" })
map("n", "<leader>as", function() require("avante").get_suggestion():suggest() end, { desc = "Avante: Sugerir código (Smart Tab)" })

-- Mapeamentos para Transparent.nvim
map("n", "<leader>tt", function() require("transparent").toggle() end, { desc = "Alternar transparência" })
map("n", "<leader>tc", function() require("transparent").clear() end, { desc = "Limpar transparência" })
map("n", "<leader>td", function() 
  require("transparent").clear() 
  vim.notify("Transparência desativada", vim.log.levels.INFO)
end, { desc = "Desativar transparência" })
