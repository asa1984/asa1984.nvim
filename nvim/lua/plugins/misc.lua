return {
    -- Zen mode
    {
        name = "zen-mode.nvim",
        dir = "@zen_mode_nvim@",
        dependencies = {
            { name = "twilight.nvim", dir = "@twilight_nvim@" },
        },
        cmd = "ZenMode",
        opts = {
            plugins = {
                gitsigns = true,
            },
        },
        keys = {
            {
                "<leader>z",
                "<cmd>ZenMode<cr>",
                desc = "Toggle zen mode",
            },
        },
    },

    -- Highlight color codes
    {
        name = "nvim-highlight-colors",
        dir = "@nvim_highlight_colors@",
        event = "BufRead",
        opts = { enable_tailwind = true },
    },

    -- Stylus syntax highlighting
    {
        name = "vim-stylus",
        dir = "@vim_stylus@",
        ft = "stylus",
    },

    -- Enable tree-sitter highlight for inline code in .nix files
    { name = "hmts.nvim", dir = "@hmts_nvim@", event = "BufRead", version = "*" },
}
