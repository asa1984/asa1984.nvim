return {
    name = "rustowl",
    dir = "@rustowl_nvim@",
    lazy = false,
    opts = {
        client = {
            on_attach = function(_, buffer)
                vim.keymap.set("n", "<leader>o", function()
                    require("rustowl").toggle(buffer)
                end, { buffer = buffer, desc = "Toggle RustOwl" })
            end,
        },
    },
}
