let
  exporter = lib.mapAttrs (_: v: v.exports) (
    lib.removeAttrs super.pops [ "inputs" ]
  );
  outputs = lib.mapAttrs (_: v: v.outputs) (
    lib.removeAttrs super.pops [ "inputs" ]
  );
in
{
  data = exporter.data.default;

  nixosSuites = lib.flatten [
    outputs.selfNixOSProfiles.default.bootstrap

    # self.nixosProfiles.default.presets.boot
    outputs.nixosModules.default.programs.git

    # # --custom profiles
    exporter.nixosProfiles.customProfiles.presets.nix
    exporter.nixosProfiles.customProfiles.presets.boot
    exporter.nixosModules.customModules.boot

    outputs.srvos.default.common.nix

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
    outputs.homeProfiles.default.presets.bat
    # # The parent directory of "presets" is categorized as a list type of "suites"
    (outputs.homeProfiles.default.shell { }).default
    # super.pops.homeModules.outputs.default.wayland.windowManager.hyprland
  ];
}
