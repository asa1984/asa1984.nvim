local utils = require("utils")

-- Better LSP UI
return {
    name = "lspsaga.nvim",
    dir = "@lspsaga_nvim@",
    event = "LspAttach",
    dependencies = {
        { name = "nvim-treesitter", dir = "@nvim_treesitter@" },
        { name = "nvim-web-devicons", dir = "@nvim_web_devicons@" },
    },
    opts = function()
        return {
            ui = {
                border = "rounded",
                code_action = utils.get_icon("DiagnosticHint"),
            },
            lightbulb = {
                sign = false,
            },
        }
    end,
    keys = {
        {
            "m",
            "<Plug>(lsp)",
        },
        {
            "K",
            "<cmd>Lspsaga hover_doc<cr>",
            desc = "Show hover documentation",
        },
        {
            "<Plug>(lsp)a",
            "<cmd>Lspsaga code_action<cr>",
            desc = "Code action",
        },
        {
            "<Plug>(lsp)d",
            "<cmd>Lspsaga show_cursor_diagnostics<cr>",
            desc = "Show diagnostics at cursor",
        },
        {
            "<Plug>(lsp)D",
            "<cmd>Lspsaga show_workspace_diagnostics<cr>",
            desc = "Show diagnostics in workspace",
        },
        {
            ";e",
            "<cmd>Lspsaga diagnostic_jump_next<cr>",
            desc = "Jump to next diagnostic",
        },
        {
            ";E",
            "<cmd>Lspsaga diagnostic_jump_prev<cr>",
            desc = "Jump to previous diagnostic",
        },
        {
            "<Plug>(lsp)rn",
            "<cmd>Lspsaga rename<cr>",
            desc = "Rename",
        },
    },
}
