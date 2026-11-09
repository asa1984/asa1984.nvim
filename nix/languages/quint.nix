{ pkgs }:
{
  editorTools = with pkgs; [ quint-language-server ];
  toolchain = with pkgs; [ quint ];
}
