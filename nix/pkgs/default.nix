{ pkgs }:
let
  sources = import ../../_sources/generated.nix {
    inherit (pkgs)
      fetchgit
      fetchurl
      fetchFromGitHub
      dockerTools
      ;
  };
in
{
  vimPlugins = import ./vim-plugins {
    inherit sources;
    inherit (pkgs) vimUtils;
  };
}
