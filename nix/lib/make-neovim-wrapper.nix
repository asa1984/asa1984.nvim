{
  neovim ? pkgs.neovim-unwrapped,
  pkgs,
}:
{
  tools ? [ ],
}:
let
  plugins = import ../plugins.nix pkgs;

  # Neovim Lua configuration with `@plugin@` placeholders substituted with actual store paths
  luaConfig = pkgs.stdenv.mkDerivation (
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

  # Comma-separated string of Neovim Treesitter parser store paths
  treesitterParserPathsString =
    let
      treesitterParsers = builtins.attrValues pkgs.vimPlugins.nvim-treesitter-parsers;
      isDerivation = p: p ? type && p.type == "derivation";
    in
    pkgs.lib.pipe treesitterParsers [
      (builtins.filter isDerivation)
      (builtins.map builtins.toString)
      (builtins.concatStringsSep ",")
    ];

  config = pkgs.neovimUtils.makeNeovimConfig {
    withNodeJs = true;
    withRuby = false;
    withPython3 = false;
    vimAlias = true;
    customLuaRC = # Lua
      ''
        local treesitter_parser_paths = os.getenv("TREESITTER_PARSER_PATHS")
        vim.opt.runtimepath:append(treesitter_parser_paths)

        local config_path = os.getenv("NVIM_LUA_CONFIG_DIR")
        vim.opt.rtp:prepend(config_path)
        local init = config_path .. "/init.lua"
        if vim.fn.filereadable(init) == 1 then
            vim.cmd("luafile " .. init)
        end
      '';
  };

  wrappedNeovim = pkgs.wrapNeovimUnstable neovim (
    config
    // {
      wrapperArgs = config.wrapperArgs ++ [
        "--suffix"
        "PATH"
        ":"
        (pkgs.lib.makeBinPath tools)
      ];
    }
  );
in
pkgs.writeShellScriptBin "nvim" ''
  export NVIM_LUA_CONFIG_DIR="${luaConfig}"
  export TREESITTER_PARSER_PATHS="${treesitterParserPathsString}"
  exec ${pkgs.lib.getExe wrappedNeovim} "$@"
''
