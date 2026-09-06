# Prebuilt kcl-language-server binary pinned by nvfetcher (Darwin only).
#
# nixpkgs' kcl-language-server is Linux-only, so Darwin uses the official
# kclvm release tarball instead. The server dlopens
# libkclvm_cli_cdylib.dylib relative to its own executable path, so the
# binary and the dylib are installed side by side in $out/bin.
{ stdenv, sources }:
let
  platform =
    {
      aarch64-darwin = "darwin-arm64";
      x86_64-darwin = "darwin-amd64";
    }
    .${stdenv.hostPlatform.system};

  source = sources."kcl-language-server-${platform}";
in
stdenv.mkDerivation {
  pname = "kcl-language-server";
  inherit (source) version src;

  # The tarball root is `kclvm/` (used as the source root); only the server
  # binary and its dylib are needed (`kclvm_cli` is covered by nixpkgs' `kcl`).
  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp bin/kcl-language-server bin/libkclvm_cli_cdylib.dylib $out/bin/
    runHook postInstall
  '';
}
