{ pkgs }:
{
  # The language server is the compiler itself (`koka --language-server`), so
  # it cannot be split into an editor-only package. Like MoonBit, the whole
  # toolchain is shell-visible and the wrapped Neovim inherits it from PATH.
  editorTools = [ ];
  toolchain = with pkgs; [ koka ];
}
