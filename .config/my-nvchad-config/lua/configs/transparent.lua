local options = {
  groups = {
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
    'EndOfBuffer',
  },
  extra_groups = {
    "NormalFloat", "NvimTreeNormal", "TelescopeNormal", "TelescopeBorder",
    "FloatBorder", "FloatTitle", "FloatTitleBg", "FloatTitleFg",
    "NotifyBackground", "NotifyERRORBody", "NotifyWARNBody", "NotifyINFOBody",
    "NotifyDEBUGBody", "NotifyTRACEBody", "NotifyERRORIcon", "NotifyWARNIcon",
    "NotifyINFOIcon", "NotifyDEBUGIcon", "NotifyTRACEIcon", "NotifyERRORTitle",
    "NotifyWARNTitle", "NotifyINFOTitle", "NotifyDEBUGTitle", "NotifyTRACETitle"
  },
  exclude_groups = {},
}

return options 