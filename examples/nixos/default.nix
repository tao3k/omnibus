let
  exporter = lib.mapAttrs (_: v: v.exports) (
    lib.removeAttrs super.pops [ "inputs" ]
  );
in
{
  nixosSuites = lib.flatten [
    exporter.selfNixOSProfiles.default.bootstrap

    # self.nixosProfiles.default.presets.boot
    exporter.nixosModules.default.programs.git

    # --custom profiles
    exporter.nixosProfiles.customProfiles.nix
    exporter.nixosProfiles.customProfiles.boot

    (POS.lib.mkHome
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
    exporter.homeProfiles.customProfiles.hyprland
    # super.pops.homeModules.wayland.windowManager.hyprland
  ];
}
