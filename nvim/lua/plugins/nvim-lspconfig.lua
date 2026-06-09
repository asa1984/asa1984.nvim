local utils = require("utils")

return {
    name = "nvim-lspconfig",
    dir = "@nvim_lspconfig@",
    event = { "BufReadPre", "BufNewFile" },
    lazy = false,
    dependencies = {
        -- Introduce `.neoconf.json`
        { name = "neoconf.nvim", dir = "@neoconf_nvim@", config = true },

        -- LSP for Neovim config
        { name = "neodev.nvim", dir = "@neodev_nvim@", opts = {} },

        -- JSON/YAML schema
        { name = "schemastore.nvim", dir = "@schemastore_nvim@" },

        -- Better error message for TypeScript
        { name = "ts-error-translator.nvim", dir = "@ts_error_translator_nvim@" },
    },
    config = function()
        vim.lsp.config(
            "*",
            (function()
                local opts = {}
                opts.capabilities = vim.lsp.protocol.make_client_capabilities()
                opts.capabilities.textDocument.completion.completionItem.snippetSupport = true
                return opts
            end)()
        )

        -- Astro
        -- Prefer a project-local `astro-ls` (node_modules/.bin) when present so
        -- the project's own Astro/TypeScript versions are used. Otherwise fall
        -- back to the one on PATH. filetypes/root_markers/init_options are
        -- inherited from lspconfig.
        vim.lsp.config("astro", {
            cmd = function(dispatchers, config)
                local bin = "astro-ls"
                if config.root_dir then
                    local local_bin = config.root_dir .. "/node_modules/.bin/astro-ls"
                    if vim.uv.fs_stat(local_bin) then
                        bin = local_bin
                    end
                end
                return vim.lsp.rpc.start({ bin, "--stdio" }, dispatchers, {
                    cwd = config.cmd_cwd,
                    env = config.cmd_env,
                })
            end,
        })

        -- CSS
        vim.lsp.config("cssls", {
            filetypes = {
                "css",
                "scss",
                "less",
                "stylus", -- for stylus
            },
        })

        -- TypeScript (on Node.js)
        vim.lsp.config("vtsls", {
            workspace_required = true,
        })

        -- Deno
        vim.lsp.config("denols", {
            settings = {
                deno = {
                    lint = true,
                    unstable = true,
                },
            },
        })

        -- Disable denols if working with Node.js
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local bufnr = args.buf
                vim.schedule(function()
                    local nodejsLSPClients = vim.lsp.get_clients({ name = "vtsls", bufnr = bufnr })
                    local denoLSPClients = vim.lsp.get_clients({ name = "denols", bufnr = bufnr })
                    if #nodejsLSPClients > 0 and #denoLSPClients > 0 then
                        for _, denoLSPClient in ipairs(denoLSPClients) do
                            vim.lsp.stop_client(denoLSPClient.id)
                        end
                    end
                end)
            end,
        })

        -- ESLint
        vim.lsp.config("eslint", {
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
                "graphql", -- for graphql-eslint
            },
            settings = {
                codeActionOnSave = {
                    enable = true,
                },
            },
        })

        -- JSON
        vim.lsp.config("jsonls", {
            settings = {
                json = {
                    schemas = require("schemastore").json.schemas(),
                    validate = { enable = true },
                },
            },
        })

        -- Lua
        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                },
            },
        })

        -- Nix
        vim.lsp.config("nil_ls", {
            settings = {
                ["nil"] = {
                    nix = {
                        flake = {
                            autoArchive = true,
                        },
                    },
                },
            },
        })

        -- Typst
        vim.lsp.config("tinymist", {
            offset_encoding = "utf-8",
            settings = {
                formatterMode = "typstyle",
            },
        })

        -- YAML
        vim.lsp.config("yamlls", {
            settings = {
                yaml = {
                    schemas = require("schemastore").yaml.schemas(),
                    validate = { enable = true },
                },
            },
        })

        vim.lsp.config("tailwindcss", {
            settings = {
                tailwindCSS = {
                    classFunctions = { "clsx", "cn", "cva", "tv" },
                },
            },
        })

        vim.lsp.enable({
            -- Config like
            "buf_ls", -- Protocol Buffers
            "dockerls", -- Docker
            "graphql", -- GraphQL
            "jsonls", -- JSON
            "just", -- justfile
            "prismals", -- Prisma ORM
            "taplo", -- TOML
            "yamlls", -- YAML

            -- JavaScript/TypeScript ecosystem
            "astro",
            "biome",
            "cssls",
            "denols",
            "eslint",
            "html",
            "mdx_analyzer",
            "oxlint",
            "svelte",
            "tailwindcss",
            "vtsls",
            "vuels",

            -- Bash
            "bashls",

            -- Go
            "gopls",

            -- Haskell
            "hls",

            -- Lua
            "lua_ls",

            -- Nix
            "nil_ls",

            -- Ocaml
            "ocamllsp",

            -- Python
            "pyright",
            "ruff",

            -- SQL
            "sqls",

            -- Typst
            "tinymist",

            -- Terraform
            "terraformls",

            -- Zig
            "zls",
        })
    end,
}
