return {
    name = "nvim-treesitter",
    dir = "@nvim_treesitter@",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        -- nvim-treesitter (main branch) dropped the `nvim-treesitter.configs`
        -- module / `.setup()`. Parsers are provided by Nix on the runtimepath,
        -- so highlighting is just started per buffer via `vim.treesitter.start`.
        local function start()
            pcall(vim.treesitter.start)
        end
        vim.api.nvim_create_autocmd("FileType", {
            callback = start,
        })
        -- Highlight the buffer that triggered loading (its FileType already fired).
        start()
    end,
}
