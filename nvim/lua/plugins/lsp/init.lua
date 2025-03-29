local formatter = require("plugins.lsp.formatter")
local lsp = require("plugins.lsp.lsp")
local misc = require("plugins.lsp.misc")

table.unpack = table.unpack or unpack -- 5.1 compatibility

return {
    table.unpack(formatter),
    table.unpack(lsp),
    table.unpack(misc),
}
