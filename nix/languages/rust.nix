{ pkgs }:
{
  # fenix's toolchain bundles rustc, cargo, clippy, rustfmt and rust-analyzer.
  # It is shell-visible (toolchain) so `cargo` works from the terminal, and the
  # wrapped Neovim inherits it from the shell PATH for rust-analyzer.
  editorTools = [ ];

  toolchain = [
    (pkgs.fenix.combine [
      pkgs.fenix.latest.toolchain
      pkgs.fenix.targets.wasm32-unknown-unknown.latest.rust-std
    ])
  ];
}
