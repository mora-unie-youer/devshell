{ pkgs, ... }:

pkgs.devshell.mkShell {
  name = "rust-nightly";
  packages = with pkgs; [
    binutils
    gcc

    (rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {
      extensions = [ "rust-analyzer" "rust-src" ];
    }))
  ];
}
