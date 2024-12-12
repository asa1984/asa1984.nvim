{ pkgs }:
let
  sources = pkgs.callPackage ../_sources/generated.nix { };
in
let
  normalizePname =
    pname:
    builtins.replaceStrings
      [
        "-"
        "."
      ]
      [
        "_"
        "_"
      ]
      (pkgs.lib.toLower pname);

  pkgListToAttr =
    pkgList: pkgs.lib.foldl' (acc: pkg: acc // { "${normalizePname pkg.pname}" = pkg; }) { } pkgList;

  plugins = (pkgListToAttr (import ./vim-plugins.nix { inherit pkgs sources; }));
in
plugins
