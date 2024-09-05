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
    pkgList:
    pkgs.lib.foldl' (
      acc: pkg:
      let
        pname = pkg.pname;
      in
      acc // { "${normalizePname pname}" = pkg; }
    ) { } pkgList;

  plugins = (pkgListToAttr (import ./vim-plugins.nix { inherit pkgs sources; })) // {
    lazy_nvim = pkgs.callPackage ./lazy-nvim.nix { };
    skk_dict = "${pkgs.skk-dicts}/share/SKK-JISYO.L";
  };

in
plugins
