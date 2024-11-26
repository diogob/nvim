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

colorscheme tokyonight-moon

sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=

lua << EOF
require("plugins")
require("lsp")
require("keymaps")
EOF
"
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" lightbulb configuration
set updatetime=200
autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif

" notification after file change
autocmd FileChangedShellPost * lua vim.notify("File changed on disk. Buffer reloaded.")

" configure tsc as make command for typescript
autocmd FileType typescript,typescriptreact compiler tsc | setlocal makeprg=npx\ tsc\ --noEmit\ --pretty\ false

" fix lingering netrw buffers
autocmd FileType netrw setl bufhidden=wipe
let g:netrw_fastbrowse=0

"fold with treesitter
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable " Disable folding at startup.

" Create text-object `A` which operates on the whole buffer (i.e. All)
" Keeps the cursor position in the same position
function TextObjectAll()
    let g:restore_position = winsaveview()
    normal! ggVG
    " For delete/change ALL, we don't wish to restore cursor position.
    if index(['c','d'], v:operator) == -1
        call feedkeys("\<Plug>(RestoreView)")
    end
endfunction
onoremap A :<C-U>call TextObjectAll()<CR>
nnoremap <silent> <Plug>(RestoreView) :call winrestview(g:restore_position)<CR>

" Add underline for treesitter context so we do not depend too much on the
" colorscheme 
hi TreesitterContextBottom gui=underline guisp=Grey

