-- General settings
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.wo.number = true
vim.o.termguicolors = true
vim.o.clipboard = "unnamedplus"
vim.wo.cursorline = true
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.autoread = true
vim.o.syntax = "on"
vim.wo.signcolumn = "yes:2"

-- Indenting and Folding with Treesitter
vim.o.foldmethod = "indent"
vim.o.foldenable = false -- Disable folding at startup

-- Colorscheme
vim.cmd("colorscheme tokyonight-moon")

-- Diagnostic signs
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint", linehl = "", numhl = "" })

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line
    if line("'\"") > 0 and line("'\"") <= line("$") then
      vim.cmd("normal! g`\"")
    end
  end,
})

-- Notification after file change
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.")
  end,
})

-- Configure spacing for SQL files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql" },
  callback = function()
    vim.o.tabstop = 4
    vim.o.softtabstop = 4
    vim.o.shiftwidth = 4

    vim.o.foldmethod = "indent"
    vim.o.foldexpr = "nvim_treesitter#foldexpr()"

    vim.o.indentexpr = 'autoindent'
  end,
})

-- Configure TypeScript as make command
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact" },
  callback = function()
    vim.cmd("compiler tsc")
    vim.bo.makeprg = "npx tsc --noemit --pretty false"
  end,
})

-- Fix lingering netrw buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.bo.bufhidden = "wipe"
  end,
})
vim.g.netrw_fastbrowse = 0

-- Highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Add underline for Treesitter context
vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = "grey" })

-- Load external Lua modules
require("plugins")
require("lsp")
require("keymaps")

-- Start Treesitter dynamically for any filetype that has a parser installed
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function(args)
    local function contains(tbl, str)
      for _, v in ipairs(tbl) do
        if v == str then
          return true
        end
      end
      return false
    end
    local parsers = require('nvim-treesitter').get_installed('parsers')
    local lang = args.match  -- same as vim.bo[buf].filetype

    if contains(parsers, lang) then
      vim.treesitter.start(args.buf, lang)

      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
