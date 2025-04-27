-- Managing crates.io dependencies
return {
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
}
