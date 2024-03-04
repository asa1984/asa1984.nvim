return {
	{
		name = "nvim-cmp",
		dir = "@nvim_cmp@",
		event = "InsertEnter",
		dependencies = {
			{ name = "cmp-nvim-lsp", dir = "@cmp_nvim_lsp@" },
			{ name = "cmp-buffer", dir = "@cmp_buffer@" },
			{ name = "cmp-cmdline", dir = "@cmp_cmdline@" },
			{ name = "cmp-path", dir = "@cmp_path@" },
			{ name = "cmp_luasnip", dir = "@cmp_luasnip@" },
			{ name = "vim-vsnip", dir = "@vim_vsnip@" },
			{ name = "lspkind.nvim", dir = "@lspkind_nvim@" },
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")

			cmp.setup({
				formatting = {
					format = lspkind.cmp_format({
						mode = "text",
					}),
				},
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<C-l>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "vsnip" },
					{ name = "path" },
				},
			})

			-- Cmdline
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "cmdline" },
				}),
			})
		end,
	},

	-- GitHub copilot
	{
		name = "copilot.lua",
		dir = "@copilot_lua@",
		event = "InsertEnter",
		opts = {
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = "<C-j>",
					accept_word = false,
					accept_line = false,
					next = "<M-o>",
					prev = "<M-i>",
					dismiss = "<C-S-e>",
				},
			},
			filetypes = { markdown = true },
		},
	},
}
