local formatter = require("plugins.lsp.formatter")
local lsp = require("plugins.lsp.lsp")
local ui = require("plugins.lsp.ui")
local misc = require("plugins.lsp.misc")

table.unpack = table.unpack or unpack -- 5.1 compatibility

return {
    table.unpack(formatter),
    table.unpack(lsp),
    table.unpack(ui),
    table.unpack(misc),
}
