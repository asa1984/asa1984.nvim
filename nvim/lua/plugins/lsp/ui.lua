local get_icon = require("utils").get_icon

return {
    -- Better LSP UI
    {
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
                    code_action = get_icon("DiagnosticHint"),
                },
                lightbulb = {
                    sign = false,
                },
            }
        end,
    },

    -- Inline diagnostics
    {
        name = "tiny-inline-diagnostic.nvim",
        dir = "@tiny_inline_diagnostic_nvim@",
        event = "LspAttach",
        keys = {
            {
                "<Leader>l",
                function()
                    require("tiny-inline-diagnostic").toggle()

                    -- Toggle built-in virtual text
                    local config = vim.diagnostic.config()
                    if config == nil or config.virtual_text then
                        vim.diagnostic.config({ virtual_text = false })
                    else
                        vim.diagnostic.config({
                            virtual_text = {
                                format = function(diagnostic)
                                    return string.format("%s (%s)", diagnostic.message, diagnostic.source)
                                end,
                            },
                        })
                    end
                end,
                mode = { "n", "v" },
                desc = "Toggle inline diagnostic mode",
            },
        },
        config = function()
            -- Disable built-in virtual text
            vim.diagnostic.config({ virtual_text = false })
            require("tiny-inline-diagnostic").setup({
                hi = {
                    background = "Normal",
                },
            })
        end,
    },
}
