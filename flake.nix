{
  description = "devshell - Nix Flake for easier management of development environments";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = inputs: {
    overlays.default = final: prev: {
      devshell = {
        mkShell = {
          name ? "devshell",
          packages ? [],
        }: final.mkShell {
          buildInputs = packages;

          shellHook = ''
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
    };
  };
}
