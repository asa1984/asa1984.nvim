{ pkgs }:
{
  editorTools = with pkgs; [ gopls ];
  toolchain = with pkgs; [ go ];
}
