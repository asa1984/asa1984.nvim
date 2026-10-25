# Home Manager module exposing asa1984's Neovim as a language-aware IDE.
#
# Packages are built from the consumer's pkgs (overlays included), so the IDE
# shares nixpkgs with the rest of the system instead of pulling in a second
# copy. To keep the versions this flake was tested with, have the consumer's
# nixpkgs and this flake's follow the same input.
{ mkIde }:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.asa1984-nvim;

  inherit (mkIde pkgs) languages baseEditorTools makeNeovimWrapper;

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
