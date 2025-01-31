-- Fuzzy finder
return {
    name = "telescope.nvim",
    dir = "@telescope_nvim@",
    cmd = "Telescope",
    dependencies = {
        { name = "plenary.nvim", dir = "@plenary_nvim@" },
        { name = "telescope-file-browser.nvim", dir = "@telescope_file_browser_nvim@" },
    },
    opts = function()
        local telescope_actions = require("telescope.actions")
        return {
            defaults = {
                file_ignore_patterns = {
                    "node_modules",
                    ".git",
                },
                mappings = {
                    n = {
                        ["q"] = telescope_actions.close,
                    },
                },
            },
        }
    end,
    keys = {
        {
            ";f",
            function()
                require("telescope.builtin").find_files()
            end,
            desc = "Find files",
        },
        {
            ";r",
            function()
                require("telescope.builtin").live_grep()
            end,
            desc = "Live grep",
        },
        {
            ";b",
            function()
                require("telescope.builtin").buffers()
            end,
            desc = "Switch tabs",
        },
        {
            ";d",
            function()
                require("telescope.builtin").diagnostics(require("telescope.themes").get_dropdown({
                    winblend = 10,
                }))
            end,
            desc = "Find diagnostics",
        },
        {
            "sf",
            function()
                local telescope = require("telescope")
                local function telescope_buffer_dir()
                    return vim.fn.expand("%:p:h")
                end
                telescope.extensions.file_browser.file_browser({
                    path = "%:p:h",
                    cwd = telescope_buffer_dir(),
                    respect_gitignore = false,
                    hidden = true,
                    grouped = true,
                    previewer = false,
                    initial_mode = "normal",
                    layout_config = { height = 40 },
                })
            end,
            desc = "Show files in current directory",
        },
    },
}
