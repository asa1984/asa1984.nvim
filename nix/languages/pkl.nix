{ pkgs }:
{
  editorTools = with pkgs; [ pkl-lsp ];
  toolchain = with pkgs; [ pkl ];
}
