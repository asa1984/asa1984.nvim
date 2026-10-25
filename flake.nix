{
  description = "asa1984's neovim";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";

    flake-parts.url = "github:hercules-ci/flake-parts";

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

    # Prebuilt MoonBit toolchains (not packaged in nixpkgs)
    moonbit-overlay.url = "github:moonbit-community/moonbit-overlay";
    moonbit-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs:
    let
      systems = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
      ];

      # The flake's own nixpkgs, for the standalone packages and `lib.<system>`.
      # The Home Manager module uses the consumer's pkgs instead (see mkIde).
      pkgsFor =
        system:
        import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

      mkIde = import ./nix/ide.nix { inherit inputs; };
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      inherit systems;

      flake = {
        # For consumers that prefer an overlay to `lib.mkIde`.
        overlays.default =
          final: prev:
          import ./nix/extras.nix {
            inherit inputs;
            pkgs = prev;
          };

        homeModules.ide = import ./nix/home-manager { inherit mkIde; };

        lib = {
          inherit mkIde;
        }
        // inputs.nixpkgs.lib.genAttrs systems (system: removeAttrs (mkIde (pkgsFor system)) [ "pkgs" ]);
      };

      perSystem =
        { system, ... }:
        let
          pkgs = pkgsFor system;
          inherit (pkgs) lib;
          inherit (mkIde pkgs) makeNeovimWrapper languages baseEditorTools;

          allEditorTools =
            baseEditorTools ++ lib.concatMap (l: l.editorTools or [ ]) (builtins.attrValues languages);
        in
        {
          _module.args.pkgs = pkgs;

          packages = rec {
            default = neovim-minimal;
            neovim-minimal = makeNeovimWrapper { };
            neovim-light = makeNeovimWrapper { editorTools = baseEditorTools; };
            neovim-full = makeNeovimWrapper { editorTools = allEditorTools; };
          }
          // (import ./nix/pkgs { inherit pkgs; }).vimPlugins;

          formatter = pkgs.nixfmt-tree;
        };
    };
}
