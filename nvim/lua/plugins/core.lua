return {
	-- Colorscheme
	{
		name = "tokyonight.nvim",
		dir = "@tokyonight_nvim@",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tokyonight-moon]])
		end,
	},

	-- Docs (ja)
	{
		name = "vimdoc-ja",
		dir = "@vimdoc_ja@",
		ft = "help",
	},

	-- Better escape
	{
		name = "better-escape.nvim",
		dir = "@better_escape_nvim@",
		event = "InsertCharPre",
		opts = {
			mapping = { "jj" },
			timeout = 200,
		},
	},

	-- Better pane navigation
	{
		name = "smart-splits.nvim",
		dir = "@smart_splits_nvim@",
		opts = {
			ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
			ignored_buftypes = { "nofile" },
		},
	},

	-- Better buffer remove
	{ name = "mini.bufremove", dir = "@mini_bufremove@" },

	-- Comment
	{
		name = "Comment.nvim",
		dir = "@comment_nvim@",
		event = "BufRead",
		dependencies = {
			{
				name = "nvim-ts-context-commentstring",
				dir = "@nvim_ts_context_commentstring@",
				opts = { enable_autocmd = false },
			},
		},
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},

	-- Auto enclose deliminators
	{
		name = "nvim-autopairs",
		dir = "@nvim_autopairs@",
		event = "InsertEnter",
		opts = {
			map_c_h = true,
		},
	},

	-- Auto enclose JSX tags
	{
		name = "nvim-ts-autotag",
		dir = "@nvim_ts_autotag@",
		event = "InsertEnter",
		config = function()
			require("nvim-treesitter.configs").setup({
				autotag = {
					enable = true,
				},
			})
		end,
	},
}
