return {
    name = "nvim-treesitter",
    dir = "@nvim_treesitter@",
    event = "BufReadPre",
    config = function()
        -- Add the treesitter parsers installed by Nix to the runtimepath
        vim.opt.runtimepath:append("@treesitter_parsers@")

        require("nvim-treesitter.configs").setup({
            auto_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
