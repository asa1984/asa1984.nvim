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
    };

}
