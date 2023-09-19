{
  selfNixOSProfiles = super.pops.selfNixOSProfiles.outputsForTarget.default;

  nixosModules = super.pops.nixosModules.outputsForTarget.nixosModules;

  homeModules = super.pops.homeModules.outputsForTarget.nixosModules;

  homeProfiles = super.pops.homeProfiles.outputs;

  nixosProfiles = super.pops.nixosProfiles.outputs;

  nixosSuites =
    let
      customProfiles = self.nixosProfiles { };
    in
    lib.flatten [
      self.selfNixOSProfiles.bootstrap
      self.nixosModules.boot
      self.nixosModules.programs.git

      # --custom profiles
      customProfiles.presets.nix

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
