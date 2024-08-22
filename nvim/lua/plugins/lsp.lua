return {
	-- LSP for Neovim config
	{
		name = "nvim-lspconfig",
		dir = "@nvim_lspconfig@",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { name = "neodev.nvim", dir = "@neodev_nvim@", opts = {} },
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			local node_root_dir = lspconfig.util.root_pattern("package.json")
			local is_node_repo = node_root_dir(vim.api.nvim_buf_get_name(0)) ~= nil
			if is_node_repo then
				lspconfig.tsserver.setup({})
			else
				lspconfig.denols.setup({
					init_options = {
						lint = true,
						unstable = true,
						suggest = {
							imports = {
								hosts = {
									["https://deno.land"] = true,
									["https://cdn.nest.land"] = true,
									["https://crux.land"] = true,
								},
							},
						},
					},
				})
			end

			-- Bash
			lspconfig.bashls.setup({})

			-- C/C++
			local clang_capabilities = vim.lsp.protocol.make_client_capabilities() -- null-ls.nvim issue#428
			clang_capabilities.offsetEncoding = { "utf-16" }
			lspconfig.clangd.setup({
				capabilities = clang_capabilities,
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
			})

			-- CSS
			lspconfig.cssls.setup({ capabilities = capabilities })

			-- CUE
			lspconfig.dagger.setup({})
			vim.g.markdown_fenced_languages = { "ts=typescript" }

			-- Docker
			lspconfig.dockerls.setup({})

			-- Go
			lspconfig.gopls.setup({})

			-- GraphQL
			lspconfig.graphql.setup({})

			-- Haskell
			lspconfig.hls.setup({})

			-- HTML
			lspconfig.html.setup({ capabilities = capabilities })
			lspconfig.biome.setup({})

			-- JSON
			lspconfig.jsonls.setup({ capabilities = capabilities })

			-- Lua
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
			})

			-- Nix
			lspconfig.nil_ls.setup({})

			-- OCaml
			lspconfig.ocamllsp.setup({})

			-- Prisma
			lspconfig.prismals.setup({})

			-- Protocol Buffers
			lspconfig.bufls.setup({})

			-- Python
			lspconfig.pyright.setup({})

			-- Svelte
			lspconfig.svelte.setup({})

			-- TailwindCSS
			lspconfig.tailwindcss.setup({})

			-- Terraform
			lspconfig.terraformls.setup({})

			-- Typst
			lspconfig.typst_lsp.setup({})

			-- Zig
			lspconfig.zls.setup({})

			-- Format of diagnostics
			vim.lsp.handlers["textDocument/publishDiagnostics"] =
				vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
					virtual_text = {
						format = function(diagnostic)
							return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
						end,
					},
				})
		end,
	},

	-- Formatter
	{
		name = "conform.nvim",
		dir = "@conform_nvim@",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				c = { "clang_format" },
				haskell = { "fourmolu" },
				lua = { "stylua" },
				nix = { "nixfmt" },
				ocaml = { "ocamlformat" },
				proto = { "buf" },
				python = { "ruff_format" },
				sh = { "shfmt" },
				toml = { "taplo" },
				typst = { "typstfmt" },

				javascript = { { "biome", "prettier" } },
				typescript = { { "biome", "prettier" } },
				jsvascriptreact = { { "biome", "prettier" } },
				typescriptreact = { { "biome", "prettier" } },
				json = { { "biome", "prettier" } },
				yaml = { "prettier" },
				graphql = { "prettier" },
				svelte = { "prettier" },
				markdown = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
			},
			-- Formatter options
			options = {
				-- for typstfmt
				default_edition = "2021",
			},
			-- Define custom formatters
			formatters = {
				typstfmt = {
					command = "typstfmt",
					args = { "$FILENAME" },
					stdin = false,
				},
			},
			-- Set up format-on-save
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},

	-- Diagnostics
	{
		name = "trouble.nvim",
		dir = "@trouble_nvim@",
		event = "BufRead",
		dependencies = { name = "nvim-web-devicons", dir = "@nvim_web_devicons@" },
		opts = {},
	},

	-- Linter
	{
		name = "nvim-lint",
		dir = "@nvim_lint@",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				python = { "ruff" },
				sh = { "shellcheck" },

				javascript = { "biomejs", "eslint" },
				typescript = { "biomejs", "eslint" },
				jsvascriptreact = { "biomejs", "eslint" },
				typescriptreact = { "biomejs", "eslint" },
			}

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},

	-- Rust
	{
		name = "rust-tools.nvim",
		dir = "@rust_tools_nvim@",
		event = "BufRead",
		opts = {
			tools = { autoSetHints = true },
		},
	},

	-- Managing crates.io dependencies
	{
		name = "crates.nvim",
		dir = "@crates_nvim@",
		event = "BufRead Cargo.toml",
		config = function()
			require("crates").setup()
		end,
	},

	-- Typst
	{
		name = "typst.vim",
		dir = "@typst_vim@",
		ft = "typst",
		lazy = false,
	},
}
