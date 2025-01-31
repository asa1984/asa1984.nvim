-- Indent colorizer
return {
    name = "hlchunk.nivm",
    dir = "@hlchunk_nvim@",
    dependencies = {
        { name = "nvim-treesitter", dir = "@nvim_treesitter@" },
    },
    event = { "BufRead", "BufNewFile" },
    config = function()
        require("hlchunk").setup({
            chunk = {
                enable = true,
                use_treesitter = true,
                duration = 0,
                delay = 0,
            },
            indent = { enable = false },
            line_num = { enable = false },
            blank = { enable = false },
        })
    end,
}
