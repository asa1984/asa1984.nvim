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

  # nixpkgs' kcl-language-server is Linux-only, so Darwin uses the official
  # prebuilt binary pinned by nvfetcher instead.
  kcl-language-server =
    if pkgs.stdenv.hostPlatform.isDarwin then
      import ./kcl-language-server {
        inherit sources;
        inherit (pkgs) stdenv;
      }
    else
      pkgs.kcl-language-server;
}
