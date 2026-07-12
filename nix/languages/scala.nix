{ pkgs }:
{
  # Metals is the Scala language server (self-contained, bundles its own JRE);
  # scalafmt is the formatter driven by conform. Both are editor-only.
  editorTools = with pkgs; [
    metals
    scalafmt
  ];

  # Compiler / build tools / package manager, exposed to the interactive shell
  # (and inherited by Neovim so Metals can drive builds).
  toolchain = with pkgs; [
    jdk
    scala_3
    sbt
    scala-cli
    coursier
  ];
}
