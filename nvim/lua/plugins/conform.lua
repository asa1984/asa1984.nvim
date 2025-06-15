-- This function does not mutate the original table
local function merge_table_immutable(original, override)
    return setmetatable(override, { __index = original })
end

return {
    name = "conform.nvim",
    dir = "@conform_nvim@",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    dependencies = {
        { name = "neoconf.nvim", dir = "@neoconf_nvim@" },
    },
    config = function()
        local neoconf = require("neoconf")
        local util = require("conform.util")

        local biome_for_project = merge_table_immutable(require("conform.formatters.biome"), {
            require_cwd = true,
            args = { "check", "--write", "--stdin-file-path", "$FILENAME" },
        })
        local prettier_for_project =
            merge_table_immutable(require("conform.formatters.prettier"), { require_cwd = true })
        local prettier_like_formatters =
            { "biome_for_project", "prettier_for_project", "prettier", stop_after_first = true }

        -- If denols is attached as LSP, use `deno fmt`
        -- Otherwise, use formatters for Node.js like environment
        local function js_like_formatters()
            if neoconf.get("formatter.eslint.enable") then
                return { lsp_format = "fallback" }
            end

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
                stylus_supremacy = {
                    command = util.from_node_modules("stylus-supremacy"),
                    stdin = false,
                    args = function(_, ctx)
                        local stylus_supremacy_settings_path =
                            vim.fs.find(".stylus-supremacy.json", { path = ctx.dirname, upward = true })[1]
                        local vscode_settings_path =
                            vim.fs.find(".vscode/settings.json", { path = ctx.dirname, upward = true })[1]

                        return stylus_supremacy_settings_path ~= nil
                                and {
                                    "format",
                                    "--replace",
                                    "--options",
                                    stylus_supremacy_settings_path,
                                    "$FILENAME",
                                }
                            or vscode_settings_path ~= nil and {
                                "format",
                                "--replace",
                                "--options",
                                vscode_settings_path,
                                "$FILENAME",
                            }
                            or { "format", "--replace", "$FILENAME" }
                    end,
                    cwd = util.root_file({
                        ".stylus-supremacy.json",
                        ".vscode",
                    }),
                },
            },
            formatters_by_ft = {
                -- Markup
                html = { "prettier" },
                markdown = { "prettier" },
                mdx = { "prettier" },

                -- CSS
                css = { "prettier" },
                scss = { "prettier" },
                stylus = { "stylus_supremacy" },

                -- Config like
                json = prettier_like_formatters,
                jsonc = prettier_like_formatters,
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
                rust = { lsp_format = "fallback" },

                -- Schema
                graphql = { "prettier" },
                proto = { "buf" },

                -- Misc
                sh = { "shfmt" },
                typst = { "typstyle" },
            },
            default_format_opts = {
                lsp_format = "fallback",
            },
            format_on_save = function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return {
                    timeout_ms = 2500,
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
