# The IDE's building blocks for a given nixpkgs instance.
#
# mkIde :: Pkgs -> { pkgs; makeNeovimWrapper; languages; baseEditorTools; }
{ inputs }:
pkgs:
let
  pkgs' = pkgs // import ./extras.nix { inherit inputs pkgs; };
in
{
  pkgs = pkgs';

  # makeNeovimWrapper :: { editorTools: List<Derivation> } -> Derivation
  makeNeovimWrapper = import ./lib/make-neovim-wrapper.nix { pkgs = pkgs'; };

  # languages :: AttrSet<{ editorTools; toolchain; }>
  languages = import ./languages { pkgs = pkgs'; };

  # baseEditorTools :: List<Derivation> (always-on editor tooling)
  baseEditorTools = (import ./languages/_base.nix { pkgs = pkgs'; }).editorTools;
}
