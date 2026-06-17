{ pkgs }:
{
  editorTools = with pkgs; [
    ocamlPackages.ocaml-lsp
    ocamlformat
  ];
  toolchain = with pkgs; [
    ocaml
    ocamlPackages.dune_3
  ];
}
