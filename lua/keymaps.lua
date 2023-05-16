vim.g.mapleader = ' '

vim.schedule(function()
  local wk = require("which-key")

  wk.register({
    f = {
      name = "File",
      f = { "<cmd>Telescope find_files wrap_results=true<cr>", "Find File" },
      r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
      s = { "<cmd>Telescope live_grep<cr>", "Search" },
      e = { "<cmd>e %:p:h<cr>", "Explore" }
    },
    g = {
      name = "Git",
      j = { "<cmd>Gitsigns next_hunk<cr>", "Next hunk" },
      k = { "<cmd>Gitsigns prev_hunk<cr>", "Previous hunk" },
      s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage hunk" },
      r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset hunk" },
      R = { "<cmd>Gitsigns reset_buffer<cr>", "Reset buffer" },
      S = { "<cmd>Gitsigns stage_buffer<cr>", "Stage buffer" },
      d = { "<cmd>Gitsigns preview_hunk<cr>", "Hunk diff" },
      p = { "<cmd>DiffviewOpen<cr>", "Project diff" },
      b = { "<cmd>Telescope git_branches<cr>", "Search branches" },
      c = { "<cmd>Telescope git_commits<cr>", "Search commits" }
    },
    c = {
      name = "Config",
      c = { "<cmd>e $MYVIMRC<cr>", "Edit init.vim" },
      p = { "<cmd>Mason<cr>", "External Packages (Mason)" },
      u = { "<cmd>PackerSync<cr>", "Update plugins" },
    },
    b = {
      name = "Buffer",
      s = { "<cmd>Telescope buffers<cr>", "Search" },
      c = { "<cmd>bd<cr>", "Close" },
      C = { "<cmd>%bd! | e# | bd#<cr>", "Close others" },
    },
    w = {
      name = "Workspace",
      D = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Diagnostics" },
      s = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Search symbols" },
    },
    l = {
      name = "LSP",
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Search symbols" },
      S = { "<cmd>SymbolsOutline<cr>", "Symbols Tree" },
      a = { "<cmd>CodeActionMenu<cr>", "Code Actions" },
      r = { "<cmd>Telescope lsp_references<cr>", "All references" },
      d = { "<cmd>Telescope lsp_definitions<cr>", "Definition" },
      D = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document diagnostics" },
    },
    s = {
      name = "Search & Replace",
      o = { "<cmd>lua require('spectre').open()<cr>", "Open panel" },
      w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Search word" },
    },
    h = { "<cmd>noh<cr>", "Highlight" },
    r = { "<cmd>e!<cr>", "Reload buffer" },
    ["<tab>"] = { "<cmd>e#<cr>", "Previous buffer" },
    [":"] = { "<cmd>Telescope command_history<cr>", "Commmand history" },
    o = { "<cmd>wincmd o<cr>", "Close other windows" },
    q = { "<cmd>qall!<cr>", "Quit" },
    x = { "<cmd>xall!<cr>", "Save and quit" },
    z = { "<cmd>set foldmethod=indent<cr>", "Fold on indent" },
  }, { prefix = "<leader>" })
end)
