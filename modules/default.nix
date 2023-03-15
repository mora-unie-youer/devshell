{ configuration, pkgs, lib ? pkgs.lib }:

let
  pkgsModule = { config, ... }: {
    config = {
      _module.args.pkgs = lib.mkDefault pkgs;
    };
  };

  module = lib.evalModules {
    modules = [
      configuration

      ./basic.nix
      ./colors.nix
      ./env.nix

      pkgsModule
    ];
  };
in
{
  mkShell = pkgs.mkShell {
    buildInputs = module.config.packages;

    shellHook = ''
      # Shell hook before shell initialization
      ${module.config.preInitShellHook}
      # Shell hook of shell initialization
      ${module.config.initShellHook}
      # Shell hook after shell initialization
      ${module.config.shellHook}
    '';
  };
}
