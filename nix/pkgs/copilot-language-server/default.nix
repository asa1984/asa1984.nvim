# Prebuilt copilot-language-server binary pinned by nvfetcher.
#
# copilot.lua runs this via `server.type = "binary"` instead of executing the
# bundled JS with nixpkgs' ad-hoc-signed `node`. macOS Keychain cannot persist
# "Always Allow" grants for unsigned binaries, which made it prompt on every
# launch; the darwin binary carries GitHub's Developer ID signature, so the
# grant sticks.
{
  stdenv,
  unzip,
  sources,
}:
let
  platform =
    {
      aarch64-darwin = "darwin-arm64";
      x86_64-darwin = "darwin-x64";
      aarch64-linux = "linux-arm64";
      x86_64-linux = "linux-x64";
    }
    .${stdenv.hostPlatform.system};

  source = sources."copilot-language-server-${platform}";
in
stdenv.mkDerivation {
  pname = "copilot-language-server";
  inherit (source) version src;

  nativeBuildInputs = [ unzip ];

  dontUnpack = true;
  # Keep the prebuilt binary byte-identical; stripping or patching it would
  # invalidate the Developer ID signature.
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    unzip -q $src copilot-language-server -d $out/bin
    runHook postInstall
  '';
}
