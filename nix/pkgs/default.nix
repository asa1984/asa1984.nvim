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
    inherit (pkgs) vimUtils lib;
  };

  copilot-language-server = import ./copilot-language-server {
    inherit sources;
    inherit (pkgs) stdenv unzip;
  };
}
