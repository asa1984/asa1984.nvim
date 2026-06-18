{
  default =
    final: prev:
    let
      myPkgs = import ../pkgs { pkgs = prev; };
    in
    myPkgs
    // {
      vimPlugins =
        prev.vimPlugins
        // myPkgs.vimPlugins
        // {
          # hmts.nvim 1.3.0 uses the pre-0.12 Treesitter predicate API, where
          # handlers received a single node per capture. Neovim 0.12 passes a
          # list of nodes instead, so its `match[capture]:parent()` calls crash
          # on every .nix file with injections. Patch it until upstream updates.
          hmts-nvim = prev.vimPlugins.hmts-nvim.overrideAttrs (old: {
            patches = (old.patches or [ ]) ++ [ ../patches/hmts-nvim-neovim-0.12.patch ];
          });
        };
    };
}
