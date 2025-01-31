-- Terminal
return {
    name = "toggleterm.nvim",
    dir = "@toggleterm_nvim@",
    cmd = "ToggleTerm",
    opts = {
        size = 10,
        shading_factor = 2,
        open_mapping = [[<f7>]],
        direction = "float",
        float_opts = {
            border = "curved",
        },
    },
}
