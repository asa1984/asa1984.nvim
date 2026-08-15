{
  sources,
  vimUtils,
  lib,
}:
let
  # copilot-language-server-* are prebuilt LSP server binaries, not Vim plugins
  pluginSources = lib.filterAttrs (name: _: !(lib.hasPrefix "copilot-language-server-" name)) sources;
in
builtins.mapAttrs (
  key: value:
  vimUtils.buildVimPlugin {
    inherit (value) pname version src;
    dontBuild = true;
    # nixpkgs' neovimRequireCheckHook enters discovery mode for these vendored
    # plugins and trips over repo-local test specs (e.g. gitlinker.nvim's
    # spec_init), so skip the smoke-test require check.
    doCheck = false;
  }
) pluginSources
