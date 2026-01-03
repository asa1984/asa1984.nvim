local get_icon = require("utils").get_icon

-- Startup screen
return {
    name = "alpha.nvim",
    dir = "@alpha_nvim@",
    dependencies = {
        { name = "plenary.nvim", dir = "@plenary_nvim@" },
    },
    event = "VimEnter",
    opts = function()
        local config = require("alpha.themes.theta").config
        local button = require("alpha.themes.dashboard").button
        local logo = {
            "                                                        ",
            "  ██████  ██████   ██████   █████  ███    ██ ██  ██████ ",
            " ██    ██ ██   ██ ██       ██   ██ ████   ██ ██ ██      ",
            " ██    ██ ██████  ██   ███ ███████ ██ ██  ██ ██ ██      ",
            " ██    ██ ██   ██ ██    ██ ██   ██ ██  ██ ██ ██ ██      ",
            "  ██████  ██   ██  ██████  ██   ██ ██   ████ ██  ██████ ",
            "                                                        ",
        }
        local buttons = {
            type = "group",
            val = {
                { type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
                { type = "padding", val = 1 },
                button("f", get_icon("Search") .. "  File Picker", function()
                    Snacks.picker.files()
                end),
                button("g", get_icon("SearchText") .. "  Grep", function()
                    Snacks.picker.grep()
                end),
                button("l", get_icon("Lazy") .. " Lazy", "<cmd>Lazy<cr>"),
                button("q", get_icon("BufferClose") .. "  Quit", "<cmd>qa<cr>"),
                button("<leader>", get_icon("Config") .. "  Config", function()
                    Snacks.lazygit()
                end),
            },
            position = "center",
        }
        config.layout[2].val = logo
        config.layout[6] = buttons
        return config
    end,
}
