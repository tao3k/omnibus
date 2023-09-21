let
  exporter = lib.mapAttrs (_: v: v.exports) (
    lib.removeAttrs super.pops [ "inputs" ]
  );

  data =
    (POS.loadData.addLoadExtender {
      loader =
        with haumea;
        [
          # without the nixpkgs requirement, only the nixpkgs.lib
          (matchers.regex "^(.+)\\.(yaml|yml)$" (
            _: _: path:
            super.pops.inputs.outputs.std.lib.ops.readYAML path
          ))
        ];
    }).outputsForTarget.default;
in
{
  inherit data;

  nixosSuites = lib.flatten [
    exporter.selfNixOSProfiles.default.bootstrap

    # self.nixosProfiles.default.presets.boot
    exporter.nixosModules.default.programs.git

    # --custom profiles
    exporter.nixosProfiles.customProfiles.nix
    exporter.nixosProfiles.customProfiles.boot

    exporter.srvos.default.common.nix

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
    exporter.homeProfiles.default.presets.bat
    # super.pops.homeModules.wayland.windowManager.hyprland
  ];
}
