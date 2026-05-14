return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp", -- Vorschläge vom LSP (Pyright)
        "hrsh7th/cmp-buffer",   -- Vorschläge aus dem aktuellen Text
        "hrsh7th/cmp-path",     -- Dateipfade
        "L3MON4D3/LuaSnip",     -- Snippet Engine (Zwingend nötig für viele LSPs!)
        "saadparwaiz1/cmp_luasnip", -- Verbindung zu Snippets
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body) -- Für Snippet-Support
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(), -- Manuelles Triggern
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Enter wählt aus
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' }, -- Prio 1: LSP (Pyright)
                { name = 'luasnip' },  -- Prio 2: Snippets
            }, {
                { name = 'buffer' },   -- Prio 3: Text im File
            })
        })
    end
}
