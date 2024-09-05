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
            require("tiny-inline-diagnostic").setup({
                hi = {
                    background = "Normal",
                },
            })
        end,
    },

    --
    {
        name = "trouble.nvim",
        dir = "@trouble_nvim@",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
}
