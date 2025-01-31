-- Highlight git changes
return {
    {
        name = "gitsigns.nvim",
        dir = "@gitsigns_nvim@",
        event = { "BufRead", "BufNewFile" },
        opts = {},
    },
}
