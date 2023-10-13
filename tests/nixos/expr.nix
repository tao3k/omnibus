{
  super,
  trace,
  lib,
}:
let
  out = super.pops.layouts.default.layouts;
  extraHomeModule = m: {
    home-manager.users.admin = {
      imports = lib.flatten m;
    };
  };
in
{
  bootProfile =
    (out.nixosConfiguration [
      out.exporter.nixosProfiles.customProfiles.presets.boot
    ]).config.boot.__profiles__;

  customModuleBootTimeOut =
    (out.nixosConfiguration [
      out.exporter.nixosModules.customModules.boot
      {
        config.boot.__profiles__.speedup = true;
        config.boot.__profiles__.systemd-boot.enable = true;
      }
    ]).config.boot.loader.timeout;

  hyprland =
    (out.nixosConfiguration [
      out.exporter.nixosModules.customModules.boot
      (extraHomeModule [
        out.exporter.homeProfiles.customProfiles.presets.hyprland.default
        out.exporter.homeProfiles.default.presets.firefox
      ])
    ])
    .config.home-manager.users.admin.wayland.windowManager.hyprland.__profiles__;
}
// lib.optionalAttrs trace {
  nixosConfiguration = out.nixosConfiguration [
    out.exporter.nixosProfiles.default.presets.boot
  ];

  homeConfiguration =
    (out.nixosConfiguration [
      out.exporter.nixosProfiles.default.presets.boot
      (extraHomeModule [
        out.exporter.homeProfiles.customProfiles.presets.hyprland.default
        out.exporter.homeProfiles.default.presets.firefox
      ])
    ]).config.home-manager.users.admin;
}
