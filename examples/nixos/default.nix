let
  pops = lib.mapAttrs (_: v: v.outputsForTarget) (
    lib.removeAttrs super.pops [ "inputs__" ]
  );
in
{
  nixosSuites =
    let
      customProfiles = {
        nix =
          (pops.nixosProfiles.dmerge {
            nix.extraOptions = ''
              allowed-uris = https://github.com/
            '';
          })
            [
              "presets"
              "nix"
            ];
        boot =
          (pops.nixosProfiles.dmerge {
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
      pops.selfNixOSProfiles.default.bootstrap

      # self.nixosProfiles.default.presets.boot
      customProfiles.boot

      pops.nixosModules.default.programs.git

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
          (pops.homeProfiles.dmerge {
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
