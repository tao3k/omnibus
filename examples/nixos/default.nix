{
  selfNixOSProfiles = super.pops.selfNixOSProfiles.outputsForTarget.default;

  nixosModules = super.pops.nixosModules.outputsForTarget.nixosModules;

  homeModules = super.pops.homeModules.outputsForTarget.nixosModules;

  homeProfiles = super.pops.homeProfiles.outputsForTarget;

  nixosProfiles = super.pops.nixosProfiles.outputsForTarget;

  nixosSuites =
    let
      customProfiles = {
        nix =
          (self.nixosProfiles.dmerge {
            nix.extraOptions = ''
              allowed-uris = https://github.com/
            '';
          })
            [
              "presets"
              "nix"
            ];
        boot =
          (self.nixosProfiles.dmerge {
            # boot.__profiles__.systemd-initrd.enable = true;
            boot.__profiles__.systemd-boot.enable = true;
          })
            [
              "presets"
              "boot"
            ];
      };
    in
    lib.flatten [
      self.selfNixOSProfiles.bootstrap

      # self.nixosProfiles.default.presets.boot
      customProfiles.boot

      self.nixosModules.programs.git

      # (
      #   {
      #     lib,
      #     config,
      #     options,
      #     ...
      #   }@args:
      #   {
      #     options = {
      #       __test__ = lib.mkOption {
      #         type = lib.types.attrs;
      #         default = ;
      #       };
      #     };
      #   }
      # )

      # --custom profiles
      customProfiles.nix

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
      customProfiles = {
        hyprland =
          (self.homeProfiles.dmerge {
            wayland.windowManager.hyprland.__profiles__ = {
              nvidia = true;
            };
          })
            [
              "presets"
              "hyprland"
            ];
      };
    in
    [
      customProfiles.hyprland
      # self.homeModules.wayland.windowManager.hyprland
    ];
}
