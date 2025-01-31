-- GitHub Copilot
return {
    name = "copilot.lua",
    dir = "@copilot_lua@",
    event = "InsertEnter",
    opts = {
        suggestion = {
            enabled = true,
            auto_trigger = true,
        },
        filetypes = {
            markdown = true,
            gitcommit = true,
            yaml = true,
        },
    },
}
