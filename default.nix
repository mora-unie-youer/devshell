final: prev:

let
  defaultConfiguration = {
    name = "devshell";
    colors = {
      "3bit" = "1";
      "8bit" = "202";
      "24bit" = "#17BEBB";
    };

    packages = [];

    shellHooks = {
      envInit = '''';
      preInit = '''';
      postInit = '''';
    };
  };

  recursiveMerge = attrList:
    with final.lib;
    let f = attrPath:
      zipAttrsWith (n: values:
        if tail values == []
          then head values
        else if all isList values
          then unique (concatLists values)
        else if all isAttrs values
          then f (attrPath ++ [n]) values
        else last values
      );
    in f [] attrList;
in
{
  devShell = {
    mkShell =
      configuration:
        let
          finalConfiguration = recursiveMerge [
            defaultConfiguration
            configuration
          ];
        in final.mkShell {
          buildInputs = finalConfiguration.packages;

          shellHook = ''
            # User preInit shell hook
            ${finalConfiguration.shellHooks.preInit}

            # Environment initialization
            ## Initializing LD paths for library loading
            export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${final.lib.makeLibraryPath finalConfiguration.packages}
            ## Initializing project root directory
            PROJECT_ROOT=$PWD
            ## User envInit shell hook
            ${finalConfiguration.shellHooks.envInit}

            # PS1 customization
            ## Relative path
            rel_root() {
              local path
              path=$(${final.coreutils}/bin/realpath --relative-to $PROJECT_ROOT $PWD)
              if [[ $path != . ]]; then echo " $path "; fi
            }

            if [[ $COLORTERM = "truecolor" ]] || [[ $COLORTERM = "24bit" ]]; then
              # We have 24-bit colors
              HEX_COLOR=${finalConfiguration.colors."24bit"}
              COLOR=$(printf "\e[38;2;%d;%d;%d2m" 0x''${HEX_COLOR:1:2} 0x''${HEX_COLOR:3:2} 0x''${HEX_COLOR:5:2})
            else
              _colors=$(tput colors)
              if [[ "$_colors" = "256" ]]; then
                # We have 8-bit colors
                COLOR=$(printf "\e[38;5;%dm" ${finalConfiguration.colors."8bit"})
              elif [[ "$_colors" = "8" ]] || [[ "$_colors" = "16" ]]; then
                # We have 3/4-bit colors
                COLOR=$(printf "\e[3%dm" ${finalConfiguration.colors."3bit"})
              fi
            fi
            PS1="\[$COLOR\][${finalConfiguration.name}]\$(rel_root)\$\[\033[0m\] "

            # User postInit shell hook
            ${finalConfiguration.shellHooks.postInit}
          '';
        };
  };
}
