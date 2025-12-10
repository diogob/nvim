local apply_defaults = require("plenary").tbl.apply_defaults

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

vim.lsp.config('denols', {
	on_attach = on_attach,
	root_dir = vim.fs.root(0, {"deno.json*"}),
	init_options = {
		lint = true,
		documentFormatting = false,
		documentRangeFormatting = false,
	},
})
vim.g.markdown_fenced_languages = { -- required by denols config
	"ts=typescript",
}
vim.lsp.config('eslint', {
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

vim.lsp.config('ts_ls', {
	on_attach = on_attach,
	root_dir = vim.fs.root(0, {"package.json"}),
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

vim.lsp.config('tailwindcss', {
	on_attach = on_attach,
  root_dir = vim.fs.root(0,
    {"tailwind.config.js",
      "tailwind.config.cjs",
      "tailwind.config.mjs",
      "tailwind.config.ts",
      "postcss.config.js",
      "postcss.config.cjs",
      "postcss.config.mjs",
      "postcss.config.ts"}
  ),
})

vim.lsp.config('hls', { on_attach = on_attach })
vim.lsp.config('lua_ls', {
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = { enable = true },
		},
	},
})
vim.lsp.config('ruby_lsp', { on_attach = on_attach })
vim.lsp.config('yamlls', { on_attach = on_attach })
vim.lsp.config('jsonls', { on_attach = on_attach })
vim.lsp.config('clangd', { on_attach = on_attach })
vim.lsp.config('gopls', { on_attach = on_attach })
vim.lsp.config('pylsp', { on_attach = on_attach })

vim.lsp.enable('ruby_lsp')
vim.lsp.enable('lua_ls')
vim.lsp.enable('hls')
