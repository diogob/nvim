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

  wk.add(
    {
      { "<leader>:",     "<cmd>Telescope command_history<cr>",                                                                desc = "Commmand history" },
      { "<leader><tab>", "<cmd>e#<cr>",                                                                                       desc = "Previous buffer" },
      { "<leader>b",     group = "Buffer" },
      { "<leader>bC",    "<cmd>%bd! | e# | bd#<cr>",                                                                          desc = "Close others" },
      { "<leader>bc",    "<cmd>bd<cr>",                                                                                       desc = "Close" },
      { "<leader>bf",    "<cmd>Format<cr>",                                                                                   desc = "Format" },
      { "<leader>bs",    "<cmd>lua require('custom/telescope').buffers_with_delete()<cr>",                                    desc = "Search" },
      { "<leader>c",     group = "Config" },
      { "<leader>cc",    "<cmd>e $MYVIMRC<cr>",                                                                               desc = "Edit init.vim" },
      { "<leader>cp",    "<cmd>Mason<cr>",                                                                                    desc = "External Packages (Mason)" },
      { "<leader>d",     group = "Diagnostics" },
      { "<leader>dd",    "<cmd>Telescope diagnostics<cr>",                                                                    desc = "Document diagnostics" },
      { "<leader>dq",    "<cmd>copen<cr>",                                                                                    desc = "Quickfix" },
      { "<leader>e",    "<cmd>Telescope emoji<cr>",                                                                           desc = "Insert emoji" },
      { "<leader>f",     group = "File" },
      { "<leader>fe",    "<cmd>e %:p:h<cr>",                                                                                  desc = "Explore" },
      { "<leader>ff",    "<cmd>Telescope find_files wrap_results=true<cr>",                                                   desc = "Find File" },
      { "<leader>fr",    "<cmd>Telescope oldfiles<cr>",                                                                       desc = "Open Recent File" },
      { "<leader>fs",    "<cmd>Telescope live_grep<cr>",                                                                      desc = "Search" },
      { "<leader>g",     group = "Git" },
      { "<leader>gB",    "<cmd>Git blame<cr>",                                                                                desc = "Blame" },
      { "<leader>gF",    "<cmd>0GcLog<cr>",                                                                                   desc = "File History" },
      { "<leader>gH",    "<cmd>Gclog<cr>",                                                                                    desc = "Project History" },
      { "<leader>gR",    "<cmd>Gread<cr>",                                                                                    desc = "Reset buffer" },
      { "<leader>gS",    "<cmd>Gwrite<cr>",                                                                                   desc = "Stage buffer" },
      { "<leader>gc",    "<cmd>Git commit<cr>",                                                                               desc = "Commit" },
      { "<leader>gd",    "<cmd>Gitsigns preview_hunk<cr>",                                                                    desc = "Hunk diff" },
      { "<leader>gf",    "<cmd>Telescope git_status<cr>",                                                                     desc = "Changed files" },
      { "<leader>gh",    "<cmd>Gitsigns setqflist<cr>",                                                                       desc = "List hunks" },
      { "<leader>gl",    group = "List" },
      { "<leader>glb",   "<cmd>Telescope git_branches<cr>",                                                                   desc = "Branches" },
      { "<leader>glc",   "<cmd>Telescope git_commits<cr>",                                                                    desc = "Commits" },
      { "<leader>gls",   "<cmd>Telescope git_stash<cr>",                                                                      desc = "Stash" },
      { "<leader>gm",    "<cmd>Git mergetool<cr>",                                                                            desc = "Merge Tool" },
      { "<leader>gr",    "<cmd>Gitsigns reset_hunk<cr>",                                                                      desc = "Reset hunk" },
      { "<leader>gs",    "<cmd>Gitsigns stage_hunk<cr>",                                                                      desc = "Stage hunk" },
      { "<leader>h",     "<cmd>noh<cr>",                                                                                      desc = "Highlight" },
      { "<leader>l",     group = "LSP" },
      { "<leader>la",    "<cmd>lua vim.lsp.buf.code_action()<cr>",                                                            desc = "Code Actions" },
      { "<leader>ld",    "<cmd>Telescope lsp_definitions<cr>",                                                                desc = "Definition" },
      { "<leader>lr",    "<cmd>Telescope lsp_references<cr>",                                                                 desc = "All references" },
      { "<leader>ls",    "<cmd>Telescope lsp_document_symbols<cr>",                                                           desc = "Search symbols" },
      { "<leader>lv",    "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>",                                                    desc = "Definition in split" },
      { "<leader>n",     group = "Notes" },
      { "<leader>nf",    "<cmd>Telekasten find_notes<cr>",                                                                    desc = "Find notes" },
      { "<leader>nl",    "<cmd>Telekasten insert_link<cr>",                                                                   desc = "Insert link" },
      { "<leader>nn",    "<cmd>Telekasten new_note<cr>",                                                                      desc = "New note" },
      { "<leader>ns",    "<cmd>Telekasten search_notes<cr>",                                                                  desc = "Search notes" },
      { "<leader>nt",    "<cmd>Telekasten toggle_todo<cr>",                                                                   desc = "Toggle TODO" },
      { "<leader>o",     "<cmd>wincmd o<cr>",                                                                                 desc = "Close other windows" },
      { "<leader>q",     "<cmd>qall!<cr>",                                                                                    desc = "Quit" },
      { "<leader>r",     "<cmd>e!<cr>",                                                                                       desc = "Reload buffer" },
      { "<leader>s",     group = "Search & Replace" },
      { "<leader>so",    "<cmd>GrugFar<cr>",                                                                                  desc = "Open panel" },
      { "<leader>sw",    "<cmd>lua require('grug-far').grug_far({ prefills = { search = vim.fn.expand(\"<cword>\") } })<cr>", desc = "Search word" },
      { "<leader>t",     group = "Tests" },
      { "<leader>tf",    "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",                                       desc = "Run file" },
      { "<leader>to",    "<cmd>lua require('neotest').output.open({ enter = true })<cr>",                                     desc = "Output" },
      { "<leader>ts",    "<cmd>lua require('neotest').summary.toggle(); vim.cmd('w')<cr>",                                    desc = "Summary" },
      { "<leader>tt",    "<cmd>lua require('neotest').run.run()<cr>",                                                         desc = "Run nearest" },
      { "<leader>w",     group = "Workspace" },
      { "<leader>ws",    "<cmd>Telescope lsp_workspace_symbols<cr>",                                                          desc = "Search symbols" },
      { "<leader>x",     "<cmd>xall!<cr>",                                                                                    desc = "Save and quit" },
    }

  )
end)
