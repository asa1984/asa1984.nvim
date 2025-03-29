-- Inline diagnostics
return {
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
}
