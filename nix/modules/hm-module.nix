{
  inputs,
  system,
  tools,
}:
{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.asa1984-nvim;
in
{
  options.programs.asa1984-nvim = {
    enable = mkEnableOption "asa1984-nvim";

    variant = mkOption {
      default = "full";
      type = types.str;
      description = ''
        The variant of asa1984-nvim to use (minimal, light, full)
      '';
      example = literalExpression ''"minimal"'';
    };

    excludePackages = mkOption {
      default = [ ];
      type = types.listOf types.str;
      description = ''
        Exclude packages from asa1984-nvim's extra packages
      '';
      example = literalExpression ''[ "ripgrep" "lazygit" ]'';
    };
  };

  config =
    let
      originalTools = (
        if cfg.variant == "full" then
          (tools.primarry ++ tools.secondary)
        else if cfg.variant == "light" then
          tools.primarry
        else
          [ ]
      );
    in
    mkIf cfg.enable {
      home.packages = [
        inputs.self.packages.${system}."neovim-${cfg.variant}"
        (builtins.filter (pkg: !builtins.elem pkg.pname cfg.excludePackages) originalTools)
      ];
    };
}
