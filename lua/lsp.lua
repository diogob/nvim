local apply_defaults = require("plenary").tbl.apply_defaults

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "K", vim.lsp.buf.hover, apply_defaults({ desc = "Info" }, bufopts))
  vim.keymap.set("n", "<leader>li", vim.lsp.buf.hover, apply_defaults({ desc = "Info" }, bufopts))
  vim.keymap.set("n", "<leader>lS", vim.lsp.buf.signature_help, apply_defaults({ desc = "Signature help" }, bufopts))
  vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, apply_defaults({ desc = "Signature help" }, bufopts))
  vim.keymap.set("n", "<leader>lR", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
  end, apply_defaults({ expr = true, desc = "Rename" }, bufopts))
  vim.keymap.set("n", "<leader>lf", function()
    vim.lsp.buf.format({ async = true })
  end, apply_defaults({ desc = "Format" }, bufopts))

  -- workspace
  vim.keymap.set(
    "n",
    "<leader>wa",
    vim.lsp.buf.add_workspace_folder,
    apply_defaults({ desc = "Add folder" }, bufopts)
  )
  vim.keymap.set(
    "n",
    "<leader>wr",
    vim.lsp.buf.remove_workspace_folder,
    apply_defaults({ desc = "Remove folder" }, bufopts)
  )
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, apply_defaults({ desc = "List folders" }, bufopts))
end

-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lsp = require("lspconfig")

lsp.denols.setup({
  on_attach = on_attach,
  root_dir = lsp.util.root_pattern("deno.json*"),
  -- capabilities = capabilities,
  init_options = {
    lint = true,
    documentFormatting = false,
    documentRangeFormatting = false,
  },
})
vim.g.markdown_fenced_languages = { -- required by denols config
  "ts=typescript",
}
lsp.eslint.setup({
  on_attach = on_attach,
  -- capabilities = capabilities,
})

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
end

lsp.ts_ls.setup({
  on_attach = on_attach,
  root_dir = lsp.util.root_pattern("package.json"),
  -- capabilities = capabilities,
  init_options = {
    lint = true,
  },
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
  single_file_support = false,
})
-- require("typescript-tools").setup({
--   on_attach = on_attach,
--   root_dir = lsp.util.root_pattern("package.json"),
--   handlers = {
--     ["textDocument/formatting"] = function() end,
--     ["textDocument/rangeFormatting"] = function() end,
--   },
--   single_file_support = false,
-- })
lsp.rust_analyzer.setup({
  on_attach = on_attach,
  -- capabilities = capabilities,
})

lsp.hls.setup({
  on_attach = on_attach,
  -- capabilities = capabilities,
})
lsp.lua_ls.setup({
  on_attach = on_attach,
  -- capabilities = capabilities,
})
lsp.solargraph.setup({
  on_attach = on_attach,
  -- capabilities = capabilities,
})
lsp.tailwindcss.setup({
  on_attach = on_attach,
  root_dir = lsp.util.root_pattern(
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.mjs",
    "tailwind.config.ts",
    "postcss.config.js",
    "postcss.config.cjs",
    "postcss.config.mjs",
    "postcss.config.ts"
  ),
  -- capabilities = capabilities,
})
lsp.yamlls.setup({
  on_attach = on_attach,
  -- capabilities = capabilities,
})
lsp.jsonls.setup({
  on_attach = on_attach,
  -- capabilities = capabilities,
})
