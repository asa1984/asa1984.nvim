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

    -- Tailwind tools
    {
        name = "tailwind-tools.nvim",
        dir = "@tailwind_tools_nvim@",
        ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue" },
        dependencies = {
            { name = "nvim-treesitter", dir = "@nvim_treesitter@" },
        },
        opts = {},
    },

    -- Typst
    {
        name = "typst.vim",
        dir = "@typst_vim@",
        ft = "typst",
        lazy = false,
    },
}
