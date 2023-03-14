final: prev:
{
  devShell = {
    mkShell = configuration:
      (import ./modules { inherit configuration; pkgs = final; }).mkShell;
  };
}
