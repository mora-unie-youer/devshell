{ pkgs, ... }:

pkgs.devShell.mkShell {
  packages = with pkgs; [
    # Toolchain required for C + Rust binaries building
    binutils
    gcc
    # Stable Rust toolchain
    (rust-bin.stable.latest.default.override {
      # Extensions which ease your development process
      extensions = [ "rust-analyzer" "rust-src" ];
    })
  ];
}
