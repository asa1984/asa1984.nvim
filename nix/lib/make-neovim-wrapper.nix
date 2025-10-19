{
  neovim ? pkgs.neovim-unwrapped,
  pkgs,
}:
{
  tools ? [ ],
}:
let
  plugins = import ../plugins.nix pkgs;
  extraWrapperArgs = [
    "--suffix"
    "PATH"
    ":"
    (pkgs.lib.makeBinPath tools)
  ];
  preprocessed = pkgs.stdenv.mkDerivation (
    plugins
    // {
      pname = "asa1984-nvim-config";
      version = "latest";
      src = ../../nvim;

      installPhase = ''
        mkdir -p $out
        for file in $(find . -type f); do
          substituteAllInPlace "$file"
        done
        cp -r ./ $out
      '';
    }
  );
  config = pkgs.neovimUtils.makeNeovimConfig {
    withNodeJs = true;
    withRuby = false;
    withPython3 = false;
    vimAlias = true;
    customLuaRC = ''
      vim.opt.rtp:prepend('${preprocessed}')

      ${builtins.readFile "${preprocessed}/init.lua"}
    '';
  };
in
(pkgs.wrapNeovimUnstable neovim (
  config // { wrapperArgs = config.wrapperArgs ++ extraWrapperArgs; }
))
