let
  pops = lib.mapAttrs (_: v: v.exports) (
    lib.removeAttrs super.pops [ "inputs__" ]
  );
in
{
  nixosSuites = lib.flatten [
    pops.selfNixOSProfiles.default.bootstrap

    # self.nixosProfiles.default.presets.boot
    pops.nixosModules.default.programs.git

    # --custom profiles
    pops.nixosProfiles.customProfiles.nix
    pops.nixosProfiles.customProfiles.boot

    (selfLib.mkHome
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
    pops.homeProfiles.customProfiles.hyprland
    # self.homeModules.wayland.windowManager.hyprland
  ];
}
