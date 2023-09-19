{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flops.url = "github:gtrunsec/flops";
    POP.follows = "flops/POP";
  };

  outputs =
    {
      self,
      nixpkgs,
      flops,
      POP,
      ...
    }@inputs:
    let
      eachSystem = nixpkgs.lib.genAttrs [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      loadInputs = flops.lib.flake.pops.default.setInitInputs ./local;
      loadModules = flops.lib.haumea.pops.default.setInit {
        src = ./nixos/nixosModules;
        type = "nixosModules";
      };
    in
    {
      inherit loadModules loadInputs;
      nixos =
        let
          __inputs__ =
            (loadInputs.addInputsExtender (
              POP.lib.extendPop flops.lib.flake.pops.inputsExtender (
                self: super: { inputs.nixpkgs = inputs.nixpkgs.legacyPackages; }
              )
            )).setSystem
              system;
          system = "x86_64-linux";
          exporter =
            (loadModules.addLoadExtender { inputs = __inputs__.outputs // { }; })
            .outputsForTarget.nixosModules;
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          pkgs = import nixpkgs { inherit system; };
          modules = [
            ./examples/nixos.nix
            exporter.boot
            exporter.programs.git
            ({
              config.boot.__profiles__.systemd-boot.enable = true;
              # config.boot.__profiles__.systemd-initrd.enable = true;
            })
          ];
        };
    };
}
