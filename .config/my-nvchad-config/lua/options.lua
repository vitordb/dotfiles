require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!

-- tabs & indentation
o.tabstop = 2 -- 2 spaces for tabs (prettier default)
o.shiftwidth = 2 -- 2 spaces for indent width
o.expandtab = true -- expand tab to spaces
o.autoindent = true -- copy indent from current line when starting new one

-- line numbers
o.relativenumber = true -- show relative line numbers
o.number = true -- shows absolute line number on cursor line (when relative number is on)

-- search settings
o.ignorecase = true -- ignore case when searching
o.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- Folding sempre ativado, mas tudo aberto por padrão
o.foldenable = true
o.foldlevel = 99
o.foldlevelstart = 99

-- Transparência total para floats do LSP, signature help, autocomplete, etc
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { bg = "none" })
vim.api.nvim_set_hl(0, "LspInfoBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "LspFloatWinBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "LspFloatWinNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "CmpDocumentation", { bg = "none" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })

-- Clipboard por OSC 52, só em sessão SSH.
-- Numa máquina remota o nvim não alcança o clipboard do computador que está na
-- sua frente. O OSC 52 resolve mandando o texto copiado pelo próprio terminal,
-- como sequência de escape. Localmente não entra: o clipboard nativo do sistema
-- é melhor e já funciona.
-- Depende de "set -g set-clipboard on" no tmux, senão o escape não atravessa.
if os.getenv("SSH_TTY") then
  local osc52 = require("vim.ui.clipboard.osc52")
  vim.g.clipboard = {
    name = "OSC 52",
    copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
    paste = { ["+"] = osc52.paste("+"), ["*"] = osc52.paste("*") },
  }
end
