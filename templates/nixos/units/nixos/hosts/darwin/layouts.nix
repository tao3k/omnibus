let
  outputs = inputs.self;
in
# self' = inputs.self.hosts.nixos;
{
  system = "aarch64-linux";

  data = outputs.local.${self.system}.data;

  hive = {
    bee.system = self.system;
    bee.home = inputs.home-manager;
    bee.darwin = inputs.darwin;
    bee.pkgs = import inputs.nixpkgs { inherit (self) system; };
    imports = lib.flatten self.darwinSuites;
  };

  darwinSuites = lib.flatten [
    # outputs.darwinModules.layouts.default.homebrew
    # # # --custom profiles
    # outputs.pops.nixosProfiles.layouts.customProfiles.presets.nix
    # outputs.pops.nixosProfiles.layouts.customProfiles.presets.boot
    # outputs.pops.nixosModules.layouts.customModules.boot

    # outputs.srvos.default.common.nix
    (outputs.omnibus.lib.mkHome inputs.home.darwinModule
      {
        admin = {
          uid = 1000;
          description = "default manager";
        };
      }
      "zsh"
      self.homeSuites
    )
  ];

  homeSuites =
    [
      # outputs.homeProfiles.presets.emacs
      # outputs.homeProfiles.presets.bat
      # # # The parent directory of "presets" is categorized as a list type of "suites"
      # (outputs.homeProfiles.shell { }).default
    ];
}
