-- init.lua (Die neue, korrekte Version)

-- Lade die Kerneinstellungen (Optionen, Keymaps)
require("kitten.core")

-- Finde und installiere lazy.nvim, falls es fehlt
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Sage lazy.nvim, es soll den Ordner 'kitten.plugins' nach Plugin-Dateien durchsuchen
require("lazy").setup("kitten.plugins")
