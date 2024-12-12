{
  plugins,
  lib,
  stdenv,
  vimPlugins,
}:
let
  envVars = plugins // {
    treesitter_parsers = lib.pipe (builtins.attrValues vimPlugins.nvim-treesitter-parsers) [
      (builtins.map builtins.toString)
      (builtins.concatStringsSep ",")
    ];
  };
  preprocessed = stdenv.mkDerivation (
    envVars
    // {
      pname = "asa1984-nvim-config";
      version = "latest";
      src = ../nvim;

      installPhase = ''
        mkdir -p $out
        for file in $(find . -type f); do
          substituteAllInPlace "$file"
        done
        cp -r ./ $out
      '';
    }
  );
in
stdenv.mkDerivation {
  pname = "asa1984-nvim-config";
  version = "latest";
  src = preprocessed;

  asa1984_nvim_config_path = preprocessed;

  installPhase = ''
    mkdir -p $out
    substituteAllInPlace ./init.lua
    cp -r ./ $out
  '';
}
