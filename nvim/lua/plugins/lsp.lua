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
			-- Deno
			lspconfig.denols.setup({
				root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
				single_file = true,
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
			-- JavaScript/TypeScript
			lspconfig.tsserver.setup({
				root_dir = lspconfig.util.root_pattern("package.json"),
				single_file_support = false,
			})
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
				-- Customize or remove this keymap to your liking
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		-- Everything in opts will be passed to setup()
		opts = {
			-- -- Define your formatters
			formatters_by_ft = {
				c = { "clang_format" },
				go = { "gofmt" },
				haskell = { "fourmolu" },
				lua = { "stylua" },
				nix = { "alejandra" },
				ocaml = { "ocamlformat" },
				proto = { "buf" },
				python = { "ruff_format" },
				rust = { "rustfmt" },
				sh = { "shfmt" },
				toml = { "taplo" },
				typst = { "typstfmt" },
				zig = { "zigfmt" },

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
			-- Set up format-on-save
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters = {
				typstfmt = {
					command = "typstfmt",
					args = { "$FILENAME" },
					stdin = false,
				},
			},
		},
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
