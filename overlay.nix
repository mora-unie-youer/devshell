final: prev:
{
  devshell = {
    mkShell = {
      name ? "devshell",
      packages ? [],
    }: final.mkShell {
      buildInputs = packages;

      shellHook = ''
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${final.lib.makeLibraryPath packages}

        PRJ_ROOT=$PWD

        rel_root() {
          local path
          path=$(${final.coreutils}/bin/realpath --relative-to $PRJ_ROOT $PWD)
          if [[ $path != . ]]; then
            echo " $path "
          fi
        }

        PS1='\[\033[38;5;202m\][${name}]$(rel_root)\$\[\033[0m\] '
      '';
    };
  };
}
