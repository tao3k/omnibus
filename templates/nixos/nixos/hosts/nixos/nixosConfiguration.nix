nixpkgs.lib.nixosSystem rec {
  system = super.layouts.system;
  pkgs = import nixpkgs { inherit system; };
  modules = lib.flatten [ super.layouts.nixosSuites ];
}
