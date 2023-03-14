{ config, pkgs, lib, ... }:

with lib;
{
  options = {
    name = mkOption {
      type = types.str;
      default = "devshell";
      description = "Contains name of devshell";
    };

    packages = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "Contains all the packages that will be installed in shell";
    };

    preInitShellHook = mkOption {
      type = types.lines;
      default = '''';
      description = "Contains shellHook that will be run before the initialization of shell";
    };

    initShellHook = mkOption {
      type = types.lines;
      description = "Contains shellHook that will be run at the initialization of shell";
    };

    shellHook = mkOption {
      type = types.lines;
      default = '''';
      description = "Contains shellHook that will be run after the initialization of shell";
    };
  };

  config = {
    initShellHook = ''
      # PS1 customization
      ## Relative path
      rel_root() {
        local path
        path=$(${pkgs.coreutils}/bin/realpath --relative-to $PROJECT_ROOT $PWD)
        if [[ $path != . ]]; then echo " $path "; fi
      }

      ## Setting PS1
      PS1="\[$COLOR\][${config.name}]\$(rel_root)\$\[\033[0m\] "
    '';
  };
}
