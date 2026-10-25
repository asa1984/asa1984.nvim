{ pkgs }:
{
  # The stable toolchain from rust-overlay bundles rustc, cargo, clippy and
  # rustfmt; rust-analyzer and rust-src are added as extensions. Projects pin
  # their own versions through rust-toolchain.toml.
  # It is shell-visible (toolchain) so `cargo` works from the terminal, and the
  # wrapped Neovim inherits it from the shell PATH for rust-analyzer.
  editorTools = [ ];

  toolchain = [
    (pkgs.rust-bin.stable.latest.default.override {
      extensions = [
        "rust-analyzer"
        "rust-src"
      ];
      targets = [ "wasm32-unknown-unknown" ];
    })
  ];
}
