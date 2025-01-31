-- Fold
return {
    name = "nvim-ufo",
    dir = "@nvim_ufo@",
    event = "BufReadPost",
    dependencies = {
        { name = "promise-async", dir = "@promise_async@" },
        { name = "statuscol.nvim", dir = "@statuscol_nvim@" },
    },
    opts = {
        provider_selector = function()
            return { "treesitter", "indent" }
        end,
    },
}
