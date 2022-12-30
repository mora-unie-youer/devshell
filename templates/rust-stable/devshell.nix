{ pkgs, ... }:

pkgs.devshell.mkShell {
  name = "rust-stable";
  packages = with pkgs; [
    binutils
    gcc

    (rust-bin.stable.latest.default.override {
      extensions = [ "rust-analyzer" "rust-src" ];
    })
  ];
}
