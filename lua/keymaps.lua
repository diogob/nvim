vim.g.mapleader = ' '

vim.keymap.set("n", "[c", function()
  require("treesitter-context").go_to_context()
end, { silent = true, desc = "Previous context" })
vim.api.nvim_set_keymap('n', 'ga.', '<cmd>TextCaseOpenTelescope<CR>', { desc = "Telescope" })
vim.api.nvim_set_keymap('v', 'ga.', "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
vim.api.nvim_set_keymap('n', ']d', "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "Next diagnostic" })
vim.api.nvim_set_keymap('n', '[d', "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc = "Previous diagnostic" })
vim.api.nvim_set_keymap('n', ']h', "<cmd>Gitsigns next_hunk<cr>", { desc = "Next Git Hunk" })
vim.api.nvim_set_keymap('n', '[h', "<cmd>Gitsigns prev_hunk<cr>", { desc = "Previous Git Hunk" })
vim.api.nvim_set_keymap('n', ']q', "<cmd>cnext<cr>", { desc = "Next quickfix" })
vim.api.nvim_set_keymap('n', '[q', "<cmd>cprevious<cr>", { desc = "Previous quickfix" })

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
      f = { "<cmd>Telescope git_status<cr>", "Changed files" },
      s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage hunk" },
      r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset hunk" },
      R = { "<cmd>Gread<cr>", "Reset buffer" },
      S = { "<cmd>Gwrite<cr>", "Stage buffer" },
      B = { "<cmd>Git blame<cr>", "Blame" },
      d = { "<cmd>Gitsigns preview_hunk<cr>", "Hunk diff" },
      m = { "<cmd>Git mergetool<cr>", "Merge Tool" },
      H = { "<cmd>Gclog<cr>", "Project History" },
      F = { "<cmd>0GcLog<cr>", "File History" },
      c = { "<cmd>Git commit<cr>", "Commit" },
      h = { "<cmd>Gitsigns setqflist<cr>", "List hunks" },
      l = {
        name = "List",
        c = { "<cmd>Telescope git_commits<cr>", "Commits" },
        b = { "<cmd>Telescope git_branches<cr>", "Branches" },
        s = { "<cmd>Telescope git_stash<cr>", "Stash" },
      },
    },
    c = {
      name = "Config",
      c = { "<cmd>e $MYVIMRC<cr>", "Edit init.vim" },
      p = { "<cmd>Mason<cr>", "External Packages (Mason)" }
    },
    b = {
      name = "Buffer",
      s = { "<cmd>lua require('custom/telescope').buffers_with_delete()<cr>", "Search" },
      c = { "<cmd>bd<cr>", "Close" },
      C = { "<cmd>%bd! | e# | bd#<cr>", "Close others" },
      f = { "<cmd>Format<cr>", "Format" },
    },
    w = {
      name = "Workspace",
      s = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Search symbols" },
    },
    l = {
      name = "LSP",
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Search symbols" },
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Actions" },
      r = { "<cmd>Telescope lsp_references<cr>", "All references" },
      d = { "<cmd>Telescope lsp_definitions<cr>", "Definition" },
      v = { "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", "Definition in split" },
    },
    d = {
      name = "Diagnostics",
      d = { "<cmd>Telescope diagnostics<cr>", "Document diagnostics" },
      q = { "<cmd>copen<cr>", "Quickfix" },
    },
    s = {
      name = "Search & Replace",
      o = { "<cmd>GrugFar<cr>", "Open panel" },
      w = { "<cmd>lua require('grug-far').grug_far({ prefills = { search = vim.fn.expand(\"<cword>\") } })<cr>", "Search word" },
    },
    n = {
      name = "Notes",
      f = { "<cmd>Telekasten find_notes<cr>", "Find notes" },
      s = { "<cmd>Telekasten search_notes<cr>", "Search notes" },
      n = { "<cmd>Telekasten new_note<cr>", "New note" },
      t = { "<cmd>Telekasten toggle_todo<cr>", "Toggle TODO" },
      l = { "<cmd>Telekasten insert_link<cr>", "Insert link" },
    },
    t = {
      name = "Tests",
      t = { "<cmd>lua require('neotest').run.run()<cr>", "Run nearest" },
      f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Run file" },
      s = { "<cmd>lua require('neotest').summary.toggle(); vim.cmd('w')<cr>", "Summary" },
      o = { "<cmd>lua require('neotest').output.open({ enter = true })<cr>", "Output" }
    },
    h = { "<cmd>noh<cr>", "Highlight" },
    r = { "<cmd>e!<cr>", "Reload buffer" },
    ["<tab>"] = { "<cmd>e#<cr>", "Previous buffer" },
    [":"] = { "<cmd>Telescope command_history<cr>", "Commmand history" },
    o = { "<cmd>wincmd o<cr>", "Close other windows" },
    q = { "<cmd>qall!<cr>", "Quit" },
    x = { "<cmd>xall!<cr>", "Save and quit" },
  }, { prefix = "<leader>" })
end)
