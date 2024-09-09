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

  ts-error-translator-nvim = pkgs.vimUtils.buildVimPlugin {
    inherit (sources.ts-error-translator-nvim) pname version src;
    dontBuild = true;
  };

  tailwind-tools-nvim = pkgs.vimUtils.buildVimPlugin {
    inherit (sources.tailwind-tools-nvim) pname version src;
    dontBuild = true;
  };
in
[
  vimdoc-ja
  mini-bufremove
  hlchunk-nvim
  skkeleton
  cmp-skkeleton
  ts-error-translator-nvim
  tailwind-tools-nvim
]
++ (with pkgs.vimPlugins; [
  # Colorscheme
  tokyonight-nvim

  # Syntax highlighting
  nvim-treesitter

  # Core
  better-escape-nvim
  nvim-hlslens
  smart-splits-nvim
  sort-nvim

  # Coding
  comment-nvim
  nvim-ts-context-commentstring
  nvim-autopairs
  nvim-ts-autotag
  ts-comments-nvim

  # LSP
  nvim-lspconfig
  lspkind-nvim
  lspsaga-nvim
  rust-tools-nvim
  crates-nvim
  typst-vim
  neodev-nvim
  trouble-nvim
  SchemaStore-nvim
  tiny-inline-diagnostic-nvim

  # Formatter
  conform-nvim

  # Completion
  nvim-cmp
  cmp-nvim-lsp
  cmp-buffer
  cmp-cmdline
  cmp-path
  cmp_luasnip
  copilot-cmp
  luasnip

  # GitHub Copilot
  copilot-lua
  CopilotChat-nvim

  # Git
  gitsigns-nvim

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
