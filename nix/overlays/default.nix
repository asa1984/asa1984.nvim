{
  default =
    final: prev:
    let
      sources = import ../../_sources/generated.nix {
        inherit (prev)
          fetchgit
          fetchurl
          fetchFromGitHub
          dockerTools
          ;
      };
      vimPlugins = builtins.mapAttrs (
        key: value:
        prev.vimUtils.buildVimPlugin {
          inherit (value) pname version src;
          dontBuild = true;
        }
      ) sources;
    in
    {
      vimPlugins = prev.vimPlugins // vimPlugins;
    };
}
