return {
    -- Improve coding experience of Markdown
    -- {
    -- 	name = "nvim-markdown",
    -- 	dir = "@nvim_markdown@",
    -- 	ft = "markdown",
    -- },

    -- Markdown preview
    -- {
    -- 	name = "markdown.nvim",
    -- 	dir = "@markdown_nvim@",
    -- 	dependencies = {
    -- 		{ name = "nvim-treesitter", dir = "@nvim_treesitter@" },
    -- 	},
    -- 	event = "BufRead",
    -- 	config = function()
    -- 		require("render-markdown").setup({})
    -- 	end,
    -- },

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
    },

    -- Highlight color codes
    {
        name = "nvim-highlight-colors",
        dir = "@nvim_highlight_colors@",
        event = "BufRead",
        opts = { enable_tailwind = true },
    },

    -- Discord rich presence
    {
        name = "presence.nvim",
        dir = "@presence_nvim@",
        event = "BufRead",
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
