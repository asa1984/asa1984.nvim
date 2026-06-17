{ pkgs }:
{
  editorTools = with pkgs; [
    nil
    nixfmt
  ];
  # Nix itself is provided by the host system.
  toolchain = [ ];
}
