return {
	name = "telescope.nvim",
	dir = "@telescope_nvim@",
	dependencies = {
		{ name = "plenary.nvim", dir = "@plenary_nvim@" },
		{ name = "telescope-file-browser.nvim", dir = "@telescope_file_browser_nvim@" },
	},
	opts = function()
		local telescope_actions = require("telescope.actions")
		return {
			defaults = {
				file_ignore_patterns = {
					"node_modules",
					".git",
				},
				mappings = {
					n = {
						["q"] = telescope_actions.close,
					},
				},
			},
		}
	end,
}
