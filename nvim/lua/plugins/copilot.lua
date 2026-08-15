-- GitHub Copilot

-- Store path of the Developer-ID-signed server binary, empty on the platforms
-- where it is not pinned (see nix/lib/make-neovim-wrapper.nix).
local signed_server = "@copilot_language_server@"

return {
    name = "copilot.lua",
    dir = "@copilot_lua@",
    event = "InsertEnter",
    opts = {
        -- Run the signed server binary instead of the bundled JS via nixpkgs'
        -- ad-hoc-signed `node`, so macOS Keychain keeps the "Always Allow" grant
        -- for the OAuth token (see nix/pkgs/copilot-language-server). Without a
        -- signed binary, leave copilot.lua on its own default.
        server = signed_server ~= "" and {
            type = "binary",
            custom_server_filepath = signed_server .. "/bin/copilot-language-server",
        } or nil,
        suggestion = {
            enabled = true,
            auto_trigger = true,
            keymap = { accept = "<C-l>" },
        },
        filetypes = {
            markdown = false,
            gitcommit = true,
            yaml = true,
        },
    },
}
