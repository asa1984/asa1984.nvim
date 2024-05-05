# lazy.nvim reads plugin configs from $HOME/.config/nvim via vim.fn.stdpath("config")
# This modified lazy.nvim refers to $MY_CONFIG_PATH instead of it
# I set Nix store path of my neovim config to $MY_CONFIG_PATH
{
  stdenv,
  vimUtils,
  fetchFromGitHub,
}:
let
  modifiedSrc = stdenv.mkDerivation {
    name = "modified-lazy.nvim-source";
    src = fetchFromGitHub {
      owner = "folke";
      repo = "lazy.nvim";
      rev = "aedcd79811d491b60d0a6577a9c1701063c2a609";
      hash = "sha256-8gbwjDkpXOSiLwv7fIBSZWFPi8kd6jyLMFa3S5BZXdM=";
    };
    installPhase = ''
      mkdir -p $out
      for file in $(find . -type f); do
        substituteInPlace "$file" \
          --replace vim.fn.stdpath\(\"config\"\) vim.fn.expand\(\"\$MY_CONFIG_PATH\"\)
      done
      cp -r ./ $out
    '';
  };
in
vimUtils.buildVimPlugin {
  name = "lazy.nivm";
  src = modifiedSrc;
}
