{ pkgs, ... }:

pkgs.devShell.mkShell {
  packages = with pkgs; [
    # Toolchain required for C + Rust binaries building
    binutils
    gcc
    # Nightly Rust toolchain
    (rust-bin.selectLatestNightlyWith (toochain: toolchain.default.override {
      # Extensions which ease your development process
      extensions = [ "rust-analyzer" "rust-src" ];
    }))
  ];
}
