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

-- Atalhos para Noice.nvim (notificações e logs)
map("n", "<leader>nh", ":Noice history<CR>", { desc = "Noice: Histórico de notificações" })
map("n", "<leader>nl", ":Noice last<CR>", { desc = "Noice: Última notificação" })
map("n", "<leader>nd", ":Noice dismiss<CR>", { desc = "Noice: Fechar notificações" })
map("n", "<leader>nf", "<C-w>p", { desc = "Noice: Focar na notificação/flutuante" })
map("n", "<leader>n_", "<C-w>_", { desc = "Noice: Maximizar altura da notificação" })
map("n", "<leader>n|", "<C-w>|", { desc = "Noice: Maximizar largura da notificação" })

-- Custom command to run Go tests in the current file's directory (Noice notification style)
map("n", "<leader>gf", function()
  local file = vim.api.nvim_buf_get_name(0)
  local dir = vim.fn.fnamemodify(file, ":h")
  local cmd = string.format("cd %s && go test -v 2>&1", dir)
  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data and #data > 0 then
        vim.notify(table.concat(data, "\n"), vim.log.levels.INFO, { title = "Go Test Result" })
      end
    end,
    on_stderr = function(_, data)
      if data and #data > 0 then
        local msg = table.concat(data, "\n")
        if msg:match("%S") then
          vim.notify(msg, vim.log.levels.ERROR, { title = "Go Test Error" })
        end
      end
    end,
  })
end, { desc = "Go: Run package tests in current file's directory (Noice notification)" })

-- Custom command to run Go tests with coverage in the current file's directory (Noice notification style)
map("n", "<leader>gC", function()
  local file = vim.api.nvim_buf_get_name(0)
  local dir = vim.fn.fnamemodify(file, ":h")
  local cmd = string.format("cd %s && go test -cover -v 2>&1", dir)
  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data and #data > 0 then
        vim.notify(table.concat(data, "\n"), vim.log.levels.INFO, { title = "Go Coverage Result" })
      end
    end,
    on_stderr = function(_, data)
      if data and #data > 0 then
        local msg = table.concat(data, "\n")
        if msg:match("%S") then
          vim.notify(msg, vim.log.levels.ERROR, { title = "Go Coverage Error" })
        end
      end
    end,
  })
end, { desc = "Go: Run package tests with coverage in current file's directory (Noice notification)" })
