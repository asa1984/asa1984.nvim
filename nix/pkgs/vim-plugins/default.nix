{
  sources,
  vimUtils,
  lib,
}:
let
  # *-language-server-* are prebuilt LSP server binaries, not Vim plugins
  nonPluginPrefixes = [
    "copilot-language-server-"
    "kcl-language-server-"
  ];
  pluginSources = lib.filterAttrs (
    name: _: !(lib.any (prefix: lib.hasPrefix prefix name) nonPluginPrefixes)
  ) sources;
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
