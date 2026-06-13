local utils = require("utils")

-- Character code
vim.encoding = "utf-8"
vim.fileencoding = "utf-8"
vim.opt.encoding = "utf-8"

-- Scroll
vim.opt.scroll = 10
vim.opt.scrolloff = 8

-- Row
vim.opt.number = true
vim.opt.numberwidth = 5
vim.opt.cursorline = true

-- Tab, Indent
vim.opt.tabstop = 2
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.autoindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Fold
vim.opt.foldcolumn = "1"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- UI
vim.opt.cmdheight = 1
vim.opt.laststatus = 3 -- Always show statusline
vim.opt.showtabline = 2 -- Always show tabline
vim.opt.signcolumn = "yes" -- Always show signcolumn
vim.opt.termguicolors = true -- Enable 24-bit RGB colors

-- File
vim.opt.backup = false
vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.updatetime = 500

-- Misc
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.mouse = "a" -- Disable mouse

-- Use OSC 52 for clipboard over SSH.
-- Many terminals (e.g. WezTerm) do not allow OSC 52 read for security reasons,
-- so paste falls back to a local cache of the last copied text. To paste from
-- the host clipboard, use the terminal's native paste shortcut in insert mode.
if vim.env.SSH_TTY then
    local osc52 = require("vim.ui.clipboard.osc52")
    local cache = { ["+"] = { "" }, ["*"] = { "" } }
    local function make_copy(reg)
        local inner = osc52.copy(reg)
        return function(lines, regtype)
            cache[reg] = lines
            inner(lines, regtype)
        end
    end
    vim.g.clipboard = {
        name = "OSC 52",
        copy = {
            ["+"] = make_copy("+"),
            ["*"] = make_copy("*"),
        },
        paste = {
            ["+"] = function()
                return cache["+"]
            end,
            ["*"] = function()
                return cache["*"]
            end,
        },
    }
end

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Detect .mdx files as the `mdx` filetype (used by the MDX LSP, formatter, etc.)
vim.filetype.add({
    extension = {
        mdx = "mdx",
    },
})

-- Lua indent settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function()
        vim.bo.tabstop = 4
        vim.bo.shiftwidth = 4
        vim.bo.expandtab = true
    end,
})

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = utils.get_icon("DiagnosticError"),
            [vim.diagnostic.severity.HINT] = utils.get_icon("DiagnosticHint"),
            [vim.diagnostic.severity.INFO] = utils.get_icon("DiagnosticInfo"),
            [vim.diagnostic.severity.WARN] = utils.get_icon("DiagnosticWarn"),
        },
    },
})
