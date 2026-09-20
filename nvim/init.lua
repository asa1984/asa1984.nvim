vim.loader.enable() -- You need to enable vim.loader before loading plugins

vim.g.mapleader = " " -- You need to set this before lazy loading

local lazypath = "@lazy_nvim@"
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    defaults = {
        lazy = true,
    },
    spec = "plugins",

    -- Prevent lazy.nvim from resetting `packpath` and `rtp` we set
    -- https://github.com/KFearsoff/website/blob/336bb1ba2bcb5a9a325bda3be653fa0e075b93ed/src/lazynvim-nixos.md
    performance = {
        reset_packpath = false,
        cache = {
            enabled = true,
        },
        rtp = {
            reset = false,
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "zipPlugin",
                "tutor",
                "toad",
            },
        },
    },
    change_detection = {
        enabled = false,
    },
    checker = {
        enabled = false,
    },
    install = {
        missing = false,
    },
})

require("base")
require("keymap")
