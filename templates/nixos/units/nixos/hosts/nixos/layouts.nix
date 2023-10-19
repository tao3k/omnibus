let
  outputs = inputs.self;
in
# self' = inputs.self.hosts.nixos;
{
  system = "x86_64-linux";

  data = outputs.local.${self.system}.data;

  hive = {
    bee.system = self.system;
    # use the mkHome function to create a home-manager profile
    # bee.home = inputs.home-manager;
    bee.pkgs = import inputs.nixpkgs { inherit (self) system; };
    imports = lib.flatten self.nixosSuites;
  };

  nixosSuites = lib.flatten [
    outputs.hosts.nixos.nixosProfiles.bootstrap

    outputs.nixosProfiles.presets.boot
    # outputs.nixosModules.default.programs.git

    # # # --custom profiles
    # outputs.pops.nixosProfiles.layouts.customProfiles.presets.nix
    # outputs.pops.nixosProfiles.layouts.customProfiles.presets.boot
    # outputs.pops.nixosModules.layouts.customModules.boot

    # outputs.srvos.default.common.nix
    (outputs.omnibus.lib.mkHome inputs.home.nixosModule
      {
        admin = {
          uid = 1000;
          description = "default manager";
          isNormalUser = true;
          extraGroups = [ "wheel" ];
        };
      }
      "zsh"
      self.homeSuites
    )
  ];

  homeSuites = [
    outputs.homeProfiles.presets.emacs
    # outputs.homeProfiles.presets.bat
    # # # The parent directory of "presets" is categorized as a list type of "suites"
    # (outputs.homeProfiles.shell { }).default
  ];
}
