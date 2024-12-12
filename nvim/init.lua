vim.loader.enable() -- You need to enable vim.loader before loading plugins

vim.g.mapleader = " " -- You need to set this before lazy loading

local lazypath = "@lazy_nvim@"
vim.opt.rtp:prepend(lazypath)

local configpath = "@asa1984_nvim_config_path@"
vim.opt.rtp:prepend(configpath)

require("lazy").setup({
    defaults = {
        lazy = true,
    },
    spec = "plugins",

    -- Prevent lazy.nvim from resetting `packpath` and `rtp` we set
    -- https://github.com/KFearsoff/website/blob/336bb1ba2bcb5a9a325bda3be653fa0e075b93ed/src/lazynvim-nixos.md
    performance = {
        reset_packpath = false,
        rtp = {
            reset = false,
        },
    },
    install = {
        missing = false,
    },
})

require("base")
require("keymap")
