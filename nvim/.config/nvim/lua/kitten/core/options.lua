-- lua/kitten/core/options.lua
local opt = vim.opt

-- Zeilennummern
opt.relativenumber = true
opt.number = true

-- Tabs & Einrückung
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Sucheinstellungen
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Darstellung
opt.wrap = false
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true

-- Sonstiges
opt.scrolloff = 8
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.stdpath('data') .. '/undodir'
opt.undofile = true
