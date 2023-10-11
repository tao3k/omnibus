let
  inherit (inputs) nixpkgs darwin;
  exporter = lib.mapAttrs (_: v: v.layouts) (
    lib.removeAttrs super.pops [ "inputs" ]
  );
in
{
  system = "x86_64-linux";

  inherit data exporter;

  nixosSuites = lib.flatten [
    exporter.selfNixOSProfiles.default.bootstrap

    # self.nixosProfiles.default.presets.boot
    exporter.nixosModules.default.programs.git
    # load a suite profile from audio
    # (outputs.nixosProfiles.default.audio {}).default

    # # --custom profiles
    exporter.nixosProfiles.customProfiles.presets.nix
    # exporter.nixosProfiles.customProfiles.presets.boot
    exporter.srvos.default.common.nix

    (omnibus.lib.mkHome
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
    exporter.homeProfiles.customProfiles.presets.hyprland
    exporter.homeProfiles.default.presets.bat
    # # The parent directory of "presets" is categorized as a list type of "suites"
    (exporter.homeProfiles.default.shell { }).default
    # super.pops.homeModules.layouts.default.wayland.windowManager.hyprland
  ];

  nixosConfiguration =
    module:
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = lib.flatten [
        self.nixosSuites
        module
      ];
    };

  darwinConfiguration =
    module:
    darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = lib.flatten [ module ];
    };
}
