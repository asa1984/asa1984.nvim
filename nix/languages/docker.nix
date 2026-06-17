{ pkgs }:
{
  editorTools = with pkgs; [ dockerfile-language-server ];
  toolchain = [ ];
}
