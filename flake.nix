{
  description = "devshell - Nix Flake for easier management of development environments";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = inputs: {
    overlays.default = import ./overlay.nix;
    templates = import ./templates.nix;
  };
}
