let
  exporter = exporters.nixos;
  system = "x86_64-linux";
in
nixpkgs.lib.nixosSystem {
  inherit system;
  pkgs = import nixpkgs { inherit system; };
  modules = lib.flatten [ exporter.pops.nixosSuites ];
}
