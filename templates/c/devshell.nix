{ pkgs, ... }:

pkgs.devShell.mkShell {
  packages = with pkgs; [
    # Toolchain required for C binaries building
    binutils
    gcc
  ];
}
