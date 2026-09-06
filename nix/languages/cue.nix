{ pkgs }:
{
  # `cue` provides both the language server (`cue lsp`, with formatting
  # support) and the formatter (`cue fmt`).
  editorTools = with pkgs; [ cue ];
  toolchain = with pkgs; [ cue ];
}
