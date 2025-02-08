-- Better messages and notifications
return {
    name = "noice.nvim",
    dir = "@noice_nvim@",
    event = "VeryLazy",
    dependencies = {
        { name = "nui.nvim", dir = "@nui_nvim@" },
    },
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        cmdline = {
            view = "cmdline",
        },
        notify = {
            enabled = false,
        },
        presets = {
            bottom_search = true,
            long_message_to_split = true,
        },
        routes = {
            {
                filter = {
                    event = "msg_show",
                    kind = "search_count",
                },
                opts = { skip = true },
            },

            -- TODO: Remove this filter
            {
                filter = {
                    event = "notify",
                    kind = "warn",
                    find = "position_encoding param is required in vim.lsp.util.make_range_params. Defaulting to position encoding of the first client.",
                },
                { opts = { skip = true } },
            },

            -- Ignore messages from copilot.lua https://github.com/zbirenbaum/copilot.lua/issues/321
            {
                filter = {
                    event = "msg_show",
                    any = {
                        { find = "Agent service not initialized" },
                        { find = "Not authenticated: NotSignedIn" },
                    },
                },
                opts = { skip = true },
            },
        },
    },
}
