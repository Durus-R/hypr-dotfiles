-- lua/kitten/plugins/theme.lua
return {
    -- Plugin 1: Das Farbschema 'tokyonight'
    {
        "folke/tokyonight.nvim",
        lazy = false, -- false, damit es sofort geladen wird
        priority = 1000, -- sehr hohe Priorität
        config = function()
            -- Lade das Farbschema beim Start
            vim.cmd.colorscheme "tokyonight"
        end,
    },

    -- Plugin 2: Die schicke Statusleiste 'lualine'
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    -- Wir passen die Statusleiste an unser Theme an
                    theme = "tokyonight",
                },
            })
        end,
    },
}
