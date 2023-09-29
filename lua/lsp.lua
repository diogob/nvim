local apply_defaults = require("plenary").tbl.apply_defaults

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, apply_defaults({ desc = "Info" }, bufopts))
  vim.keymap.set('n', '<leader>li', vim.lsp.buf.hover, apply_defaults({ desc = "Info" }, bufopts))
  vim.keymap.set('n', '<leader>lR', vim.lsp.buf.rename, apply_defaults({ desc = "Rename" }, bufopts))
  vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end,
    apply_defaults({ desc = "Format" }, bufopts))

  -- workspace
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, apply_defaults({ desc = "Add folder" }, bufopts))
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
    apply_defaults({ desc = "Remove folder" }, bufopts))
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, apply_defaults({ desc = "List folders" }, bufopts))

  -- LSP Signature plugin
  require "lsp_signature".on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "rounded"
    }
  }, bufnr)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp = require('lspconfig')

lsp.denols.setup {
  on_attach = on_attach,
  root_dir = lsp.util.root_pattern("deno.json"),
  capabilities = capabilities,
  init_options = {
    lint = true,
  },
}
vim.g.markdown_fenced_languages = { -- required by denols config
  "ts=typescript"
}
lsp.eslint.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lsp.tsserver.setup {
  on_attach = on_attach,
  root_dir = lsp.util.root_pattern("package.json"),
  capabilities = capabilities,
  init_options = {
    lint = true,
  },
  single_file_support = false
}
lsp.hls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}
lsp.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}
lsp.solargraph.setup {
  on_attach = on_attach,
  capabilities = capabilities
}
lsp.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities
}
lsp.yamlls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}
