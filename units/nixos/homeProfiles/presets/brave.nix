{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ((brave.override {
      commandLineArgs = [
        "--enable-wayland-ime"
        "--ozone-platform=wayland"
        "--enable-features=UseOzonePlatform"
        # "--enable-unsafe-webgpu"
        # "--use-gl=egl"
      ];
    }).overrideAttrs
      (_old: { })
    )
  ];
}
