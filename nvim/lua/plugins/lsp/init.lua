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
}
