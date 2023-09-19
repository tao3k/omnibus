{
  selfNixOSProfiles = super.pops.selfNixOSProfiles.outputsForTarget.default;

  nixosModules = super.pops.nixosModules.outputsForTarget.nixosModules;

  homeModules = super.pops.homeModules.outputsForTarget.nixosModules;

  homeProfiles = super.pops.homeProfiles.outputs;

  nixosSuites = lib.flatten [
    self.selfNixOSProfiles.bootstrap
    self.nixosModules.boot
    self.nixosModules.programs.git
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

  homeSuites =
    let
      customProfiles = self.homeProfiles {
        presets.hyprland.default = {
          wayland.windowManager.hyprland.__profiles__ = {
            nvidia = true;
          };
        };
      };
    in
    [
      customProfiles.presets.hyprland.default
      # self.homeModules.wayland.windowManager.hyprland
    ];
}
