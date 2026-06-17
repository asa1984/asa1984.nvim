{ pkgs }:
{
  editorTools = with pkgs; [
    bash-language-server
    shellcheck
    shfmt
  ];
  # Shell is provided by the host system.
  toolchain = [ ];
}
