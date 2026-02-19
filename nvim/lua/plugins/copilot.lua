-- GitHub Copilot
return {
    name = "copilot.lua",
    dir = "@copilot_lua@",
    event = "InsertEnter",
    opts = {
        suggestion = {
            enabled = true,
            auto_trigger = true,
            keymap = { accept = "<C-l>" },
        },
        filetypes = {
            markdown = false,
            gitcommit = true,
            yaml = true,
        },
    },
}
