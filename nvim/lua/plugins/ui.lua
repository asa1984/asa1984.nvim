local get_icon = require("utils").get_icon

return {
    -- Startup
    {
        name = "alpha.nvim",
        dir = "@alpha_nvim@",
        event = "VimEnter",
        opts = function()
            local theme = require("alpha.themes.theta")
            local config = theme.config
            local button = require("alpha.themes.dashboard").button
            local logo = {
                "                                                     ",
                "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
                "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
                "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
                "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
                "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
                "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
                "                                                     ",
            }
            local buttons = {
                type = "group",
                val = {
                    { type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
                    { type = "padding", val = 1 },
                    button("f", get_icon("Search") .. "  Telescope", "<cmd>Telescope find_files<cr>"),
                    button("r", get_icon("SearchText") .. "  Ripgrep", "<cmd>Telescope live_grep<cr>"),
                    button("l", get_icon("Lazy") .. " Lazy", "<cmd>Lazy<cr>"),
                    button("q", get_icon("BufferClose") .. "  Quit", "<cmd>qa<cr>"),
                },
                position = "center",
            }
            config.layout[2].val = logo
            config.layout[6] = buttons
            return config
        end,
    },

    -- Terminal
    {
        name = "toggleterm.nvim",
        dir = "@toggleterm_nvim@",
        cmd = "ToggleTerm",
        opts = {
            size = 10,
            shading_factor = 2,
            open_mapping = [[<f7>]],
            direction = "float",
            float_opts = {
                border = "curved",
            },
        },
    },

    -- Indent
    {
        name = "hlchunk.nivm",
        dir = "@hlchunk_nvim@",
        dependencies = {
            { name = "nvim-treesitter", dir = "@nvim_treesitter@" },
        },
        event = "BufRead",
        config = function()
            require("hlchunk").setup({
                chunk = {
                    enable = true,
                    use_treesitter = true,
                    duration = 100,
                    delay = 200,
                },
                indent = { enable = false },
                line_num = { enable = false },
                blank = { enable = false },
            })
        end,
    },

    -- Scrollbar
    {
        name = "nvim-scrollbar",
        dir = "@nvim_scrollbar@",
        event = "BufReadPost",
        dependencies = { name = "nvim-hlslens", dir = "@nvim_hlslens@" },
        config = function()
            local colors = require("tokyonight.colors").setup()
            require("scrollbar").setup({
                hide_if_all_visible = true,
                excluded_buftypes = {
                    "TelescopePrompt",
                    "neo-tree",
                    "noice",
                    "notify",
                    "prompt",
                    "terminal",
                },
                handle = { color = colors.bg_highlight },
                marks = {
                    Search = { color = colors.orange },
                    Error = { color = colors.error },
                    Warn = { color = colors.warning },
                    Info = { color = colors.info },
                    Hint = { color = colors.hint },
                    Misc = { color = colors.purple },
                },
            })

            -- Search highlight
            require("scrollbar.handlers.search").setup({ -- wrapper for hlslens.nvim
                calm_down = true,
            })
        end,
    },

    -- File explorer
    {
        name = "neo-tree.nvim",
        dir = "@neo_tree_nvim@",
        cmd = "Neotree",
        dependencies = {
            { name = "plenary.nvim", dir = "@plenary_nvim@" },
            { name = "nvim-web-devicons", dir = "@nvim_web_devicons@" },
            { name = "nui.nvim", dir = "@nui_nvim@" },
        },
        opts = function()
            return {
                close_if_last_window = true,
                window = {
                    width = 30,
                    mappings = {
                        ["<space>"] = false,
                    },
                },
                filesystem = {
                    filtered_items = {
                        hide_dotfiles = false,
                    },
                },
                default_component_configs = {
                    indent = { padding = 0 },
                    icon = {
                        folder_closed = get_icon("FolderClosed"),
                        folder_open = get_icon("FolderOpen"),
                        folder_empty = get_icon("FolderEmpty"),
                        folder_empty_open = get_icon("FolderEmpty"),
                        default = get_icon("DefaultFile"),
                    },
                    modified = { symbol = get_icon("FileModified") },
                    git_status = {
                        symbols = {
                            added = get_icon("GitAdd"),
                            deleted = get_icon("GitDelete"),
                            modified = get_icon("GitChange"),
                            renamed = get_icon("GitRenamed"),
                            untracked = get_icon("GitUntracked"),
                            ignored = get_icon("GitIgnored"),
                            unstaged = get_icon("GitUnstaged"),
                            staged = get_icon("GitStaged"),
                            conflict = get_icon("GitConflict"),
                        },
                    },
                },
            }
        end,
    },
}
