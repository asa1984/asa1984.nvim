{
  default =
    final: prev:
    let
      myPkgs = import ../pkgs { pkgs = prev; };
    in
    myPkgs
    // {
      vimPlugins = prev.vimPlugins // myPkgs.vimPlugins;
    };
}
