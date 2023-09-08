-- Configure plugins from start directory here
local function treesitter_statusline()
  return vim.fn['nvim_treesitter#statusline'](90)
end
require("lualine").setup({
  sections = { lualine_c = { 'filename', treesitter_statusline } }
})
require("mason").setup()
require("nvim-web-devicons").setup()
require 'nvim-treesitter.configs'.setup({
  ensure_installed = { "lua", "vim", "vimdoc", "query", "typescript", "haskell" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn", -- set to `false` to disable one of the mappings
      node_incremental = "gnn",
      scope_incremental = "grc",
      node_decremental = "gnm",
    },
  },
})

-- Next we configure the opt plugins

-- Source plugin and its configuration immediately
-- @param plugin String with name of plugin as subdirectory in 'pack'
local packadd = function(plugin)
  -- Add plugin. Using `packadd!` during startup is better for initialization
  -- order (see `:h load-plugins`). Use `packadd` otherwise to also force
  -- 'plugin' scripts to be executed right away.
  -- local command = vim.v.vim_did_enter == 1 and 'packadd' or 'packadd!'
  local command = 'packadd'
  vim.cmd(string.format([[%s %s]], command, plugin))

  -- Try execute its configuration
  -- NOTE: configuration file should have the same name as plugin directory
  pcall(require, 'ec.configs.' .. plugin)
end

-- Defer plugin source right after Vim is loaded
--
-- This reduces time before a fully functional start screen is shown. Use this
-- for plugins that are not directly related to startup process.
--
-- @param plugin String with name of plugin as subdirectory in 'pack'
local packadd_defer = function(plugin)
  vim.schedule(function() packadd(plugin) end)
end

packadd_defer('nvim-code-action-menu')
packadd_defer('nvim-lightbulb')
packadd_defer('lsp_signature')
packadd_defer('auto-save')

packadd_defer('null-ls')
vim.schedule(function()
  local null_ls = require("null-ls")
  local sources = {
    null_ls.builtins.formatting.prettier,
  }
  null_ls.setup({ sources = sources })
end)

packadd_defer('nvim-notify')
vim.schedule(function()
  vim.notify = require("notify")
end)

packadd_defer('nvim-surround')
vim.schedule(function()
  require("nvim-surround").setup()
end)

packadd_defer('mini.pairs')
vim.schedule(function()
  require('mini.pairs').setup()
end)

packadd_defer('mini.comment')
vim.schedule(function()
  require('mini.comment').setup({
    options = {
      custom_commentstring = nil,
      ignore_blank_line = true,
      start_of_line = false,
      pad_comment_parts = true,
    },
  })
end)

packadd_defer('mini.splitjoin')
vim.schedule(function()
  require('mini.splitjoin').setup()
end)


packadd_defer('trouble')
vim.schedule(function()
  require('trouble').setup()
end)

packadd_defer('telescope')
vim.schedule(function()
  local trouble = require("trouble.providers.telescope")
  local telescope = require("telescope")

  telescope.setup {
    defaults = {
      layout_strategy = 'vertical',
      layout_config = {
        vertical = {
          prompt_position = 'top',
          mirror = true
        },
      },
      mappings = {
        i = { ["<c-t>"] = trouble.open_with_trouble },
        n = { ["<c-t>"] = trouble.open_with_trouble },
      },
    },
  }
end)

packadd_defer('which-key')
vim.schedule(function()
  require("which-key").setup({
    window = {
      border = "single"
    }
  })
end)


packadd_defer('nvim-spectre')
vim.schedule(function()
  require('spectre').setup()
end)

packadd_defer('gitsigns')
vim.schedule(function()
  require('gitsigns').setup({
    sign_priority = 100,
    current_line_blame = true
  })
end)
packadd_defer('vim-fugitive')

packadd_defer('diffview')
vim.schedule(function()
  require('diffview').setup()
end)

packadd('nvim-cmp')
packadd('luasnip')
packadd('cmp_luasnip')
packadd('cmp-buffer')
packadd('cmp-nvim-lsp')
packadd('cmp-path')
packadd('cmp-emoji')

vim.schedule(function()
  local cmp = require('cmp')

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
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
      { name = 'luasnip' },
      { name = 'emoji' }, -- For vsnip users.
      { name = 'buffer' },
      { name = 'path' },
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
end)

-- Telekasten
packadd_defer('telekasten')
vim.schedule(function()
  require('telekasten').setup({
    home = vim.fn.expand("~/zettelkasten"),
  })
end)
