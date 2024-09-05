{
  description = "asa1984's neovim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    let
      allSystems = [
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-linux" # 64-bit x86 Linux
        "aarch64-darwin" # 64-bit ARM macOS
        "x86_64-darwin" # 64-bit x86 macOS
      ];
      forAllSystems = inputs.nixpkgs.lib.genAttrs allSystems;
    in
    {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              stylua
              lua-language-server
              nvfetcher
            ];
          };
        }
      );
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          lib = pkgs.lib;

          sources = pkgs.callPackage ./_sources/generated.nix { };

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
            lib.foldl' (
              acc: pkg:
              let
                pname = pkg.pname;
              in
              acc // { "${normalizePname pname}" = pkg; }
            ) { } pkgList;

          plugins = (pkgListToAttr (import ./plugins.nix { inherit pkgs sources; })) // {
            lazy_nvim = pkgs.callPackage ./pkgs/lazy-nvim.nix { };
            nvim_treesitter = pkgs.vimPlugins.nvim-treesitter;
            skk_dict = "${pkgs.skk-dicts}/share/SKK-JISYO.L";
          };

          mainDevTools = with pkgs; [
            # Inner tools
            ## For telescope.nvim
            ripgrep

            ## Git TUI
            lazygit

            # Web
            ## HTML/CSS
            nodePackages.vscode-langservers-extracted

            ## JavaScript/TypeScript/Frameworks
            biome
            deno
            eslint
            nodePackages.prettier
            nodePackages.typescript-language-server
            nodePackages."@astrojs/language-server"
            nodePackages."@tailwindcss/language-server"

            ## GraphQL
            nodePackages.graphql-language-service-cli

            # Programming languages
            ## Lua
            lua-language-server
            stylua

            ## Nix
            nil
            nixfmt-rfc-style

            # Configuration languages
            ## TOML
            taplo
          ];

          subDevTools = with pkgs; [
            # Bash
            nodePackages.bash-language-server

            # C/C++
            clang-tools

            # Docker
            nodePackages.dockerfile-language-server-nodejs

            # Go
            gopls

            # Haskell
            haskell-language-server
            haskellPackages.fourmolu

            # OCaml
            ocamlPackages.ocaml-lsp
            ocamlformat

            # Protocol Buffers
            buf-language-server

            # Python
            ruff
            pyright

            # Shell
            shellcheck
            shfmt

            # Typst
            typst-lsp
            typstfmt

            # Zig
            zls
          ];

          nvimConfig = pkgs.callPackage ./config.nix { inherit self plugins; };
          nvimWrapped =
            extraPackages:
            pkgs.writeShellScriptBin "nvim" ''
              PATH=$PATH:${lib.makeBinPath extraPackages}
              MY_CONFIG_PATH=${nvimConfig} ${pkgs.neovim-unwrapped}/bin/nvim -u ${nvimConfig}/init.lua "$@"
            '';
        in
        rec {
          default = neovim-full;
          neovim-full = nvimWrapped (mainDevTools ++ subDevTools);
          neovim-light = nvimWrapped mainDevTools;
          neovim-minimal = nvimWrapped [ ];
          config = nvimConfig;
        }
      );
    };
}
