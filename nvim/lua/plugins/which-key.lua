return {
    name = "which-key.nvim",
    dir = "@which_key_nvim@",
    event = "VeryLazy",
    opts = {
        preset = "helix",
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
