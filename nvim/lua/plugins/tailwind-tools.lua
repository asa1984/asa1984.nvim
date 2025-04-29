return {
    name = "tailwind-tools.nvim",
    dir = "@tailwind_tools_nvim@",
    ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue" },
    dependencies = {
        { name = "nvim-treesitter", dir = "@nvim_treesitter@" },
    },
    opts = {},
}
