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

          # MoonBit is not in nvim-treesitter's official parser list, so nixpkgs
          # ships no prebuilt parser. Build the upstream grammar here; its
          # Neovim-compatible queries/ are installed next to the parser by
          # grammarToPlugin, so highlighting works with no vendored queries.
          nvim-treesitter-parsers = prev.vimPlugins.nvim-treesitter-parsers // {
            moonbit = final.neovimUtils.grammarToPlugin (
              final.tree-sitter.buildGrammar {
                language = "moonbit";
                version = "0.1.0+rev=5435c307";
                src = final.fetchFromGitHub {
                  owner = "moonbitlang";
                  repo = "tree-sitter-moonbit";
                  rev = "5435c307c6cf2ef0d508a99047b06f35a4308444";
                  hash = "sha256-UUEjrF6uGwTtFGRjmjw75ky8eDwVwAHOHro48TAI+WM=";
                };
              }
            );
          };
        };
    };
}
