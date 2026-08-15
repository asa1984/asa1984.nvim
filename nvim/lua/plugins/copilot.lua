-- GitHub Copilot
return {
    name = "copilot.lua",
    dir = "@copilot_lua@",
    event = "InsertEnter",
    opts = {
        -- Run the Developer-ID-signed server binary instead of the bundled JS
        -- via nixpkgs' ad-hoc-signed `node`, so macOS Keychain keeps the
        -- "Always Allow" grant for the OAuth token (see nix/pkgs/copilot-language-server).
        server = {
            type = "binary",
            custom_server_filepath = "@copilot_language_server@/bin/copilot-language-server",
        },
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
