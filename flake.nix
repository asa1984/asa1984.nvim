{
  description = "asa1984's neovim";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";
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

      # nixpkgs instance carrying asa1984.nvim's own overlays. Used everywhere so
      # the IDE pins its own toolchain versions, independent of any consumer.
      pkgsFor =
        system:
        import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            (import ./nix/overlays).default
            inputs.fenix.overlays.default
          ];
        };
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      inherit systems;

      flake = {
        overlays = import ./nix/overlays;

        homeModules.ide = import ./nix/home-manager { self = inputs.self; };

        lib =
          let
            forAllSystems = inputs.nixpkgs.lib.genAttrs systems;
          in
          forAllSystems (
            system:
            let
              pkgs = pkgsFor system;
            in
            {
              # makeNeovimWrapper :: { editorTools: List<Derivation> } -> Derivation
              makeNeovimWrapper = import ./nix/lib/make-neovim-wrapper.nix {
                inherit pkgs;
                neovim = pkgs.neovim-unwrapped;
              };

              # languages :: AttrSet<{ editorTools; toolchain; }>
              languages = import ./nix/languages { inherit pkgs; };

              # baseEditorTools :: List<Derivation> (always-on editor tooling)
              baseEditorTools = (import ./nix/languages/_base.nix { inherit pkgs; }).editorTools;
            }
          );
      };

      perSystem =
        { system, ... }:
        let
          pkgs = pkgsFor system;
          inherit (pkgs) lib;

          makeNeovimWrapper = import ./nix/lib/make-neovim-wrapper.nix { inherit pkgs; };

          languages = import ./nix/languages { inherit pkgs; };
          baseEditorTools = (import ./nix/languages/_base.nix { inherit pkgs; }).editorTools;
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
