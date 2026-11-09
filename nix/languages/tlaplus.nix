{ pkgs }:
{
  # No language server: tlapm's `tlapm_lsp` only covers TLAPS proofs and has
  # no packaged release to pin, so TLA+ gets just the formatter.
  editorTools = with pkgs; [ tlafmt ];
  # TLC, SANY, PlusCal translator, TLATeX and the REPL.
  toolchain = with pkgs; [ tlaplus18 ];
}
