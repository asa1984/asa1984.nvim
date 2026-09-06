-- File type icons, shared by Neo-tree, heirline and lspsaga
return {
    name = "nvim-web-devicons",
    dir = "@nvim_web_devicons@",
    -- nvim-web-devicons ships no MoonBit or KCL entry, so `.mbt` / `.mbti` /
    -- `.k` fall back to the generic file icon. (CUE already has one built in.)
    -- Colours are the GitHub linguist colours.
    opts = {
        override_by_extension = {
            mbt = {
                icon = "󰖔",
                color = "#b92381",
                cterm_color = "126",
                name = "MoonBit",
            },
            mbti = {
                icon = "󰖔",
                color = "#b92381",
                cterm_color = "126",
                name = "MoonBitInterface",
            },
            k = {
                icon = "󰬒",
                color = "#7ABABF",
                cterm_color = "109",
                name = "Kcl",
            },
        },
    },
    config = function(_, opts)
        local devicons = require("nvim-web-devicons")
        devicons.setup(opts)

        -- `setup()` is a no-op once nvim-web-devicons has self-initialised, which
        -- happens the first time anything renders an icon -- in practice before
        -- lazy.nvim gets to run this config. Writing straight into the icon tables
        -- it hands out applies the overrides whichever way the race goes, and the
        -- table survives the icon refresh triggered by a 'background' change.
        local by_extension = devicons.get_icons_by_extension()
        for extension, icon in pairs(opts.override_by_extension) do
            by_extension[extension] = icon
            devicons.set_icon({ [extension] = icon })
        end
    end,
}
