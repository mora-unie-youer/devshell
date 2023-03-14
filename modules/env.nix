{ config, pkgs, lib, ... }:

with lib;
let
  envToExport = name: value: "export ${name}=${escapeShellArg (toString value)}";
in
{
  options.env = mkOption {
    # type = types.listOf (types.submodule { options = environmentVariable; });
    type = types.attrsOf types.str;
    default = {};
    description = "Lists all defined environment variables";
  };

  config = {
    initShellHook = ''
      # Environment initialization
      ## Initializing LD paths for library loading
      export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.lib.makeLibraryPath config.packages}
      ## Initializing project root directory env variable
      PROJECT_ROOT=$PWD
      ## Initializing defined environment variables
      ${concatStringsSep "\n" (mapAttrsToList envToExport config.env)}
    '';
  };
}
