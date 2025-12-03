return {
    name = "nvim-treesitter",
    dir = "@nvim_treesitter@",
    event = "VimEnter",
    config = function()
        require("nvim-treesitter.configs").setup({
            auto_install = false,
            highlight = { enable = true },
        })
    end,
}
