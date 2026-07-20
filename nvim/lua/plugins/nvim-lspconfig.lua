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
            settings = {
                vtsls = { autoUseWorkspaceTsdk = true },
            },
        })

        -- tsgo (typescript-go native LSP, provided by nvim-lspconfig).
        -- lspconfig's tsgo config only runs `tsgo` from PATH, so resolve and
        -- run the project-local `node_modules/.bin/tsgo` ourselves. Only attach
        -- when that binary exists, so tsgo is used solely for projects that
        -- ship it; otherwise the LspAttach handler keeps vtsls.
        vim.lsp.config("tsgo", {
            cmd = function(dispatchers, config)
                local bin = config.root_dir .. "/node_modules/.bin/tsgo"
                return vim.lsp.rpc.start({ bin, "--lsp", "--stdio" }, dispatchers, {
                    cwd = config.cmd_cwd,
                    env = config.cmd_env,
                })
            end,
            root_dir = function(bufnr, on_dir)
                local fname = vim.api.nvim_buf_get_name(bufnr)
                local root = vim.fs.root(fname, { "package.json", ".git" })
                if root and vim.uv.fs_stat(root .. "/node_modules/.bin/tsgo") then
                    on_dir(root)
                end
            end,
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

        -- Resolve overlapping TypeScript servers.
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local bufnr = args.buf
                vim.schedule(function()
                    local tsgoLSPClients = vim.lsp.get_clients({ name = "tsgo", bufnr = bufnr })
                    local vtslsLSPClients = vim.lsp.get_clients({ name = "vtsls", bufnr = bufnr })
                    local denoLSPClients = vim.lsp.get_clients({ name = "denols", bufnr = bufnr })

                    -- Prefer project-local tsgo over vtsls.
                    if #tsgoLSPClients > 0 then
                        for _, vtslsLSPClient in ipairs(vtslsLSPClients) do
                            vim.lsp.stop_client(vtslsLSPClient.id)
                        end
                        vtslsLSPClients = {}
                    end

                    -- Disable denols if working with Node.js.
                    if (#tsgoLSPClients > 0 or #vtslsLSPClients > 0) and #denoLSPClients > 0 then
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
                -- "astro",
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

        -- Pkl (apple/pkl-lsp). nvim-lspconfig ships no `pkl` definition, so the
        -- command, filetypes and root markers are spelled out in full here.
        vim.lsp.config("pkl", {
            cmd = { "pkl-lsp" },
            filetypes = { "pkl" },
            root_markers = { ".pkl-lsp", "PklProject", ".git" },
            settings = {
                ["pkl.cli.path"] = "pkl",
            },
            init_options = {
                extendedClientCapabilities = {
                    actionableRuntimeNotifications = true,
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
            "tsgo",
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

            -- Pkl
            "pkl",

            -- Python
            "pyright",
            "ruff",

            -- Scala
            "metals",

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
