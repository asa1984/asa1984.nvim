-- Statuscolumn
return {
    name = "statuscol.nvim",
    dir = "@statuscol_nvim@",
    event = "BufReadPre",
    config = function()
        local builtin = require("statuscol.builtin")

        require("statuscol").setup({
            bt_ignore = { "terminal", "nofile" },
            relculright = true,
            segments = {
                {
                    text = { builtin.foldfunc },
                    click = "v:lua.ScFa",
                },
                {
                    text = { " " },
                    click = "v:lua.ScFa",
                },
                {
                    sign = {
                        namespace = { "diagnostic/signs" },
                        maxwidth = 2,
                        auto = true,
                    },
                },
                {
                    text = { builtin.lnumfunc },
                },
                {
                    sign = {
                        namespace = { "gitsigns" },
                        maxwidth = 1,
                        colwidth = 1,
                        wrap = true,
                    },
                },
            },
        })
    end,
}
