-- lua/kitten/core/keymaps.lua
vim.g.mapleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Fenster-Navigation mit Strg + h/j/k/l
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Buffer-Navigation mit Shift + h/l
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)

-- Platzhalter für den Dateibaum (wird später nützlich)
map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Speichern mit <leader>s (Leertaste + s)
map("n", "<leader>s", ":w<CR>", opts)
map("n", "<leader>t", ":Trouble diagnostics toggle<cr>", opts)

-- Beenden mit <leader>q (Leertaste + q)
-- map("n", "<leader>q", ":q<CR>", opts)

-- Navigation durch Fehler (Diagnostics)
-- ]d = Springe zum nächsten Fehler (Next Diagnostic)
-- [d = Springe zum vorherigen Fehler (Previous Diagnostic)
map('n', ']d', vim.diagnostic.goto_next, opts)
map('n', '[d', vim.diagnostic.goto_prev, opts)

-- Fehler im Detail anzeigen (Floating Window), wenn du drauf stehst
-- <leader>e = Zeige Fehler-Meldung (Error)
map('n', '<leader>x', vim.diagnostic.open_float, opts)

-- Alle Fehler in einer Liste (Quickfix-Liste) anzeigen
-- map('n', '<leader>q', function()
--    vim.diagnostic.setloclist() -- Füllt die Liste
--    vim.cmd("lopen")            -- Öffnet das Location-List-Fenster unten
-- end, { desc = "Open Diagnostic List" })
-- Toggle TokyoNight day <-> moon on <leader>w
map("n", "<leader>w", function()
  local current = vim.g.colors_name
  local next = (current == "tokyonight-day") and "tokyonight-moon" or "tokyonight-day"
  vim.cmd.colorscheme(next)
end, { desc = "Toggle tokyonight day/moon" })

vim.api.nvim_create_user_command('Q', 'tabnew | execute "terminal" | startinsert', {bang = true, desc = "Open terminal in new tab"})
