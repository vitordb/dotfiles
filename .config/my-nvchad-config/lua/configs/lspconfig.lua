require("nvchad.configs.lspconfig").defaults()
local servers = { "html", "cssls", "gopls", "ts_ls" }

-- O NvChad configura o mason com PATH = "skip", então o nvim não enxerga o que
-- o mason instala. Colocamos o bin dele no PATH aqui, sem depender do plugin
-- estar carregado (no NvChad ele é lazy, só abre em :Mason*).
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
if not string.find(vim.env.PATH, mason_bin, 1, true) then
  vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
end

-- Numa máquina nova estes servidores não existem, e o nvim falha em silêncio:
-- o cliente simplesmente não anexa. O gopls fica de fora porque o go.nvim já
-- instala o dele. Cada entrada é { binário que precisa existir, pacote mason }.
local required_servers = {
  { "typescript-language-server", "typescript-language-server" },  -- ts_ls
  { "vscode-html-language-server", "html-lsp" },                   -- html
  { "vscode-css-language-server", "css-lsp" },                     -- cssls
  { "lua-language-server", "lua-language-server" },                -- lua_ls, do NvChad
}

local pending = {}
for _, entry in ipairs(required_servers) do
  if vim.fn.executable(entry[1]) == 0 then
    table.insert(pending, entry[2])
  end
end

if #pending > 0 then
  vim.schedule(function()
    -- Pela API do registro, não pelo :MasonInstall: o comando não espera o
    -- registro ser baixado e falha com "Cannot find package" na primeira vez.
    require("mason")
    local registry = require("mason-registry")
    registry.refresh(function()
      for _, name in ipairs(pending) do
        local found, pkg = pcall(registry.get_package, name)
        if not found then
          -- O mason já renomeou pacotes antes. Sem este aviso a falha é muda e
          -- o LSP simplesmente nunca aparece.
          vim.notify("mason não conhece o pacote " .. name, vim.log.levels.WARN)
        elseif not pkg:is_installed() then
          vim.notify("Instalando servidor LSP: " .. name, vim.log.levels.INFO)
          pkg:install()
        end
      end
    end)
  end)
end

-- Configuração específica para o tsserver (ts_ls)
vim.lsp.config('ts_ls', {
  settings = {
    typescript = {
      format = {
        enable = true,
        insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
        insertSpaceAfterCommaDelimiter = true,
        insertSpaceAfterSemicolonInForStatements = true,
        insertSpaceBeforeAndAfterBinaryOperators = true,
        insertSpaceAfterKeywordsInControlFlowStatements = true,
        insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
        insertSpaceBeforeFunctionParenthesis = true,
        placeOpenBraceOnNewLineForFunctions = false,
        placeOpenBraceOnNewLineForControlBlocks = false,
      },
      suggest = {
        completeFunctionCalls = true,
        autoImports = true,
      },
      updateImportsOnFileMove = {
        enabled = "always",
      },
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      format = {
        enable = true,
        insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
        insertSpaceAfterCommaDelimiter = true,
        insertSpaceAfterSemicolonInForStatements = true,
        insertSpaceBeforeAndAfterBinaryOperators = true,
        insertSpaceAfterKeywordsInControlFlowStatements = true,
        insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
        insertSpaceBeforeFunctionParenthesis = true,
        placeOpenBraceOnNewLineForFunctions = false,
        placeOpenBraceOnNewLineForControlBlocks = false,
      },
      suggest = {
        completeFunctionCalls = true,
        autoImports = true,
      },
      updateImportsOnFileMove = {
        enabled = "always",
      },
    },
  },
})

vim.lsp.enable(servers)

-- Configurar auto-format no save para TypeScript/JavaScript
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- read :h vim.lsp.config for changing options of lsp servers 

