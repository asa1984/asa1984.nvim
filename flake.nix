{
  description = "asa1984's neovim";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
  };

  outputs =
    inputs:
    let
      systems = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      inherit systems;

      flake = {
        overlays = import ./nix/overlays;

        lib =
          let
            forAllSystems = inputs.nixpkgs.lib.genAttrs systems;
          in
          forAllSystems (
            system:
            let
              pkgs = import inputs.nixpkgs {
                inherit system;
                overlays = [ inputs.self.overlays.default ];
              };
              makeNeovimWrapper = import ./nix/lib/make-neovim-wrapper.nix {
                inherit pkgs;
                neovim = pkgs.neovim-unwrapped;
              };
            in
            {
              # makeNeovimWrapper :: { extraPackages: List<Derivation> } -> Derivation
              inherit makeNeovimWrapper;
            }
          );
      };

      perSystem =
        {
          pkgs,
          self',
          system,
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              (import ./nix/overlays).default
            ];
          };

          packages =
            let
              tools = import ./nix/tools.nix pkgs;

              makeNeovimWrapper = import ./nix/lib/make-neovim-wrapper.nix {
                inherit pkgs;
              };
            in
            rec {
              default = neovim-minimal;
              neovim-minimal = makeNeovimWrapper { };
              neovim-light = makeNeovimWrapper { tools = tools.primarry; };
              neovim-full = makeNeovimWrapper { tools = tools.primarry ++ tools.secondary; };
            }
            // (import ./nix/pkgs { inherit pkgs; }).vimPlugins;

          formatter = pkgs.nixfmt-tree;
        };

    };
}
