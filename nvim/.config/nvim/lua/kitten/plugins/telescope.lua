-- lua/kitten/plugins/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5", -- Eine bewährte, stabile Version
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local builtin = require("telescope.builtin")
    local map = vim.keymap.set

    -- Leertaste + ff -> Finde Dateien (find files)
    map("n", "<leader>ff", builtin.find_files, { desc = "Finde Dateien" })

    -- Leertaste + fg -> Finde Textinhalt (live grep)
    map("n", "<leader>fg", builtin.live_grep, { desc = "Suche Text (Grep)" })

    -- Leertaste + fb -> Finde offene Buffer (find buffers)
    map("n", "<leader>fb", builtin.buffers, { desc = "Finde offene Buffer" })

    -- Leertaste + fh -> Finde Hilfe-Tags (find help)
    map("n", "<leader>fh", builtin.help_tags, { desc = "Finde Hilfe-Tags" })
  end,
}
