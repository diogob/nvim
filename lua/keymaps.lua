vim.g.mapleader = ' '

local wk = require("which-key")

wk.register({
  f = {
    name = "File",
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    s = { "<cmd>Telescope live_grep<cr>", "Search" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" }
  },
  d = {
    name = "Diagnostics",
    t = { "<cmd>TroubleToggle<cr>", "Toggle" },
    r = { "<cmd>TroubleRefresh<cr>", "Refresh" }
  },
  g = {
    name = "Git",
    d = { "<cmd>VGit buffer_diff_preview<cr>", "Diff" },
    h = { "<cmd>VGit buffer_history_preview<cr>", "History" },
    s = { "<cmd>VGit buffer_hunk_stage<cr>", "Stage hunk" },
    r = { "<cmd>VGit buffer_hunk_reset<cr>", "Revert hunk" },
    u = { "<cmd>VGit buffer_reset<cr>", "Revert buffer" },
    p = { "<cmd>VGit project_diff_preview<cr>", "Project diff" }
  }
}, { prefix = "<leader>" })
