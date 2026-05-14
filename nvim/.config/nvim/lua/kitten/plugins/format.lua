return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        -- Hier wählen wir unsere Waffe: Black oder Ruff
        python = { "black" }, 
        go = { "goimports" }, 
        -- Oder alternativ: python = { "ruff_format" }
      },
      -- Optional: Formatieren beim Speichern (Ordnung muss sein!)
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })
    
    -- Keybinding setzen (z.B. Leader + f)
    vim.keymap.set({ "n", "v" }, "<leader>p", function()
      require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end, { desc = "Format file or range (in range selection)" })
  end,
}
