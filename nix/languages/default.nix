# Per-language IDE bundles.
#
# Each language module is `{ pkgs }: { editorTools; toolchain; }` where:
#   - editorTools : LSPs / formatters / linters. Injected into the Neovim
#                   wrapper's PATH only (kept out of the interactive shell).
#   - toolchain   : compilers / runtimes / build tools / package managers.
#                   Exposed to the user's shell (and inherited by Neovim).
#
# Adding a language is just dropping a `<name>.nix` file here; both the
# `neovim-full` package and the `programs.asa1984-nvim` Home Manager option
# pick it up automatically.
{ pkgs }:
let
  inherit (pkgs) lib;

  files = builtins.readDir ./.;

  isLanguage =
    name: type:
    type == "regular"
    && lib.hasSuffix ".nix" name
    && name != "default.nix"
    && !(lib.hasPrefix "_" name);

  languageFiles = lib.filterAttrs isLanguage files;
in
lib.mapAttrs' (
  fileName: _:
  lib.nameValuePair (lib.removeSuffix ".nix" fileName) (
    import (./. + "/${fileName}") { inherit pkgs; }
  )
) languageFiles
