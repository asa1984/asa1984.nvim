return {
    name = "blink.cmp",
    dir = "@blink_cmp@",
    lazy = false,
    dependencies = {
        name = "luasnip",
        dir = "@luasnip@",
    },
    opts = {
        keymap = {
            preset = "super-tab",
            ["<C-u>"] = { "scroll_documentation_up", "fallback" },
            ["<C-d>"] = { "scroll_documentation_down", "fallback" },
            ["<C-b>"] = {},
            ["<C-f>"] = {},
        },
        sources = {
            per_filetype = {
                markdown = { "snippets", "lsp", "path" },
                mdx = { "snippets", "lsp", "path" },
            },
        },
        snippets = { preset = "luasnip" },
        completion = {
            documentation = {
                auto_show = true,
                window = { border = "rounded" },
            },
            menu = { border = "rounded" },
        },
        signature = {
            window = { border = "rounded" },
        },
    },
}
