{ pkgs, sources }:
let
  vimdoc-ja = pkgs.vimUtils.buildVimPlugin {
    inherit (sources.vimdoc-ja) pname version src;
    dontBuild = true;
  };

  mini-bufremove = pkgs.vimUtils.buildVimPlugin {
    inherit (sources.mini-bufremove) pname version src;
    dontBuild = true;
  };

  hlchunk-nvim = pkgs.vimUtils.buildVimPlugin {
    inherit (sources.hlchunk-nvim) pname version src;
    dontBuild = true;
  };

  skkeleton = pkgs.vimUtils.buildVimPlugin {
    inherit (sources.skkeleton) pname version src;
    dependencies = [ pkgs.vimPlugins.denops-vim ];
    dontBuild = true;
  };

  cmp-skkeleton = pkgs.vimUtils.buildVimPlugin {
    inherit (sources.cmp-skkeleton) pname version src;
    dependencies = [ skkeleton ];
    dontBuild = true;
  };
in
[
  vimdoc-ja
  mini-bufremove
  hlchunk-nvim
  skkeleton
  cmp-skkeleton
]
++ (with pkgs.vimPlugins; [
  # Core
  nvim-treesitter

  # Colorscheme
  tokyonight-nvim

  # Make neovim better
  better-escape-nvim
  nvim-hlslens
  smart-splits-nvim

  # Coding
  comment-nvim
  nvim-ts-context-commentstring
  nvim-autopairs
  nvim-ts-autotag

  # LSP
  nvim-lspconfig
  lspkind-nvim
  lspsaga-nvim
  conform-nvim
  rust-tools-nvim
  crates-nvim
  typst-vim
  neodev-nvim
  trouble-nvim
  SchemaStore-nvim

  # Completion
  nvim-cmp
  cmp-nvim-lsp
  cmp-buffer
  cmp-cmdline
  cmp-path
  cmp_luasnip
  copilot-cmp
  luasnip
  copilot-lua

  # UI
  alpha-nvim
  heirline-nvim
  neo-tree-nvim
  noice-nvim
  telescope-nvim
  telescope-file-browser-nvim
  toggleterm-nvim
  nvim-scrollbar
  statuscol-nvim
  gitsigns-nvim
  nvim-web-devicons

  # Misc
  denops-vim
  markdown-nvim
  twilight-nvim
  zen-mode-nvim
  nvim-highlight-colors
  hmts-nvim
  presence-nvim

  # Internal libraries
  plenary-nvim
  promise-async
  nui-nvim
])