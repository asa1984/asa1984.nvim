return {
    -- LSP
    require("plugins.lsp.nvim-lspconfig"),

    -- Formatter
    require("plugins.lsp.conform"),

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

    -- Inline diagnostics
    {
        name = "tiny-inline-diagnostic.nvim",
        dir = "@tiny_inline_diagnostic_nvim@",
        event = "LspAttach",
        keys = {
            {
                "<Leader>l",
                function()
                    require("tiny-inline-diagnostic").toggle()

                    -- Toggle built-in virtual text
                    local config = vim.diagnostic.config()
                    if config == nil or config.virtual_text then
                        vim.diagnostic.config({ virtual_text = false })
                    else
                        vim.diagnostic.config({
                            virtual_text = {
                                format = function(diagnostic)
                                    return string.format("%s (%s)", diagnostic.message, diagnostic.source)
                                end,
                            },
                        })
                    end
                end,
                mode = { "n", "v" },
                desc = "Toggle inline diagnostic mode",
            },
        },
        config = function()
            -- Disable built-in virtual text
            vim.diagnostic.config({ virtual_text = false })
            require("tiny-inline-diagnostic").setup()
        end,
    },
}
