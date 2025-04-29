-- Scrollbar
return {
    name = "nvim-scrollbar",
    dir = "@nvim_scrollbar@",
    event = "BufReadPost",
    dependencies = { name = "nvim-hlslens", dir = "@nvim_hlslens@" },
    config = function()
        local colors = require("tokyonight.colors").setup()
        require("scrollbar").setup({
            hide_if_all_visible = true,
            excluded_buftypes = {
                "TelescopePrompt",
                "neo-tree",
                "nofile",
                "noice",
                "notify",
                "prompt",
                "terminal",
            },
            handle = { color = colors.bg_highlight },
            marks = {
                Search = { color = colors.orange },
                Error = { color = colors.error },
                Warn = { color = colors.warning },
                Info = { color = colors.info },
                Hint = { color = colors.hint },
                Misc = { color = colors.purple },
            },
        })

        -- Search highlight
        require("scrollbar.handlers.search").setup({ -- wrapper for hlslens.nvim
            calm_down = true,
        })
    end,
}
