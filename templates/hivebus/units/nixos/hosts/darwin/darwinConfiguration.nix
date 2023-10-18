let
  inherit (inputs) nixpkgs;
in
darwin.lib.darwinSystem rec {
  system = super.layouts.system;
  pkgs = import nixpkgs { inherit system; };
  modules = lib.flatten [ super.layouts.darwinSuites ];
}
