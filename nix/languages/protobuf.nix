{ pkgs }:
{
  editorTools = with pkgs; [ buf ];
  toolchain = with pkgs; [ protobuf ];
}
