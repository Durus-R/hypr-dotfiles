-- lua/kitten/plugins/dashboard.lua
return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function ()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')
------------------------------------------------------------------
    -- NEU: EINE FUNKTION, DIE EIN HILFSFENSTER ANZEIGT
    ------------------------------------------------------------------
    -- Wir machen die Funktion global (mit _G.), damit wir sie einfach per Befehl aufrufen können.
    _G.show_keymaps = function()
      -- Der Inhalt des Fensters
      local keymap_text = {
        "Deine Tastenkürzel (<leader> = Leertaste)",
        "───────────────────────────────────────────",
        "",
        " Allgemein:",
        "  <leader>s        -> Speichern",
        "",
        " Plugins:",
        "  <leader>e        -> Dateibaum umschalten",
        "  <leader>q       -> Terminal umschalten",
        "  <leader>w       -> Hellen Modus umschalten",
        "",
        " Telescope:",
        "  <leader>ff       -> Dateien finden",
        "  <leader>fg       -> Textinhalt suchen (Grep)",
        "  <leader>fb       -> Offene Buffer finden",
        "",
        " LSP (Code-Intelligenz):",
        "  gd               -> Gehe zu Definition",
        "  gr               -> Finde Referenzen",
        "  K                -> Dokumentation anzeigen",
        "  <leader>rn       -> Umbenennen",
        "  <leader>ca       -> Code-Aktionen",
        "  [d               -> Nächster Fehler",
        "  ]d               -> Voriger Fehler",
        "  <leader>q        -> Fehlerübersicht",
        "  <leader>t        -> Fehler anzeigen",
        "  <leader>p        -> Code formatieren"
      }

      -- Erstelle einen leeren Buffer für unser Fenster
      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, keymap_text)

      -- Konfiguriere das schwebende Fenster (Größe, Position, Rand)
      local width = 50
      local height = #keymap_text
      local top = math.floor((vim.o.lines - height) / 2)
      local left = math.floor((vim.o.columns - width) / 2)
      local opts = {
        style = "minimal",
        relative = "editor",
        width = width,
        height = height,
        row = top,
        col = left,
        border = "rounded",
      }

      -- Öffne das Fenster
      local win = vim.api.nvim_open_win(buf, true, opts)
      -- Füge ein Keymap hinzu, um das Fenster mit 'q' zu schließen
      vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = buf, silent = true })
    end
    -- Hier definieren wir die Knöpfe, die angezeigt werden sollen
    dashboard.section.buttons.val = {
        dashboard.button("f", "  Neue Datei", ":ene <BAR> startinsert <CR>"),
        dashboard.button("e", "  Dateibaum", ":NvimTreeToggle <CR>"),
dashboard.button("k", "  Tastenkürzel", ":lua _G.show_keymaps()<CR>"), -- NEUER KNOPF
        dashboard.button("p", "  Projekte finden", ":Telescope find_files <CR>"),
	dashboard.button("c", "  Konfiguration", ":e " .. vim.fn.stdpath('config') .. "/init.lua <CR>"),
        dashboard.button("q", "  Beenden", ":qa<CR>"),
    }

    -- Das ist unser Header - ein cooles Neovim-Logo in ASCII Art
    dashboard.section.header.val = {
"| \\ | | \\ \\    / / |_   _| |  \\/  |",
 "|  \\| |  \\ \\  / /    | |   | \\  / |",
 "| . ` |   \\ \\/ /     | |   | |\\/| |",
 "| |\\  |    \\  /     _| |_  | |  | |",
 "|_| \\_|     \\/     |_____| |_|  |_|",
    }

    -- Hier setzen wir noch ein paar Optionen
    dashboard.section.footer.val = {
"O, to stride with giants into the crucible of war!",
"Blessed is he who guides this blessed machine,",
"trusted is he who carries the sacred wafer,",
"it's holy writ brings salvation and destruction,",
"the word of the Omnissiah that brings all dooms."
    }

    -- DIE KORRIGIERTE ZEILE:
    -- Wir fügen die Optionen direkt in die Hauptkonfigurationstabelle 'dashboard.opts' ein.
    dashboard.opts.opts = { noautocmd = true }

    -- Lade das Dashboard mit unserer korrigierten Konfiguration
    alpha.setup(dashboard.opts)
  end
}
