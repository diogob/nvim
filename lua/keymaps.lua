vim.g.mapleader = ' '

local wk = require("which-key")

wk.register({
  f = {
    name = "File",
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    s = { "<cmd>Telescope live_grep<cr>", "Search" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
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
    u = { "<cmd>VGit buffer_reset<cr>", "Revert buffer" },
    p = { "<cmd>VGit project_diff_preview<cr>", "Project diff" },
    b = { "<cmd>Telescope git_branches<cr>", "Branches" }
  },
  c = {
    name = "Config",
    c = { "<cmd>e $MYVIMRC<cr>", "Edit init.vim" },
    l = { "<cmd>Mason<cr>", "External Packages" },
    u = { "<cmd>PackerSync<cr>", "Update plugins" },
  },
  b = {
    name = "Buffer",
    r = { "<cmd>e!<cr>", "Reload" },
    c = { "<cmd>bd<cr>", "Close" },
    n = { "<cmd>bnext<cr>", "Next buffer" },
    p = { "<cmd>bprevious<cr>", "Previous buffer" },
  },
  w = {
    name = "Workspace",
    D = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Diagnostics" },
  },
  l = {
    name = "LSP",
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Search symbols" },
    a = { "<cmd>CodeActionMenu<cr>", "Code Actions" },
    r = { "<cmd>TroubleToggle lsp_references<cr>", "All references" },
    d = { "<cmd>TroubleToggle lsp_definitions<cr>", "Definition" },
    D = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document diagnostics" },
  },
  h = { "<cmd>noh<cr>", "Highlight" },
}, { prefix = "<leader>" })
