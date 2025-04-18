return {
    {
        name = "nvim-lspconfig",
        dir = "@nvim_lspconfig@",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            -- LSP for Neovim config
            { name = "neodev.nvim", dir = "@neodev_nvim@", opts = {} },
            -- JSON/YAML schema
            { name = "schemastore.nvim", dir = "@schemastore_nvim@" },
            -- Better error message for TypeScript
            { name = "ts-error-translator.nvim", dir = "@ts_error_translator_nvim@" },
            { name = "neoconf.nvim", dir = "@neoconf_nvim@", config = true },
        },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            -- Translate TypeScript error messages
            vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
                require("ts-error-translator").translate_diagnostics(err, result, ctx, config)
                vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
            end

            ----------------------
            -- General settings --
            ----------------------

            -- LSP
            local server_list = require("plugins.lsp.server-list")
            for _, server in ipairs(server_list) do
                lspconfig[server].setup({})
            end

            ----------------------------------------
            -- Specific settings for some servers --
            ----------------------------------------

            -- denols or tsserver
            ---- If the current project is a Node.js project, use tsserver
            ---- Otherwise, use denols
            local node_root_dir = lspconfig.util.root_pattern("package.json")
            local is_node_repo = node_root_dir(vim.api.nvim_buf_get_name(0)) ~= nil
            if is_node_repo then
                lspconfig.ts_ls.setup({})
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

            -- ESLint
            lspconfig.eslint.setup({
                filetypes = {
                    "javascript",
                    "javascriptreact",
                    "javascript.jsx",
                    "typescript",
                    "typescriptreact",
                    "typescript.tsx",
                    "vue",
                    "svelte",
                    "astro",
                    "graphql",
                },
                settings = {
                    format = true,
                },
            })

            -- Biome
            lspconfig.biome.setup({})

            -- CSS
            lspconfig.cssls.setup({
                -- Enable code snippets
                -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssls
                capabilities = capabilities,
                filetypes = { "css", "scss", "less", "stylus" },
            })

            -- JSON
            lspconfig.jsonls.setup({
                -- Enable code snippets
                -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
                capabilities = capabilities,
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            })

            -- YAML
            lspconfig.yamlls.setup({
                settings = {
                    yaml = {
                        schemaStore = {
                            -- You must disable built-in schemaStore support if you want to use
                            -- this plugin and its advanced options like `ignore`.
                            enable = false,
                            -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                            url = "",
                        },
                        schemas = require("schemastore").yaml.schemas(),
                    },
                },
            })

            -- TODO: Why did I configure this?
            -- C/C++
            local clang_capabilities = vim.lsp.protocol.make_client_capabilities() -- null-ls.nvim issue#428
            clang_capabilities.offsetEncoding = { "utf-16" }
            lspconfig.clangd.setup({
                capabilities = clang_capabilities,
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
            })

            -- Lua
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        -- format = { enable = false },
                    },
                },
            })

            -- Typst
            lspconfig.tinymist.setup({
                offset_encoding = "utf-8",
                settings = {
                    formatterMode = "typstyle",
                },
            })
        end,
    },
}
