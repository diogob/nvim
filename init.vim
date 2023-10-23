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
set signcolumn=yes:2
set updatetime=300

colorscheme nightfox

sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=

lua << EOF
require("plugins")
require("lsp")
require("keymaps")
EOF

autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" notification after file change
autocmd FileChangedShellPost * lua vim.notify("File changed on disk. Buffer reloaded.")

autocmd FileType typescript,typescriptreact compiler tsc | setlocal makeprg=npx\ tsc\ --noEmit\ --pretty\ false

" fix lingering netrw buffers
autocmd FileType netrw setl bufhidden=wipe
let g:netrw_fastbrowse=0

"fold with treesitter
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable " Disable folding at startup.
