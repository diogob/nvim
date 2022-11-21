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
  -- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Grep" })
  vim.keymap.set('n', '<leader>lD', vim.lsp.buf.declaration, apply_defaults({ desc = "Declaration" }, bufopts))
  vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, apply_defaults({ desc = "Definition" }, bufopts))
  vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, apply_defaults({ desc = "Hove" }, bufopts))
  vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, apply_defaults({ desc = "Implementation" }, bufopts))
  vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, apply_defaults({ desc = "Type definition" }, bufopts))
  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, apply_defaults({ desc = "Rename" }, bufopts))
  vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, apply_defaults({ desc = "Code Action" }, bufopts))
  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, apply_defaults({ desc = "References" }, bufopts))
  vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end,
    apply_defaults({ desc = "Format" }, bufopts))

  -- workspace
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, apply_defaults({ desc = "Add folder" }, bufopts))
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
    apply_defaults({ desc = "Remove folder" }, bufopts))
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, apply_defaults({ desc = "List folders" }, bufopts))
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp = require('lspconfig')
lsp.denols.setup {
  on_attach = on_attach,
  root_dir = lsp.util.root_pattern("deno.json"),
  capabilities = capabilities
}
vim.g.markdown_fenced_languages = { -- required by denols config
  "ts=typescript"
}
lsp.tsserver.setup {
  on_attach = on_attach,
  root_dir = lsp.util.root_pattern("package.json"),
  capabilities = capabilities
}
lsp.hls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}
require 'lspconfig'.sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities
}
