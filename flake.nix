{
  description = "asa1984's neovim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    heirline_nvim = {
      url = "github:rebelot/heirline.nvim";
      flake = false;
    };
    alpha_nvim = {
      url = "github:goolord/alpha-nvim";
      flake = false;
    };
    nvim_cmp = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };
    cmp_nvim_lsp = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };
    cmp_buffer = {
      url = "github:hrsh7th/cmp-buffer";
      flake = false;
    };
    cmp_cmdline = {
      url = "github:hrsh7th/cmp-cmdline";
      flake = false;
    };
    cmp_path = {
      url = "github:hrsh7th/cmp-path";
      flake = false;
    };
    cmp_luasnip = {
      url = "github:saadparwaiz1/cmp_luasnip";
      flake = false;
    };
    lspkind_nvim = {
      url = "github:onsails/lspkind.nvim";
      flake = false;
    };
    tokyonight_nvim = {
      url = "github:folke/tokyonight.nvim";
      flake = false;
    };
    vimdoc_ja = {
      url = "github:vim-jp/vimdoc-ja";
      flake = false;
    };
    copilot_lua = {
      url = "github:zbirenbaum/copilot.lua";
      flake = false;
    };
    better_escape_nvim = {
      url = "github:max397574/better-escape.nvim";
      flake = false;
    };
    smart_splits_nvim = {
      url = "github:mrjones2014/smart-splits.nvim";
      flake = false;
    };
    mini_bufremove = {
      url = "github:echasnovski/mini.bufremove";
      flake = false;
    };
    comment_nvim = {
      url = "github:numToStr/Comment.nvim";
      flake = false;
    };
    nvim_autopairs = {
      url = "github:windwp/nvim-autopairs";
      flake = false;
    };
    nvim_ts_autotag = {
      url = "github:windwp/nvim-ts-autotag";
      flake = false;
    };
    none_ls_nvim = {
      url = "github:nvimtools/none-ls.nvim/0.7-compat";
      flake = false;
    };
    typst_vim = {
      url = "github:kaarmu/typst.vim";
      flake = false;
    };
    conform_nvim = {
      url = "github:stevearc/conform.nvim";
      flake = false;
    };
    nvim_lspconfig = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    rust_tools_nvim = {
      url = "github:simrat39/rust-tools.nvim";
      flake = false;
    };
    crates_nvim = {
      url = "github:saecki/crates.nvim";
      flake = false;
    };
    lspsaga_nvim = {
      url = "github:nvimdev/lspsaga.nvim";
      flake = false;
    };
    twilight_nvim = {
      url = "github:folke/twilight.nvim";
      flake = false;
    };
    zen_mode_nvim = {
      url = "github:folke/zen-mode.nvim";
      flake = false;
    };
    nvim_highlight_colors = {
      url = "github:brenoprata10/nvim-highlight-colors";
      flake = false;
    };
    neo_tree_nvim = {
      url = "github:nvim-neo-tree/neo-tree.nvim/v3.x";
      flake = false;
    };
    noice_nvim = {
      url = "github:folke/noice.nvim";
      flake = false;
    };
    nui_nvim = {
      url = "github:folke/nui.nvim";
      flake = false;
    };
    telescope_nvim = {
      url = "github:nvim-telescope/telescope.nvim";
      flake = false;
    };
    plenary_nvim = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    hmts_nvim = {
      url = "github:calops/hmts.nvim";
      flake = false;
    };
    toggleterm_nvim = {
      url = "github:akinsho/toggleterm.nvim";
      flake = false;
    };
    indent_blankline_nvim = {
      url = "github:lukas-reineke/indent-blankline.nvim";
      flake = false;
    };
    nvim_ufo = {
      url = "github:kevinhwang91/nvim-ufo";
      flake = false;
    };
    nvim_scrollbar = {
      url = "github:petertriho/nvim-scrollbar";
      flake = false;
    };
    nvim_hlslens = {
      url = "github:kevinhwang91/nvim-hlslens";
      flake = false;
    };
    gitsigns_nvim = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };
    promise_async = {
      url = "github:kevinhwang91/promise-async";
      flake = false;
    };
    statuscol_nvim = {
      url = "github:luukvbaal/statuscol.nvim";
      flake = false;
    };
    nvim_web_devicons = {
      url = "github:nvim-tree/nvim-web-devicons";
      flake = false;
    };
    neodev_nvim = {
      url = "github:folke/neodev.nvim";
      flake = false;
    };
    nvim_lint = {
      url = "github:mfussenegger/nvim-lint";
      flake = false;
    };
    telescope_file_browser_nvim = {
      url = "github:nvim-telescope/telescope-file-browser.nvim";
      flake = false;
    };
    presence_nvim = {
      url = "github:andweeb/presence.nvim";
      flake = false;
    };
    skkeleton = {
      url = "github:vim-skk/skkeleton";
      flake = false;
    };
    cmp_skkeleton = {
      url = "github:uga-rosa/cmp-skkeleton";
      flake = false;
    };
    copilot_cmp = {
      url = "github:zbirenbaum/copilot-cmp";
      flake = false;
    };
    luasnip = {
      url = "github:L3MON4D3/LuaSnip";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, ... }:
    let
      allSystems = [
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-linux" # 64-bit x86 Linux
        "aarch64-darwin" # 64-bit ARM macOS
        "x86_64-darwin" # 64-bit x86 macOS
      ];
      forAllSystems = inputs.nixpkgs.lib.genAttrs allSystems;
    in {
      formatter =
        forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt);
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          lib = pkgs.lib;

          skkeleton = pkgs.vimUtils.buildVimPlugin {
            pname = "skkeleton";
            version = "latest";
            src = inputs.skkeleton;
            dependencies = [ pkgs.vimPlugins.denops-vim ];
            dontBuild = true;
          };

          cmp-skkeleton = pkgs.vimUtils.buildVimPlugin {
            pname = "cmp-skkeleton";
            version = "latest";
            src = inputs.cmp_skkeleton;
            dependencies = [ skkeleton ];
            dontBuild = true;
          };

          # Vim plugin sources
          vimPluginInputs =
            builtins.removeAttrs inputs [ "nixpkgs" "flake-utils" ];

          # Vim plugins
          plugins = (builtins.mapAttrs (name: value:
            pkgs.vimUtils.buildVimPlugin {
              pname = name;
              version = "latest";
              src = value;
            }) vimPluginInputs) // {
              lazy_nvim = pkgs.callPackage ./pkgs/lazy-nvim.nix { };
              nvim_treesitter = pkgs.vimPlugins.nvim-treesitter;
              denops_vim = pkgs.vimPlugins.denops-vim;
              cmp_skkeleton = cmp-skkeleton;
              skk_dict = "${pkgs.skk-dicts}/share/SKK-JISYO.L";
            };

          mainDevTools = with pkgs; [
            # For telescope.nvim
            ripgrep
            # Git TUI
            lazygit

            # HTML/CSS
            nodePackages.vscode-langservers-extracted
            # JavaScript/TypeScript
            biome
            deno
            nodePackages.eslint
            nodePackages.prettier
            nodePackages.typescript-language-server
            nodePackages."@tailwindcss/language-server"
            # Lua
            lua-language-server
            stylua
            # Nix
            nixfmt
            nil
            # Rust
            rust-analyzer
            # TOML
            taplo
          ];

          subDevTools = with pkgs; [
            # Bash
            nodePackages.bash-language-server
            # C/C++
            clang-tools
            # Docker
            nodePackages.dockerfile-language-server-nodejs
            # Go
            gopls
            # GraphQL
            nodePackages.graphql-language-service-cli
            # Haskell
            haskell-language-server
            haskellPackages.fourmolu
            # OCaml
            ocamlPackages.ocaml-lsp
            ocamlformat
            # Protocol Buffers
            buf-language-server
            # Python
            ruff
            pyright
            # Shell
            shellcheck
            shfmt
            # Typst
            typst-lsp
            typstfmt
            # Zig
            zls
          ];

          nvimConfig = pkgs.callPackage ./config.nix { inherit self plugins; };
          neovim-base = pkgs.neovim-unwrapped.override {
            # pkgs.neovim builtin treesitter-parsers will conflict with nvim-treesitter
            # so, we need to remove it
            treesitter-parsers = { };
          };
          nvimWrapped = extraPackages:
            pkgs.writeShellScriptBin "nvim" ''
              PATH=$PATH:${lib.makeBinPath extraPackages}
              MY_CONFIG_PATH=${nvimConfig} ${neovim-base}/bin/nvim -u ${nvimConfig}/init.lua "$@"
            '';
        in rec {
          default = neovim-full;
          neovim-full = nvimWrapped (mainDevTools ++ subDevTools);
          neovim-light = nvimWrapped mainDevTools;
          neovim-minimal = nvimWrapped [ ];
          config = nvimConfig;
        });
    };
}
