require("nvchad.configs.lspconfig").defaults()
local servers = { "html", "cssls" }

-- Configuração específica para o tsserver (ts_ls)
local lspconfig = require("lspconfig")
lspconfig.ts_ls.setup({
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

