{
  description = "asa1984's neovim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      git-hooks,
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
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          plugins = import ./plugins { inherit pkgs; };
          tools = import ./tools.nix { inherit pkgs; };

          nvimConfig = pkgs.callPackage ./config.nix { inherit plugins; };

          mkNeovimWrapper = import ./wrapper.nix pkgs;
        in
        rec {
          default = neovim-minimal;
          neovim-full = mkNeovimWrapper (tools.primarry ++ tools.secondary);
          neovim-light = mkNeovimWrapper tools.primarry;
          neovim-minimal = mkNeovimWrapper [ ];
          config = nvimConfig;
        }
      );

      lib = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          mkNeovimWrapper = import ./wrapper.nix pkgs;
        in
        {
          # mkNeovimWrapper :: [extraPackages] -> derivation
          inherit mkNeovimWrapper;
        }
      );

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

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);

      checks = forAllSystems (system: {
        pre-commit-check = git-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixfmt-rfc-style.enable = true;
            stylua.enable = true;
            actionlint.enable = true;
          };
        };
      });
    };
}
