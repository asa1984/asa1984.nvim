-- Lean 4: infoview, unicode abbreviations and the Lean language server.
-- lean.nvim ships its own `lsp/leanls.lua` and enables it in `setup()`, so
-- `leanls` is intentionally absent from nvim-lspconfig's enable list.
return {
    name = "lean.nvim",
    dir = "@lean_nvim@",
    event = { "BufReadPre *.lean", "BufNewFile *.lean" },
    opts = {
        mappings = true,
    },
}
