local get_icon = require("utils").get_icon
return {
	-- Startup
	{
		name = "alpha.nvim",
		dir = "@alpha_nvim@",
		event = "VimEnter",
		opts = function()
			local theme = require("alpha.themes.theta")
			local config = theme.config
			local button = require("alpha.themes.dashboard").button
			local logo = {
				"                                                     ",
				"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
				"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
				"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
				"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
				"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
				"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
				"                                                     ",
			}
			local buttons = {
				type = "group",
				val = {
					{ type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
					{ type = "padding", val = 1 },
					button("f", get_icon("Search") .. "  Telescope", "<cmd>Telescope find_files<cr>"),
					button("r", get_icon("SearchText") .. "  Ripgrep", "<cmd>Telescope live_grep<cr>"),
					button("l", get_icon("Lazy") .. " Lazy", "<cmd>Lazy<cr>"),
					button("q", get_icon("BufferClose") .. "  Quit", "<cmd>qa<cr>"),
				},
				position = "center",
			}
			config.layout[2].val = logo
			config.layout[6] = buttons
			return config
		end,
	},

	-- Terminal
	{
		name = "toggleterm.nvim",
		dir = "@toggleterm_nvim@",
		cmd = "ToggleTerm",
		opts = {
			size = 10,
			shading_factor = 2,
			open_mapping = [[<f7>]],
			direction = "float",
			float_opts = {
				border = "curved",
			},
		},
	},

	-- Indent
	{
		name = "indent-blankline.nvim",
		dir = "@indent_blankline_nvim@",
		event = "BufRead",
		main = "ibl",
		opts = {
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"startify",
					"aerial",
					"alpha",
					"dashboard",
					"lazy",
					"neogitstatus",
					"NvimTree",
					"neo-tree",
					"Trouble",
				},
			},
			-- context_patterns = {
			--   "class",
			--   "return",
			--   "function",
			--   "method",
			--   "^if",
			--   "^while",
			--   "jsx_element",
			--   "^for",
			--   "^object",
			--   "^table",
			--   "block",
			--   "arguments",
			--   "if_statement",
			--   "else_clause",
			--   "jsx_element",
			--   "jsx_self_closing_element",
			--   "try_statement",
			--   "catch_clause",
			--   "import_statement",
			--   "operation_type",
			-- },
		},
	},

	-- Fold
	-- {
	--   name = "nvim-ufo",
	--   dir = "@nvim_ufo@",
	--   event = "BufReadPost",
	--   dependencies = {
	--     { name = "promise-async", dir = "@promise_async@" },
	--     {
	--       name = "statuscol.nvim",
	--       dir = "@statuscol_nvim@",
	--       config = function()
	--         local builtin = require("statuscol.builtin")
	--         require("statuscol").setup({
	--           relculright = true,
	--           segments = {
	--             { text = { builtin.foldfunc },      click = "v:lua.ScFa" },
	--             { text = { "%s" },                  click = "v:lua.ScSa" },
	--             { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
	--           },
	--         })
	--       end,
	--     },
	--   },
	--   opts = {
	--     provider_selector = function()
	--       return { "treesitter", "indent" }
	--     end,
	--   },
	-- },

	-- Scrollbar
	{
		name = "nvim-scrollbar",
		dir = "@nvim_scrollbar@",
		event = "BufReadPost",
		dependencies = { name = "nvim-hlslens", dir = "@nvim_hlslens@" },
		config = function()
			local colors = require("tokyonight.colors").setup()
			require("scrollbar").setup({
				hide_if_all_visible = true,
				excluded_buftypes = {
					"TelescopePrompt",
					"neo-tree",
					"noice",
					"notify",
					"prompt",
					"terminal",
				},
				handle = { color = colors.bg_highlight },
				marks = {
					Search = { color = colors.orange },
					Error = { color = colors.error },
					Warn = { color = colors.warning },
					Info = { color = colors.info },
					Hint = { color = colors.hint },
					Misc = { color = colors.purple },
				},
			})

			-- Search highlight
			require("scrollbar.handlers.search").setup({ -- wrapper for hlslens.nvim
				calm_down = true,
			})
		end,
	},

	-- File explorer
	{
		name = "neo-tree.nvim",
		dir = "@neo_tree_nvim@",
		cmd = "Neotree",
		dependencies = {
			{ name = "plenary.nvim", dir = "@plenary_nvim@" },
			{ name = "nvim-web-devicons", dir = "@nvim_web_devicons@" },
			{ name = "nui.nvim", dir = "@nui_nvim@" },
		},
		opts = function()
			local get_icon = require("utils").get_icon
			return {
				close_if_last_window = true,
				window = {
					width = 30,
					mappings = {
						["<space>"] = false,
					},
				},
				filesystem = {
					filtered_items = {
						hide_dotfiles = false,
					},
				},
				default_component_configs = {
					indent = { padding = 0 },
					icon = {
						folder_closed = get_icon("FolderClosed"),
						folder_open = get_icon("FolderOpen"),
						folder_empty = get_icon("FolderEmpty"),
						folder_empty_open = get_icon("FolderEmpty"),
						default = get_icon("DefaultFile"),
					},
					modified = { symbol = get_icon("FileModified") },
					git_status = {
						symbols = {
							added = get_icon("GitAdd"),
							deleted = get_icon("GitDelete"),
							modified = get_icon("GitChange"),
							renamed = get_icon("GitRenamed"),
							untracked = get_icon("GitUntracked"),
							ignored = get_icon("GitIgnored"),
							unstaged = get_icon("GitUnstaged"),
							staged = get_icon("GitStaged"),
							conflict = get_icon("GitConflict"),
						},
					},
				},
			}
		end,
	},

	-- Better LSP UI
	{
		name = "lspsaga.nvim",
		dir = "@lspsaga_nvim@",
		event = "LspAttach",
		dependencies = {
			{ name = "nvim-treesitter", dir = "@nvim_treesitter@" },
			{ name = "nvim-web-devicons", dir = "@nvim_web_devicons@" },
		},
		opts = function()
			return {
				ui = {
					border = "rounded",
					code_action = get_icon("DiagnosticHint"),
				},
				lightbulb = {
					sign = false,
				},
			}
		end,
	},

	{
		name = "gitsigns.nvim",
		dir = "@gitsigns_nvim@",
		event = { "BufRead", "BufNewFile" },
		opts = {},
	},
}
