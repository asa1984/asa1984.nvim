# Always-on editor tooling, independent of any single language:
# - Neovim plugin runtime dependencies (telescope, lazygit, ...)
# - Ubiquitous configuration formats (YAML / TOML / JSON / HTML / CSS)
{ pkgs }:
{
  editorTools = with pkgs; [
    # Neovim plugin dependencies
    ripgrep
    lazygit

    # Configuration formats
    yaml-language-server
    taplo # TOML
    vscode-langservers-extracted # JSON / HTML / CSS / ESLint
    just-lsp
  ];

  # No language runtime belongs to the base layer.
  toolchain = [ ];
}
