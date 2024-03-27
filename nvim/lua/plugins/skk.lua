return {
	name = "skkeleton",
	dir = "@skkeleton@",
	lazy = false,
	dependencies = {
		{ name = "denops.vim", dir = "@denops_vim@" },
	},
	init = function()
		vim.keymap.set("i", "<C-j>", "<Plug>(skkeleton-enable)")
		vim.keymap.set("c", "<C-j>", "<Plug>(skkeleton-enable)")
		vim.api.nvim_create_autocmd("User", {
			pattern = "skkeleton-initialize-pre",
			callback = function()
				vim.fn["skkeleton#config"]({
					eggLikeNewline = true,
					registerConvertResult = true,
					globalDictionaries = {
						"@skk_dict@",
					},
				})
			end,
		})
	end,
}
