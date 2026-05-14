-- lua/kitten/plugins/filetree.lua
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- Deaktiviere das Banner beim Start von nvim-tree
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup()

    -- Keymap, um den Baum umzuschalten (<leader>e)
    local map = vim.keymap.set
    map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
  end,
}
