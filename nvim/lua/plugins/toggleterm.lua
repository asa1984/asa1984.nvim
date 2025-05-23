-- Terminal
return {
    name = "toggleterm.nvim",
    dir = "@toggleterm_nvim@",
    cmd = "ToggleTerm",
    opts = {
        size = 10,
        shading_factor = 2,
        open_mapping = [[<f7>]],
        direction = "horizontal",
        float_opts = {
            border = "curved",
        },
    },
    keys = {
        {
            "<leader>tt",
            "<cmd>ToggleTerm<cr>",
            desc = "Open terminal",
        },
        {
            "<leader>tf",
            "<cmd>ToggleTerm direction=float<cr>",
            desc = "Open terminal in floating window",
        },
        {
            "<leader>th",
            "<cmd>ToggleTerm direction=horizontal size=15<cr>",
            desc = "Open terminal in horizontal split",
        },
        {
            "<leader>tv",
            "<cmd>ToggleTerm direction=vertical size=70<cr>",
            desc = "Open terminal in vertical split",
        },
    },
}
