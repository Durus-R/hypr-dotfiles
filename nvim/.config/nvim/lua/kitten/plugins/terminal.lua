-- lua/kitten/plugins/terminal.lua
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      direction = "float",
      shell = '/usr/bin/fish -C "bind \\e exit"' ,
      -- NEUER TEIL: Diese Funktion wird jedes Mal ausgeführt,
      -- wenn ein Terminal geöffnet wird.
      on_open = function(term)
        -- Wir erstellen ein Tastenkürzel speziell für den Terminal-Modus ('t')
        -- und nur für den Buffer dieses Terminals.
        vim.keymap.set('t', '<esc><esc>', '<cmd>ToggleTerm<CR>', {
          buffer = term.bufnr,
          noremap = true,
          silent = true,
          desc = "Terminal verstecken"
        })
      end,
    })

    -- Das alte Tastenkürzel, um das Terminal zu öffnen, bleibt gleich.
    local map = vim.keymap.set
    map("n", "<leader>q", ":ToggleTerm<CR>", { desc = "Toggle Terminal" })
  end,
}
