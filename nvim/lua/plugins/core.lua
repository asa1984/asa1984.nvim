return {
    -- Colorscheme
    {
        name = "tokyonight.nvim",
        dir = "@tokyonight_nvim@",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme tokyonight-moon]])
        end,
    },

    -- Docs (ja)
    {
        name = "vimdoc-ja",
        dir = "@vimdoc_ja@",
        event = "VeryLazy",
    },

    -- Better escape
    {
        name = "better-escape.nvim",
        dir = "@better_escape_nvim@",
        event = "InsertEnter",
        opts = {
            timeout = 200,
            default_mappings = false,
            mappings = {
                i = { j = { j = "<Esc>" } },
                c = { j = { j = "<Esc>" } },
                v = { j = { k = "<Esc>" } },
                s = { j = { k = "<Esc>" } },
            },
        },
    },

    -- Better pane navigation
    {
        name = "smart-splits.nvim",
        dir = "@smart_splits_nvim@",
        opts = {
            ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
            ignored_buftypes = { "nofile" },
        },
    },

    -- Better buffer remove
    { name = "mini.bufremove", dir = "@mini_bufremove@" },

    -- Comment
    {
        name = "ts-comments-nvim",
        dir = "@ts_comments_nvim@",
        opts = {},
        event = "VeryLazy",
    },

    -- Auto enclose deliminators
    {
        name = "nvim-autopairs",
        dir = "@nvim_autopairs@",
        event = "InsertEnter",
        opts = {
            map_c_h = true,
        },
    },

    -- Auto enclose HTML/XML/JSX tags
    {
        name = "nvim-ts-autotag",
        dir = "@nvim_ts_autotag@",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { name = "nvim-treesitter", dir = "@nvim_treesitter@" },
        },
        config = true,
    },

    -- Better sort
    {
        name = "sort.nvim",
        dir = "@sort_nvim@",
        cmd = "Sort",
        config = true,
    },
}
