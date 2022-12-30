rec {
  default = basic;

  basic = {
    path = ./templates/basic;
    description = "Basic devshell with no packages";
  };

  c = {
    path = ./templates/c;
    description = "Devshell prepared for C";
  };

  rust-nightly = {
    path = ./templates/rust-nightly;
    description = "Devshell prepared for Rust Nightly";
  };

  rust-stable = {
    path = ./templates/rust-stable;
    description = "Devshell prepared for Rust Stable";
  };
}
