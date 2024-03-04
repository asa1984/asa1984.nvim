return {
	-- LSP for Neovim config
	{
		name = "nvim-lspconfig",
		dir = "@nvim_lspconfig@",
		event = { "BufReadPost", "BufNewFile" },
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

	{
		name = "none-ls.nvim",
		dir = "@none_ls_nvim@",
		event = "BufRead",
		opts = function()
			local nls = require("null-ls")
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			return {
				sources = {
					-- C/C++
					nls.builtins.formatting.clang_format,
					-- CUE
					nls.builtins.formatting.cue_fmt,
					-- Deno
					-- nls.builtins.formatting.deno_fmt.with({
					-- 	filetypes = {
					-- 		"javascript",
					-- 		"javascriptreact",
					-- 		"json",
					-- 		"jsonc",
					-- 		"typescript",
					-- 		"typescriptreact",
					-- 	},
					-- 	condition = function(utils)
					-- 		return not (utils.has_file({ ".prettierrc", ".prettierrc.js", "package.json" }))
					-- 	end,
					-- }),
					-- nls.builtins.diagnostics.deno_lint.with({
					--   condition = function(utils)
					--     return not (
					--       utils.root_has_file("eslint.config.js")
					--       or utils.root_has_file("eslint.config.cjs")
					--       or utils.root_has_file("eslint.config.mjs")
					--       or utils.root_has_file(".eslintrc")
					--       or utils.root_has_file(".eslintrc.js")
					--       or utils.root_has_file(".eslintrc.cjs")
					--       or utils.root_has_file(".eslintrc.mjs")
					--       or utils.root_has_file(".eslintrc.json")
					--       or utils.root_has_file(".eslintrc.yml")
					--       or utils.root_has_file(".eslintrc.yaml")
					--     )
					--   end,
					-- }),
					-- JavaScript/TypeScript/Others
					nls.builtins.formatting.prettier.with({
						prefer_local = "node_modules/.bin",
						filetypes = {
							-- "javascript",
							-- "javascriptreact",
							-- "typescript",
							-- "typescriptreact",
							"vue",
							"css",
							"scss",
							"less",
							"html",
							-- "json",
							-- "jsonc",
							"yaml",
							"markdown",
							"markdown.mdx",
							"graphql",
							"handlebars",
						},
					}),
					-- nls.builtins.formatting.biome,
					-- nls.builtins.diagnostics.eslint.with({
					--   prefer_local = "node_modules/.bin",
					--   condition = function(utils)
					--     return utils.root_has_file("eslint.config.js")
					--         or utils.root_has_file("eslint.config.cjs")
					--         or utils.root_has_file("eslint.config.mjs")
					--         or utils.root_has_file(".eslintrc")
					--         or utils.root_has_file(".eslintrc.js")
					--         or utils.root_has_file(".eslintrc.cjs")
					--         or utils.root_has_file(".eslintrc.mjs")
					--         or utils.root_has_file(".eslintrc.json")
					--         or utils.root_has_file(".eslintrc.yml")
					--         or utils.root_has_file(".eslintrc.yaml")
					--   end,
					-- }),
					-- Go
					nls.builtins.formatting.gofmt,
					-- Haskell
					nls.builtins.formatting.fourmolu,
					-- Lua
					nls.builtins.formatting.stylua,
					-- Nix
					nls.builtins.formatting.alejandra,
					-- OCaml
					nls.builtins.formatting.ocamlformat,
					-- Python
					nls.builtins.formatting.black,
					-- Rust
					nls.builtins.formatting.rustfmt.with({
						extra_args = function(params)
							local Path = require("plenary.path")
							local cargo_toml = Path:new(params.root .. "/" .. "Cargo.toml")

							if cargo_toml:exists() and cargo_toml:is_file() then
								for _, line in ipairs(cargo_toml:readlines()) do
									local edition = line:match([[^edition%s*=%s*%"(%d+)%"]])
									if edition then
										return { "--edition=" .. edition }
									end
								end
							end
							-- default edition when we don't find `Cargo.toml` or the `edition` in it.
							return { "--edition=2021" }
						end,
					}),
					-- Shell
					nls.builtins.diagnostics.shellcheck,
					nls.builtins.formatting.shfmt,
					-- -- SQL
					-- nls.builtins.formatting.sql_formatter,
					-- Protocol Buffers
					nls.builtins.formatting.buf,
					-- Terraform
					nls.builtins.formatting.terraform_fmt,
					-- TOML
					nls.builtins.formatting.taplo,
					-- Zig
					nls.builtins.formatting.zigfmt,
				},

				-- Format on save
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({
									bufnr = bufnr,
									filter = function(fmt_client)
										return fmt_client.name == "null-ls"
									end,
								})
							end,
						})
					end
				end,
			}
		end,
	},

	{
		name = "typst.vim",
		dir = "@typst_vim@",
		ft = "typst",
		lazy = false,
	},

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
				javascript = { { "biomejs", "prettier" } },
				typescript = { { "biomejs", "prettier" } },
				jsvascriptreact = { { "biomejs", "prettier" } },
				typescriptreact = { { "biomejs", "prettier" } },
				typst = { "typstfmt" },
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
		-- init = function()
		-- 	-- If you want the formatexpr, here is the place to set it
		-- 	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		-- end,
	},
	{
		name = "nvim-lint",
		dir = "@nvim_lint@",
		opts = {
			linters_by_ft = {
				javascript = { "biomejs" },
				typescript = { "biomejs" },
				jsvascriptreact = { "biomejs" },
				typescriptreact = { "biomejs" },
			},
		},
		init = function()
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
