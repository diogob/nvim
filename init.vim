set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set number
set termguicolors
set clipboard+=unnamedplus
set cursorline
set smartindent
set smarttab
set autoread
set syntax=on

colorscheme dracula

sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=

lua << EOF
require("plugins")
require("lsp")
require("keymaps")


require("bufferline").setup()
local function treesitter_statusline()
   return vim.fn['nvim_treesitter#statusline'](90)
end
require("lualine").setup({
  options = { theme = 'dracula-nvim' },
  sections = { lualine_c = { 'filename', treesitter_statusline } }
})
require("mason").setup()
require("nvim-web-devicons").setup()
require("vgit").setup()
require("nvim-tree").setup({
  diagnostics = {
    enable = true,
    show_on_dirs = true
  }
})

-- set default notification

-- vgit
vim.o.updatetime = 300
vim.wo.signcolumn = 'yes'

-- treesitter
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
}

-- null-ls


-- cmp
EOF


autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" notification after file change
autocmd FileChangedShellPost * lua vim.notify("File changed on disk. Buffer reloaded.")
