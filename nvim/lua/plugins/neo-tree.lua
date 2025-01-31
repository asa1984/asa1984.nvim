local get_icon = require("utils").get_icon

-- File explorer
return {
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
                position = "right",
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
}
