{ pkgs }:
{
  # `kcl-language-server` handles formatting, so no Conform entry is needed.
  # It resolves to nixpkgs' build on Linux and to the official prebuilt
  # binary (pinned by nvfetcher) on Darwin, where nixpkgs has no build.
  editorTools = with pkgs; [ kcl-language-server ];
  toolchain = with pkgs; [ kcl ];
}
