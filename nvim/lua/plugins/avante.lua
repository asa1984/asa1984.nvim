return {
    name = "avante.nvim",
    dir = "@avante_nvim@",
    dependencies = {
        -- Requirements
        { name = "dressing.nvim", dir = "@dressing_nvim@" },
        { name = "plenary.nvim", dir = "@plenary_nvim@" },
        { name = "nui.nvim", dir = "@nui_nvim@" },
        -- Optional
        { name = "nvim-cmp", dir = "@nvim_cmp@" },
        { name = "nvim-web-devicons", dir = "@nvim_web_devicons@" },
        { name = "copilot.lua", dir = "@copilot_lua@" },
        {
            -- Make sure to set this up properly if you have lazy=true
            name = "render-markdown.nvim",
            dir = "@render_markdown_nvim@",
            ft = { "Avante" },
        },
    },
    event = "VeryLazy",
    opts = {
        provider = "copilot",
        auto_suggestions_provider = "copilot",
        behaviour = {
            auto_suggestions = false,
            auto_set_highlight_group = true,
            auto_set_keymaps = true,
            auto_apply_diff_after_generation = false,
            support_paste_from_clipboard = false,
            minimize_diff = true,
        },
        windows = {
            position = "right",
            wrap = true,
            width = 30,
        },
    },
    keys = {},
}
