return {
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
        opts = {
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
        },
    },
}
