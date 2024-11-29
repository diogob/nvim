vim.g.mapleader = " "

vim.keymap.set("n", "[c", function()
	require("treesitter-context").go_to_context()
end, { silent = true, desc = "Previous context" })

-- code navigation
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "Next diagnostic" })
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc = "Previous diagnostic" })
vim.api.nvim_set_keymap("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })
vim.api.nvim_set_keymap("n", "[q", "<cmd>cprevious<cr>", { desc = "Previous quickfix" })

-- replace selection
vim.api.nvim_set_keymap("v", "<C-r>", '"hy:%s/<C-r>h//gc<left><left><left>', { desc = "Replace from selection" })

-- keep line centered when navigatin in normal mode
vim.api.nvim_set_keymap("n", "<Up>", "kzz", { noremap = true })
vim.api.nvim_set_keymap("n", "<Down>", "jzz", { noremap = true })

-- Move lines around
vim.api.nvim_set_keymap("n", "<A-Down>", "<cmd>m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-Up>", "<cmd>m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-Down>", "<Esc><cmd>m .+1<CR>==gi", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-Up>", "<Esc><cmd>m .-2<CR>==gi", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- 3-way diff helpers
vim.api.nvim_set_keymap("n", "g<Right>", ":diffget //2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "g<Left>", ":diffget //3<CR>==", { noremap = true, silent = true })

vim.schedule(function()
	local wk = require("which-key")

	wk.add({
		{ "<leader><tab>", "<cmd>e#<cr>", desc = "Previous buffer" },
		{ "<leader>b", group = "Buffer" },
		{ "<leader>bC", "<cmd>%bd! | e# | bd#<cr>", desc = "Close others" },
		{ "<leader>bc", "<cmd>bd<cr>", desc = "Close" },
		{ "<leader>c", group = "Config" },
		{ "<leader>cc", "<cmd>e $MYVIMRC<cr>", desc = "Edit init.vim" },
		{ "<leader>cp", "<cmd>Mason<cr>", desc = "External Packages (Mason)" },
		{ "<leader>d", group = "Diagnostics" },
		{ "<leader>dq", "<cmd>copen<cr>", desc = "Quickfix" },
		{ "<leader>f", group = "File" },
		{ "<leader>fe", "<cmd>e %:p:h<cr>", desc = "Explore" },
		{ "<leader>g", group = "Git" },
		{ "<leader>gl", group = "List" },
		{ "<leader>h", "<cmd>noh<cr>", desc = "Highlight" },
		{ "<leader>l", group = "LSP" },
		{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Actions" },
		{ "<leader>lv", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", desc = "Definition in split" },
		{ "<leader>n", group = "Notes" },
		{ "<leader>o", "<cmd>wincmd o<cr>", desc = "Close other windows" },
		{ "<leader>q", "<cmd>qall!<cr>", desc = "Quit" },
		{ "<leader>r", "<cmd>e!<cr>", desc = "Reload buffer" },
		{ "<leader>s", group = "Search & Replace" },
		{ "<leader>t", group = "Tests" },
		{ "<leader>x", "<cmd>xall!<cr>", desc = "Save and quit" },
	})
end)
