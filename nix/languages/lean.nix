{ pkgs }:
{
  # Lean's language server is `lake serve` (or `lean --server`), which ships
  # with each toolchain, so there is nothing editor-only to add.
  editorTools = [ ];

  # Projects pin their Lean version in `lean-toolchain`; elan resolves and
  # installs it on demand, so a single nixpkgs `lean4` would not fit.
  toolchain = [ pkgs.elan ];
}
