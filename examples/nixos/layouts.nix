let
  outputs = lib.mapAttrs (_: v: v.outputs) (
    lib.removeAttrs super.pops [ "inputs" ]
  );
in
{
  inherit outputs;
  data = outputs.data.default;

  nixosSuites = lib.flatten [
    outputs.selfNixOSProfiles.default.bootstrap

    # self.nixosProfiles.default.presets.boot
    outputs.nixosModules.default.programs.git

    # # --custom profiles
    outputs.nixosProfiles.customProfiles.presets.nix
    outputs.nixosProfiles.customProfiles.presets.boot
    outputs.srvos.default.common.nix

    (omnibus.lib.outputs.default.mkHome
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
    outputs.homeProfiles.customProfiles.presets.hyprland
    outputs.homeProfiles.default.presets.bat
    # # The parent directory of "presets" is categorized as a list type of "suites"
    (outputs.homeProfiles.default.shell { }).default
    # super.pops.homeModules.outputs.default.wayland.windowManager.hyprland
  ];
}
