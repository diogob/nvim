vim.g.mapleader = ' '

local wk = require("which-key")

wk.register({
  f = {
    name = "File",
    f = { "<cmd>Telescope find_files wrap_results=true<cr>", "Find File" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    s = { "<cmd>Telescope live_grep<cr>", "Search" },
    e = { "<cmd>NvimTreeToggle<cr>", "Explore" },
    l = { "<cmd>NvimTreeCollapse<cr>", "Collapse explorer" },
    c = { "<cmd>NvimTreeFindFile<cr>", "Current buffer in explorer" }
  },
  g = {
    name = "Git",
    d = { "<cmd>VGit buffer_diff_preview<cr>", "Diff" },
    h = { "<cmd>VGit buffer_history_preview<cr>", "History" },
    s = { "<cmd>VGit buffer_hunk_stage<cr>", "Stage hunk" },
    r = { "<cmd>VGit buffer_hunk_reset<cr>", "Revert hunk" },
    R = { "<cmd>VGit buffer_reset<cr>", "Revert buffer" },
    S = { "<cmd>VGit buffer_stage<cr>", "Stage buffer" },
    p = { "<cmd>VGit project_diff_preview<cr>", "Project diff" },
    b = { "<cmd>Telescope git_branches<cr>", "Search branches" },
    c = { "<cmd>Telescope git_commits<cr>", "Search commits" }
  },
  c = {
    name = "Config",
    c = { "<cmd>e $MYVIMRC<cr>", "Edit init.vim" },
    l = { "<cmd>Mason<cr>", "External Packages" },
    u = { "<cmd>PackerSync<cr>", "Update plugins" },
  },
  b = {
    name = "Buffer",
    s = { "<cmd>Telescope buffers<cr>", "Search" },
    c = { "<cmd>bd<cr>", "Close" },
    C = { "<cmd>%bd | e# | bd#<cr>", "Close others" },
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
    r = { "<cmd>TroubleToggle lsp_references<cr>", "All references" },
    d = { "<cmd>TroubleToggle lsp_definitions<cr>", "Definition" },
    D = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document diagnostics" },
  },
  s = {
    name = "Search & Replace",
    o = { "<cmd>lua require('spectre').open()<cr>", "Open panel" },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Search word" },
  },
  h = { "<cmd>noh<cr>", "Highlight" },
  p = { "<cmd>Prettier<cr>", "Prettier" },
  r = { "<cmd>e!<cr>", "Reload buffer" },
  ["<tab>"] = { "<cmd>e#<cr>", "Previous buffer" },
  ["]"] = { "<cmd>bnext<cr>", "Next buffer" },
  ["["] = { "<cmd>bprevious<cr>", "Previous buffer" },
  t = {
    name = "Tests",
    b = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Run buffer" },
    c = { "<cmd>lua require('neotest').run.run()<cr>", "Run current" },
    s = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop tests" },
    o = { "<cmd>lua require('neotest').output.open({ enter = false })<cr>", "Show output" },
    S = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Show summary" }
  }
}, { prefix = "<leader>" })
