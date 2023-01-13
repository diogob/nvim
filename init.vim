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
require("lualine").setup({
  options = { theme = 'dracula-nvim' }
})
require("mason").setup()
require("nvim-autopairs").setup()
require("nvim-web-devicons").setup()
require("nvim-surround").setup()
require("vgit").setup()
require("nvim-tree").setup({
  diagnostics = {
    enable = true,
    show_on_dirs = true
  }
})
require('spectre').setup()
require("symbols-outline").setup()

-- set default notification
vim.notify = require("notify")

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

-- neotest
require("neotest").setup({
	adapters = {
		require("neotest-deno"),
	}
})


-- cmp
local cmp = require('cmp')

cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      { name = 'emoji' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    }),
    enabled = function()
      local context = require 'cmp.config.context'
      -- disable command mode completion
      if vim.api.nvim_get_mode().mode == 'c' then
        return false
      else
        -- disable completion in comments
        return not context.in_treesitter_capture("comment") 
          and not context.in_syntax_group("Comment")
      end
    end
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
EOF


autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" notification after file change
autocmd FileChangedShellPost * lua vim.notify("File changed on disk. Buffer reloaded.")
