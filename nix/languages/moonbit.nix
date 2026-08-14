{ pkgs }:
let
  inherit (pkgs.stdenv.hostPlatform) isLinux isDarwin isx86_64 isAarch64;

  # moonbit-community/moonbit-overlay repacks the upstream prebuilt toolchains,
  # which are only published for linux-x86_64 and darwin-aarch64.
  supported = (isLinux && isx86_64) || (isDarwin && isAarch64);
in
{
  # The bundle ships `moon-lsp` alongside `moon`/`moonc` and resolves the core
  # library relative to itself, so it cannot be split into an editor-only
  # package. Like Rust, the whole toolchain is shell-visible and the wrapped
  # Neovim inherits moon-lsp from the shell PATH.
  editorTools = [ ];

  toolchain = pkgs.lib.optionals supported [ pkgs.moonbit-bin.moonbit.latest ];
}
