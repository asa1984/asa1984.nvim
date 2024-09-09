return {
    -- Highlight git changes
    {
        name = "gitsigns.nvim",
        dir = "@gitsigns_nvim@",
        event = { "BufRead", "BufNewFile" },
        opts = {},
    },
}
