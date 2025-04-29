return {
    name = "snacks.nvim",
    dir = "@snacks_nvim@",
    priority = 1000,
    lazy = false,
    opts = {
        bufdelete = { enabled = true },
        explorer = { enabled = true },
        gitbrowse = { enabled = true },
        image = { enabled = true },
        lazygit = { enabled = true },
        notifier = { enabled = true },
        picker = { enabled = true },
    },
    keys = {
        -- Buffer Delete
        {
            ";q",
            function()
                Snacks.bufdelete()
            end,
            desc = "Delete buffer",
        },
        {
            ";Q",
            function()
                Snacks.bufdelete.delete({ force = true })
            end,
            desc = "Delete buffer (force)",
        },

        -- File Explorer
        {
            "<leader>e",
            function()
                Snacks.explorer({
                    git_status_open = true,
                    replace_netrw = true,
                    win = {
                        list = {
                            keys = {
                                ["<c-l>"] = function()
                                    local keys = vim.api.nvim_replace_termcodes("<C-w>l", true, true, true)
                                    vim.api.nvim_feedkeys(keys, "n", false)
                                end,
                                ["<c-h>"] = function()
                                    local keys = vim.api.nvim_replace_termcodes("<C-w>h", true, true, true)
                                    vim.api.nvim_feedkeys(keys, "n", false)
                                end,
                            },
                        },
                    },
                })
            end,
            desc = "File Explorer",
        },

        -- Picker
        {
            ";f",
            function()
                Snacks.picker.files()
            end,
            desc = "Find Files",
        },
        {
            ";b",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Switch Buffers",
        },
        {
            ";g",
            function()
                Snacks.picker.grep()
            end,
            desc = "Grep",
        },
        {
            ";r",
            function()
                Snacks.picker.recent()
            end,
            desc = "Recent Files",
        },
        {
            ";n",
            function()
                Snacks.picker.notifications()
            end,
            desc = "Notifications",
        },

        -- LSP
        {
            "gd",
            function()
                Snacks.picker.lsp_definitions()
            end,
            desc = "Goto Definition",
        },
        {
            "gD",
            function()
                Snacks.picker.lsp_declarations()
            end,
            desc = "Goto Declaration",
        },
        {
            "gr",
            function()
                Snacks.picker.lsp_references()
            end,
            desc = "References",
        },
        {
            "gi",
            function()
                Snacks.picker.lsp_implementations()
            end,
            desc = "Goto Implementations",
        },
        {
            "gt",
            function()
                Snacks.picker.lsp_type_definitions()
            end,
            desc = "Goto Type Definitions",
        },

        -- Lazygit
        {
            "<leader>gg",
            function()
                Snacks.lazygit()
            end,
            desc = "Lazygit",
        },
    },
    init = function()
        vim.api.nvim_create_user_command("Notifications", function()
            Snacks.notifier.show_history()
        end, {
            desc = "Show Notifier History",
        })

        vim.api.nvim_create_user_command("GitBrowse", function()
            Snacks.gitbrowse.open()
        end, {
            desc = "Open File in GitHub",
        })
    end,
}
