# Home Manager module exposing asa1984's Neovim as a language-aware IDE.
#
# Packages are resolved from asa1984.nvim's own pinned nixpkgs (via `self.lib`),
# so the IDE brings its own toolchain versions and does not depend on the
# consumer's overlays (e.g. fenix).
{ self }:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.asa1984-nvim;

  asaLib = self.lib.${pkgs.stdenv.hostPlatform.system};
  inherit (asaLib) languages baseEditorTools makeNeovimWrapper;

  langNames = builtins.attrNames languages;
  enabledNames = builtins.filter (name: cfg.languages.${name}.enable) langNames;

  collect = field: lib.concatMap (name: languages.${name}.${field} or [ ]) enabledNames;

  editorTools = baseEditorTools ++ collect "editorTools" ++ cfg.extraEditorTools;
  toolchains = collect "toolchain" ++ cfg.extraPackages;

  neovim = makeNeovimWrapper { inherit editorTools; };
in
{
  options.programs.asa1984-nvim = {
    enable = lib.mkEnableOption "asa1984's Neovim IDE";

    languages = lib.mapAttrs (name: _: {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable ${name} IDE support (LSP, formatter and toolchain).";
      };
    }) languages;

    extraEditorTools = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description = "Extra packages injected into the Neovim wrapper PATH only.";
    };

    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description = "Extra packages added to the user's shell alongside the IDE.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ neovim ] ++ toolchains;

    programs.zsh.shellAliases = {
      vi = "nvim";
      vim = "nvim";
    };
  };
}
