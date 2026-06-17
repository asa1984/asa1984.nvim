{ pkgs }:
{
  editorTools = with pkgs; [
    tinymist
    typstyle
  ];
  toolchain = with pkgs; [ typst ];
}
