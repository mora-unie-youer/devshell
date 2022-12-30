{ pkgs, ... }:

pkgs.devshell.mkShell {
  name = "basic";
  packages = with pkgs; [
  ];
}
