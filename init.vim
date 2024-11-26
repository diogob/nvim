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

"fold with treesitter
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable " Disable folding at startup.

colorscheme tokyonight-moon

sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" notification after file change
autocmd FileChangedShellPost * lua vim.notify("File changed on disk. Buffer reloaded.")

" configure tsc as make command for typescript
autocmd FileType typescript,typescriptreact compiler tsc | setlocal makeprg=npx\ tsc\ --noEmit\ --pretty\ false

" fix lingering netrw buffers
autocmd FileType netrw setl bufhidden=wipe
let g:netrw_fastbrowse=0

" Add underline for treesitter context so we do not depend too much on the
" colorscheme 
hi TreesitterContextBottom gui=underline guisp=Grey

lua << EOF
require("plugins")
require("lsp")
require("keymaps")
EOF

