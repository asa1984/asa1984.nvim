return {
	{
		name = "nvim-treesitter",
		dir = "@nvim_treesitter@",
		event = "BufRead",
		config = function()
			vim.opt.runtimepath:append("@treesitter_parsers@")
		end,
	},

	-- Highlight inline code of home-manager config
	{ name = "hmts.nvim", dir = "@hmts_nvim@", event = "BufRead", version = "*" },
}
