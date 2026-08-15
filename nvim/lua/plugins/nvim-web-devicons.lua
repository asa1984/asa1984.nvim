-- File type icons, shared by Neo-tree, heirline and lspsaga
return {
    name = "nvim-web-devicons",
    dir = "@nvim_web_devicons@",
    -- nvim-web-devicons ships no MoonBit entry, so `.mbt` / `.mbti` fall back to
    -- the generic file icon. Colour is MoonBit's GitHub linguist colour.
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
