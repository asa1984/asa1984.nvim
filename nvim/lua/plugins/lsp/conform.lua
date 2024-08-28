return {
    name = "conform.nvim",
    dir = "@conform_nvim@",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
        -- This function does not mutate the original table
        local function merge_table_immutable(original, override)
            return setmetatable(override, { __index = original })
        end

        local biome_for_project = merge_table_immutable(require("conform.formatters.biome"), { require_cwd = true })
        local prettier_for_project =
            merge_table_immutable(require("conform.formatters.prettier"), { require_cwd = true })

        local prettier_like_formatters =
            { "biome_for_project", "prettier_for_project", "prettier", stop_after_first = true }

        -- If denols is attached as LSP, use `deno fmt`
        -- Otherwise, use formatters for Node.js like environment
        local function js_like_formatters()
            local clients = vim.lsp.get_clients()
            for _, client in pairs(clients) do
                if client.name == "denols" then
                    return { "biome_for_project", "prettier_for_project", "deno_fmt", stop_after_first = true }
                end
            end
            return { "biome_for_project", "prettier_for_project", "prettier", stop_after_first = true }
        end

        require("conform").setup({
            formatters = {
                biome_for_project = biome_for_project,
                prettier_for_project = prettier_for_project,
                stylua = { require_cwd = true },
            },
            formatters_by_ft = {
                -- Markup
                html = { "prettier" },
                markdown = { "prettier" },

                -- CSS
                css = { "prettier" },
                scss = { "prettier" },

                -- Config like
                json = prettier_like_formatters,
                toml = { "taplo" },
                yaml = { "prettier" },

                -- JS like
                javascript = js_like_formatters,
                typescript = js_like_formatters,
                jsvascriptreact = js_like_formatters,
                typescriptreact = js_like_formatters,

                -- Web frameworks
                angular = { "prettier" },
                astro = { "prettier" },
                svelte = { "prettier" },
                vue = { "prettier" },

                -- Programming
                c = { "clang_format" },
                haskell = { "fourmolu" },
                lua = { "stylua" },
                nix = { "nixfmt" },
                ocaml = { "ocamlformat" },
                python = { "ruff_format" },

                -- Schema
                graphql = { "prettier" },
                proto = { "buf" },

                -- Misc
                sh = { "shfmt" },
                typst = { "typstfmt" },
            },
            default_format_opts = {
                lsp_format = "fallback",
            },
            format_on_save = function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return {
                    timeout_ms = 500,
                }
            end,
        })

        vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
                -- FormatDisable! will disable formatting just for this buffer
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, {
            desc = "Disable autoformat-on-save",
            bang = true,
        })

        vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = "Re-enable autoformat-on-save",
        })
    end,
}
