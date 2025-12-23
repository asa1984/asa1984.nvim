return {
    name = "rustaceanvim",
    dir = "@rustaceanvim@",
    lazy = false, -- This plugin is already lazy
    init = function()
        vim.g.rustaceanvim = {
            server = {
                default_settings = {
                    ["rust-analyzer"] = {
                        files = {
                            excludeDirs = { "node_modules", ".direnv" },
                        },
                    },
                },
            },
        }
    end,
}
