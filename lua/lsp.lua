local apply_defaults = require("plenary").tbl.apply_defaults

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "<leader>li", vim.lsp.buf.hover, apply_defaults({ desc = "Info" }, bufopts))
  vim.keymap.set("n", "<leader>lS", vim.lsp.buf.signature_help, apply_defaults({ desc = "Signature help" }, bufopts))
  vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, apply_defaults({ desc = "Signature help" }, bufopts))
  vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, apply_defaults({ desc = "Format" }, bufopts))
end

local lsp = require("lspconfig")

lsp.denols.setup({
  on_attach = on_attach,
  root_dir = lsp.util.root_pattern("deno.json*"),
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
})

lsp.rust_analyzer.setup({ on_attach = on_attach })
lsp.hls.setup({ on_attach = on_attach })
lsp.lua_ls.setup({ on_attach = on_attach })
lsp.solargraph.setup({ on_attach = on_attach })
lsp.yamlls.setup({ on_attach = on_attach })
lsp.jsonls.setup({ on_attach = on_attach })
lsp.clangd.setup({ on_attach = on_attach })
