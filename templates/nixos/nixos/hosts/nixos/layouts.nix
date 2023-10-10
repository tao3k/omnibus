let
  outputs = lib.mapAttrs (_: v: v.layouts) (
    lib.removeAttrs super.pops [ "inputs" ]
  );
in
{
  system = "x86_64-linux";

  data = outputs.data.default;

  nixosSuites = lib.flatten [
    outputs.selfNixOSProfiles.default.bootstrap

    outputs.nixosProfiles.default.presets.boot
    # outputs.nixosModules.default.programs.git

    # # # --custom profiles
    # outputs.nixosProfiles.customProfiles.presets.nix
    # outputs.nixosProfiles.customProfiles.presets.boot
    # outputs.nixosModules.customModules.boot

    # outputs.srvos.default.common.nix
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
    outputs.homeProfiles.default.presets.emacs
    # outputs.homeProfiles.default.presets.bat
    # # # The parent directory of "presets" is categorized as a list type of "suites"
    # (outputs.homeProfiles.default.shell { }).default
    # super.pops.homeModules.layouts.default.wayland.windowManager.hyprland
  ];
}
