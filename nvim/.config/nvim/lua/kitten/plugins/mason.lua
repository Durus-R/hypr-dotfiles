return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        -- 1. Mason Setup
        require("mason").setup()

        -- 2. Mason-LSPconfig Setup
        -- Wir definieren die Handler direkt HIER drin, nicht separat.
        require("mason-lspconfig").setup({
            ensure_installed = { "pyright", "ruff", "ts_ls", "eslint",  "gopls" },
            
            -- Hier passiert die Magie: Automatische Installation -> Setup
            handlers = {
                -- Der Standard-Handler für alle Server (Fallback)
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,

                -- Spezifischer Override für Pyright
                ["pyright"] = function()
                    require("lspconfig").pyright.setup({
                        settings = {
                            python = {
                                analysis = {
                                    typeCheckingMode = "basic", -- "off", "basic", "strict"
                                }
                            }
                        }
                    })
                end,
                
                -- Ruff (Linter) braucht meist keine extra Config
                ["ruff"] = function()
                    require("lspconfig").ruff.setup({})
                end,
                ["gleam"] = function()
                    require("lspconfig").gleam.setup({})
                end,
                ["ts_ls"] = function()
                    require("lspconfig").ts_ls.setup({})
                end,
                ["eslint"] = function()
                    require("lspconfig").eslint.setup({})
                end,
                ["gopls"] = function()
                    require("lspconfig").gopls.setup({})
                end,
            }
        })
    end
}
