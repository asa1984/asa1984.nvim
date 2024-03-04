return {
	{ name = "twilight.nvim", dir = "@twilight_nvim@" },

	{
		name = "zen-mode.nvim",
		dir = "@zen_mode_nvim@",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
			},
		},
	},

	-- Highlight color codes
	{
		name = "nvim-highlight-colors",
		dir = "@nvim_highlight_colors@",
		event = "BufRead",
		opts = { enable_tailwind = true },
	},
}
