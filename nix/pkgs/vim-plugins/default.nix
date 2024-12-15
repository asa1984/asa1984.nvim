{
  sources,
  vimUtils,
}:
builtins.mapAttrs (
  key: value:
  vimUtils.buildVimPlugin {
    inherit (value) pname version src;
    dontBuild = true;
  }
) sources
