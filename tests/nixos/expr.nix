{
  super,
  trace,
  lib,
}:
let
  exporter = super.pops.layouts.default;
in
{
  bootProfile =
    (exporter.layouts.nixosConfiguration [
      exporter.layouts.exporter.nixosProfiles.customProfiles.presets.boot
    ]).config.boot.__profiles__;

  customModuleBootTimeOut =
    (exporter.layouts.nixosConfiguration [
      exporter.layouts.exporter.nixosModules.customModules.boot
      {
        config.boot.__profiles__.speedup = true;
        config.boot.__profiles__.systemd-boot.enable = true;
      }
    ]).config.boot.loader.timeout;
}
// lib.optionalAttrs trace {
  nixosConfiguration = exporter.layouts.nixosConfiguration [
    exporter.layouts.exporter.nixosProfiles.default.presets.boot
  ];
}
