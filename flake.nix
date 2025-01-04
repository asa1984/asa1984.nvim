{
  description = "asa1984's neovim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    git-hooks.url = "github:cachix/git-hooks.nix";

    neovim-nightly-overlay.inputs.git-hooks.follows = "git-hooks";
    git-hooks.inputs.nixpkgs.follows = "nixpkgs";
    git-hooks.inputs.nixpkgs-stable.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      neovim-nightly-overlay,
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
      overlays = import ./nix/overlays;

      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              # neovim-nightly-overlay.overlays.default # This cause build-error on aarch64-darwin
              self.overlays.default
            ];
          };

          plugins = import ./nix/plugins.nix pkgs;
          tools = import ./nix/tools.nix pkgs;
          neovim-nightly = neovim-nightly-overlay.packages.${system}.default;
          makeNeovimWrapper = import ./nix/wrapper.nix neovim-nightly pkgs;
          neovimConfig = pkgs.callPackage ./nix/config.nix { inherit plugins; };
        in
        rec {
          default = neovim-minimal;
          neovim-minimal = makeNeovimWrapper [ ];
          neovim-light = makeNeovimWrapper tools.primarry;
          neovim-full = makeNeovimWrapper (tools.primarry ++ tools.secondary);
          config = neovimConfig;
        }
        // (import ./nix/pkgs { inherit pkgs; }).vimPlugins
      );

      lib = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              self.overlays.default
            ];
          };
          neovim-nightly = neovim-nightly-overlay.packages.${system}.default;
          makeNeovimWrapper = import ./nix/wrapper.nix neovim-nightly pkgs;
        in
        {
          # makeNeovimWrapper :: [extraPackages] -> derivation
          inherit makeNeovimWrapper;
        }
      );

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

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            inherit (self.checks.${system}.pre-commit-check) shellHook;
            packages = with pkgs; [
              stylua
              lua-language-server
              nvfetcher
            ];
          };
        }
      );
    };

  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
