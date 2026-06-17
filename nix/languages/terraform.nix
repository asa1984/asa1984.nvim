{ pkgs }:
{
  editorTools = with pkgs; [ terraform-ls ];
  toolchain = with pkgs; [
    terraform
    opentofu
  ];
}
