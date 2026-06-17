{ pkgs }:
{
  editorTools = with pkgs; [
    pyright
    ruff
  ];
  toolchain = with pkgs; [ python3 ];
}
