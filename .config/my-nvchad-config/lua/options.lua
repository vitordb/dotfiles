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
