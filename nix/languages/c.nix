{ pkgs }:
{
  editorTools = with pkgs; [ clang-tools ];
  toolchain = with pkgs; [ gcc ];
}
