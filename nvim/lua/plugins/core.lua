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
            ignored_buftypes = { "nofile", "quickfix", "qf", "prompt" },
            ignored_filetypes = { "snacks_picker_list" },
        },
        keys = {
            {
                "<C-h>",
                function()
                    require("smart-splits").move_cursor_left()
                end,
                desc = "Move cursor left pane",
            },
            {
                "<C-j>",
                function()
                    require("smart-splits").move_cursor_down()
                end,
                desc = "Move cursor down pane",
            },
            {
                "<C-k>",
                function()
                    require("smart-splits").move_cursor_up()
                end,
                desc = "Move cursor up pane",
            },
            {
                "<C-l>",
                function()
                    require("smart-splits").move_cursor_right()
                end,
                desc = "Move cursor right pane",
            },
            {
                "<C-Left>",
                function()
                    require("smart-splits").resize_left()
                end,
                desc = "Resize left pane",
            },
            {
                "<C-Down>",
                function()
                    require("smart-splits").resize_down()
                end,
                desc = "Resize down pane",
            },
            {
                "<C-Up>",
                function()
                    require("smart-splits").resize_up()
                end,
                desc = "Resize up pane",
            },
            {
                "<C-Right>",
                function()
                    require("smart-splits").resize_right()
                end,
                desc = "Resize right pane",
            },
            {
                "<leader><leader>h",
                function()
                    require("smart-splits").swap_buf_left()
                end,
                desc = "Swap buffer left",
            },
            {
                "<leader><leader>j",
                function()
                    require("smart-splits").swap_buf_down()
                end,
                desc = "Swap buffer down",
            },
            {
                "<leader><leader>k",
                function()
                    require("smart-splits").swap_buf_up()
                end,
                desc = "Swap buffer up",
            },
            {
                "<leader><leader>l",
                function()
                    require("smart-splits").swap_buf_right()
                end,
                desc = "Swap buffer right",
            },
        },
    },

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
        opts = {
            aliases = {
                ["mdx"] = "html",
            },
        },
    },

    -- Better sort
    {
        name = "sort.nvim",
        dir = "@sort_nvim@",
        cmd = "Sort",
        config = true,
    },
}
