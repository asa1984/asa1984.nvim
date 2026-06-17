{ pkgs }:
{
  editorTools = with pkgs; [
    lua-language-server
    stylua
  ];
  # Neovim embeds its own Lua; a standalone runtime is rarely needed.
  toolchain = [ ];
}
