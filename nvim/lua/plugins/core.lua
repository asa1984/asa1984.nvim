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

    -- Better pane navigation (tmux/smart-terminal)
    -- Disabled inside Herdr; herdr-splits.nvim handles seamless nvim/Herdr nav.
    {
        name = "smart-splits.nvim",
        dir = "@smart_splits_nvim@",
        cond = vim.env.HERDR_ENV ~= "1",
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
                "<A-h>",
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
                "<A-j>",
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
                "<A-k>",
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
                "<A-l>",
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

    -- Seamless navigation/resizing between Neovim splits and Herdr panes.
    -- Herdr-side plugin forwards <C-h/j/k/l> for movement and <M-h/j/k/l> for
    -- resize into Neovim; this plugin receives them and delegates back to Herdr
    -- at nvim window edges.
    {
        name = "herdr-splits.nvim",
        dir = "@herdr_splits_nvim@",
        cond = vim.env.HERDR_ENV == "1",
        event = "VeryLazy",
        opts = {
            default_amount = 0.03,
            neovim_amount = 3,
            at_edge = "wrap",
            ignored_buftypes = { "nofile", "quickfix", "prompt" },
            ignored_filetypes = { "snacks_picker_list" },
        },
        keys = {
            {
                "<C-h>",
                function()
                    require("herdr-splits").move_cursor_left()
                end,
                desc = "Move cursor left",
            },
            {
                "<C-j>",
                function()
                    require("herdr-splits").move_cursor_down()
                end,
                desc = "Move cursor down",
            },
            {
                "<C-k>",
                function()
                    require("herdr-splits").move_cursor_up()
                end,
                desc = "Move cursor up",
            },
            {
                "<C-l>",
                function()
                    require("herdr-splits").move_cursor_right()
                end,
                desc = "Move cursor right",
            },
            {
                "<M-h>",
                function()
                    require("herdr-splits").resize_left()
                end,
                desc = "Resize left",
            },
            {
                "<M-j>",
                function()
                    require("herdr-splits").resize_down()
                end,
                desc = "Resize down",
            },
            {
                "<M-k>",
                function()
                    require("herdr-splits").resize_up()
                end,
                desc = "Resize up",
            },
            {
                "<M-l>",
                function()
                    require("herdr-splits").resize_right()
                end,
                desc = "Resize right",
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
