{ pkgs, ... }:

pkgs.devshell.mkShell {
  name = "c";
  packages = with pkgs; [
    binutils
    gcc
  ];
}
