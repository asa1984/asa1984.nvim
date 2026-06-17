{ pkgs }:
let
  # Use the system GHC/HLS provided here instead of letting stack manage its own.
  stack-wrapped = pkgs.symlinkJoin {
    name = "stack";
    paths = [ pkgs.stack ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/stack \
        --add-flags "\
          --no-nix \
          --no-install-ghc \
          --system-ghc \
        "
    '';
  };
in
{
  editorTools = with pkgs; [
    haskell-language-server
    haskellPackages.fourmolu
  ];
  toolchain = [
    pkgs.ghc
    stack-wrapped
  ];
}
