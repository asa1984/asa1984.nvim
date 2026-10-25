# Attributes the IDE expects on top of plain nixpkgs, derived from any nixpkgs
# instance `pkgs`.
#
# Callers merge this into `pkgs` with `//` instead of applying it as an
# overlay, so a consumer's pkgs (with its own overlays) can be used as is:
# the IDE then shares that nixpkgs instead of evaluating one of its own.
{ inputs, pkgs }:
let
  myPkgs = import ./pkgs { inherit pkgs; };
in
myPkgs
// {
  rust-bin = inputs.rust-overlay.lib.mkRustBin { } pkgs;

  # Prebuilt MoonBit toolchains (not packaged in nixpkgs). Pick the attribute
  # by calling the overlay with final = prev = pkgs, which skips re-running the
  # whole nixpkgs fixpoint.
  moonbit-bin = (inputs.moonbit-overlay.overlays.default pkgs pkgs).moonbit-bin;

  vimPlugins =
    pkgs.vimPlugins
    // myPkgs.vimPlugins
    // {
      # hmts.nvim 1.3.0 uses the pre-0.12 Treesitter predicate API, where
      # handlers received a single node per capture. Neovim 0.12 passes a
      # list of nodes instead, so its `match[capture]:parent()` calls crash
      # on every .nix file with injections. Patch it until upstream updates.
      hmts-nvim = pkgs.vimPlugins.hmts-nvim.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [ ./patches/hmts-nvim-neovim-0.12.patch ];
      });

      # MoonBit is not in nvim-treesitter's official parser list, so nixpkgs
      # ships no prebuilt parser. Build the upstream grammar here; its
      # Neovim-compatible queries/ are installed next to the parser by
      # grammarToPlugin, so highlighting works with no vendored queries.
      nvim-treesitter-parsers = pkgs.vimPlugins.nvim-treesitter-parsers // {
        moonbit = pkgs.neovimUtils.grammarToPlugin (
          pkgs.tree-sitter.buildGrammar {
            language = "moonbit";
            version = "0.1.0+rev=5435c307";
            src = pkgs.fetchFromGitHub {
              owner = "moonbitlang";
              repo = "tree-sitter-moonbit";
              rev = "5435c307c6cf2ef0d508a99047b06f35a4308444";
              hash = "sha256-UUEjrF6uGwTtFGRjmjw75ky8eDwVwAHOHro48TAI+WM=";
            };
          }
        );
      };
    };
}
