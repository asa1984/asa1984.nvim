{ pkgs }:
{
  editorTools = with pkgs; [ zls ];
  toolchain = with pkgs; [ zig ];
}
