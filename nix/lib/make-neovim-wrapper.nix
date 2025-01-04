{
  neovim,
  pkgs,
}:
{
  extraPackages,
}:
let
  plugins = import ../plugins.nix pkgs;
  nvimConfig = pkgs.callPackage ../config.nix { inherit plugins; };
in
pkgs.writeShellScriptBin "nvim" ''
  PATH=$PATH:${pkgs.lib.makeBinPath extraPackages}
  MY_CONFIG_PATH=${nvimConfig} ${neovim}/bin/nvim -u ${nvimConfig}/init.lua "$@"
''
