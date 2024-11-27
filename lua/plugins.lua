-- Configure plugins from start directory here
local function treesitter_statusline()
	return vim.fn["nvim_treesitter#statusline"](90)
end
require("lualine").setup({
	sections = { lualine_c = { "filename", treesitter_statusline } },
})
require("mason").setup()
require("nvim-web-devicons").setup()
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"vim",
		"vimdoc",
		"query",
		"typescript",
		"haskell",
		"tsx",
		"yaml",
		"json",
		"markdown",
		"bash",
		"git_rebase",
		"csv",
		"sql",
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-Up>", -- set to `false` to disable one of the mappings
			node_incremental = "<C-Up>",
			scope_incremental = "grc",
			node_decremental = "<C-Down>",
		},
	},
})

-- Next we configure the opt plugins

-- Source plugin and its configuration immediately
-- @param plugin String with name of plugin as subdirectory in 'pack'
local packadd = function(plugin)
	local command = "packadd"
	vim.cmd(string.format([[%s %s]], command, plugin))
end

-- Defer plugin source right after Vim is loaded
local packadd_defer = function(args)
	setmetatable(args, { __index = { init_function = function() end, keymaps = {} } })
	vim.schedule(function()
		packadd(args.plugin)
		args.init_function()
		for _, keymap in pairs(args.keymaps) do
			vim.api.nvim_set_keymap(keymap.mode or "n", keymap.keys, keymap.command, keymap.options or {})
		end
	end)
end

packadd_defer({
	plugin = "blink.cmp",
	init_function = function()
		require("blink.cmp").setup({
			highlight = {
				-- sets the fallback highlight groups to nvim-cmp's highlight groups
				-- useful for when your theme doesn't support blink.cmp
				-- will be removed in a future release, assuming themes add support
				use_nvim_cmp_as_default = true,
			},
			keymap = { preset = "enter" }, -- trigger = { signature_help = { enabled = true } },
		})
	end,
})

packadd_defer({
	plugin = "which-key",
	init_function = function()
		require("which-key").setup({
			win = {
				border = "single",
			},
		})
	end,
})
packadd_defer({ plugin = "nvim-treesitter-context" })

-- From this line it should be safe to remove without startup errors (keymaps might still be bogus)
packadd_defer({
	plugin = "oil",
	init_function = function()
		require("oil").setup()
	end,
})

packadd_defer({
	plugin = "nvim-lightbulb",
	init_function = function()
		require("nvim-lightbulb").setup({
			autocmd = { enabled = true },
		})
	end,
})

packadd_defer({
	plugin = "auto-save",
	init_function = function()
		require("auto-save").setup({
			debounce_delay = 1000,
		})
	end,
})

packadd_defer({
	plugin = "conform",
	init_function = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				-- Use a sub-list to run only the first available formatter
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				typescriptreact = { { "prettierd", "prettier" } },
				ruby = { { "rubocop" } },
			},
		})
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		vim.api.nvim_create_user_command("Format", function(args)
			local range = nil
			if args.count ~= -1 then
				local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
				range = {
					start = { args.line1, 0 },
					["end"] = { args.line2, end_line:len() },
				}
			end
			require("conform").format({ async = true, lsp_fallback = true, range = range })
		end, { range = true })

		vim.api.nvim_set_keymap("n", "<leader>bf", "<cmd>Format<CR>", { desc = "Format buffer" })
	end,
})

packadd_defer({
	plugin = "nvim-notify",
	init_function = function()
		vim.notify = require("notify")
	end,
})

packadd_defer({
	plugin = "ultimate-autopair",
	init_function = function()
		require("ultimate-autopair").setup()
	end,
})

packadd_defer({
	plugin = "mini.splitjoin",
	init_function = function()
		require("mini.splitjoin").setup()
	end,
})

packadd_defer({
	plugin = "nvim-surround",
	init_function = function()
		require("nvim-surround").setup({
			keymaps = {
				insert = "<C-g>s",
				insert_line = "<C-g>S",
				normal = "sa",
				normal_cur = "ss",
				normal_line = "sS",
				normal_cur_line = "sSS",
				visual = "s",
				visual_line = "S",
				delete = "sd",
				change = "sc",
				change_line = "sC",
			},
		})
	end,
})

packadd_defer({
	plugin = "telescope",
	init_function = function()
		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				prompt_prefix = " 🔍 ",
				selection_caret = "❯ ",
				layout_strategy = "vertical",
				layout_config = {
					vertical = {
						prompt_position = "top",
						mirror = true,
					},
				},
			},
		})

		-- keymaps to open
		vim.api.nvim_set_keymap("n", "<leader>:", "<cmd>Telescope command_history<CR>", { desc = "Command history" })
		vim.api.nvim_set_keymap("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", { desc = "Document diagnostics" })
		vim.api.nvim_set_keymap(
			"n",
			"<leader>ff",
			"<cmd>Telescope find_files wrap_results=true<CR>",
			{ desc = "Find file" }
		)
		vim.api.nvim_set_keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })
		vim.api.nvim_set_keymap("n", "<leader>fs", "<cmd>Telescope live_grep<CR>", { desc = "Search in files" })
		vim.api.nvim_set_keymap("n", "<leader>gf", "<cmd>Telescope git_status<CR>", { desc = "Changed files" })
		vim.api.nvim_set_keymap("n", "<leader>gf", "<cmd>Telescope git_status<CR>", { desc = "Changed files" })
		vim.api.nvim_set_keymap("n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", { desc = "Definition" })
		vim.api.nvim_set_keymap("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", { desc = "All references" })
		vim.api.nvim_set_keymap(
			"n",
			"<leader>ls",
			"<cmd>Telescope lsp_document_symbols<CR>",
			{ desc = "Search symbol" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>bs",
			"<cmd>lua require('custom/telescope').buffers_with_delete()<CR>",
			{ desc = "Buffers" }
		)

		-- Manipulate text case
		packadd("text-case")
		require("textcase").setup({})
		-- Select emojis
		packadd("emoji.nvim")
		require("emoji").setup({
			plugin_path = vim.fn.expand("$HOME/.config/nvim/pack/plugins/opt/"),
		})

		require("telescope").load_extension("textcase")
		vim.api.nvim_set_keymap("n", "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
		vim.api.nvim_set_keymap("v", "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })

		require("telescope").load_extension("emoji")
	end,
	keymaps = { { keys = "<leader>e", command = "<cmd>Telescope emoji<CR>", options = { desc = "Insert emoji" } } },
})

packadd_defer({
	plugin = "grug-far",
	init_function = function()
		require("grug-far").setup()

		vim.api.nvim_set_keymap("n", "<leader>so", "<cmd>GrugFar<CR>", { desc = "Search in project" })
		vim.api.nvim_set_keymap(
			"n",
			"<leader>sw",
			"<cmd>lua require('grug-far').grug_far({ prefills = { search = vim.fn.expand(\"<cword>\") } })<CR>",
			{ desc = "Search word" }
		)
	end,
})

packadd_defer({
	plugin = "gitsigns",
	init_function = function()
		require("gitsigns").setup({
			sign_priority = 100,
			current_line_blame = true,
		})
		vim.api.nvim_set_keymap("n", "]h", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next Git Hunk" })
		vim.api.nvim_set_keymap("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Previous Git Hunk" })
		vim.api.nvim_set_keymap("n", "<leader>gd", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Hunk diff" })
		vim.api.nvim_set_keymap("n", "<leader>gh", "<cmd>Gitsigns setqflist<cr>", { desc = "List hunks" })
		vim.api.nvim_set_keymap("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunks" })
		vim.api.nvim_set_keymap("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Stage hunks" })
	end,
})

packadd_defer({
	plugin = "vim-fugitive",
	init_function = function()
		vim.api.nvim_set_keymap("n", "<leader>gB", "<cmd>Git blame<cr>", { desc = "Blame" })
		vim.api.nvim_set_keymap("n", "<leader>gF", "<cmd>0GcLog<cr>", { desc = "File history" })
		vim.api.nvim_set_keymap("n", "<leader>gH", "<cmd>Gclog<cr>", { desc = "Project history" })
		vim.api.nvim_set_keymap("n", "<leader>gR", "<cmd>Gread<cr>", { desc = "Reset buffer" })
		vim.api.nvim_set_keymap("n", "<leader>gS", "<cmd>Gwrite<cr>", { desc = "Stage buffer" })
		vim.api.nvim_set_keymap("n", "<leader>gc", "<cmd>Git commit<cr>", { desc = "Commit" })
	end,
})

-- Telekasten
packadd_defer({
	plugin = "telekasten",
	init_function = function()
		require("telekasten").setup({
			home = vim.fn.expand("~/zettelkasten"),
		})

		vim.api.nvim_set_keymap("n", "<leader>nf", "<cmd>Telekasten find_notes<cr>", { desc = "Find notes" })
		vim.api.nvim_set_keymap("n", "<leader>nl", "<cmd>Telekasten insert_link<cr>", { desc = "Insert link" })
		vim.api.nvim_set_keymap("n", "<leader>nn", "<cmd>Telekasten new_note<cr>", { desc = "New note" })
		vim.api.nvim_set_keymap("n", "<leader>ns", "<cmd>Telekasten search_notes<cr>", { desc = "Search notes" })
		vim.api.nvim_set_keymap("n", "<leader>nt", "<cmd>Telekasten toggle_todo<cr>", { desc = "Toggle TODO" })
	end,
})

packadd_defer({
	plugin = "flash",
	init_function = function()
		require("flash").setup()
		vim.keymap.set("n", "gj", function()
			require("flash").jump({
				remote_op = {
					restore = true,
					motion = true,
				},
			})
		end, { desc = "Jump" })
		require("flash").toggle(false)
	end,
})

--test runner
packadd_defer({
	plugin = "neotest",
	init_function = function()
		packadd("neotest-vitest")
		packadd("neotest-haskell")
		require("neotest").setup({
			discovery = {
				enabled = false,
				concurrent = 1,
			},
			adapters = {
				require("neotest-vitest")({
					vitestCommand = "npx vitest",
				}),
				require("neotest-haskell")({
					frameworks = { "hspec" },
				}),
			},
		})

		vim.api.nvim_set_keymap(
			"n",
			"<leader>tf",
			"<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
			{ desc = "Run file tests" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>to",
			"<cmd>lua require('neotest').output.open({ enter = true })<cr>",
			{ desc = "Test output" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>ts",
			"<cmd>lua require('neotest').summary.toggle(); vim.cmd('w')<cr>",
			{ desc = "Test summary" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tt",
			"<cmd>lua require('neotest').run.run()<cr>",
			{ desc = "Run nearest test" }
		)
	end,
})

-- Improve built-in nvim comments
packadd_defer({
	plugin = "ts-comments",
	init_function = function()
		require("ts-comments").setup()
	end,
})

-- Incremental LSP rename
packadd_defer({
	plugin = "inc-rename",
	init_function = function()
		require("inc_rename").setup()
		vim.keymap.set("n", "<leader>lR", function()
			return ":IncRename " .. vim.fn.expand("<cword>")
		end, { expr = true, desc = "Rename" }, { noremap = true, silent = true })
	end,
})
