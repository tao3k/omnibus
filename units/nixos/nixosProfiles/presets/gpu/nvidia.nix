{
  inputs,
  omnibus,
  config,
  lib,
  pkgs,
}:
let
  inherit
    (omnibus.errors.requiredInputsLazily inputs "omnibus.pops.nixosProfiles" [
      "nixos-hardware"
    ])
    nixos-hardware
    ;
in
{
  imports = [ nixos-hardware.nixosModules.common-gpu-nvidia ];
  boot = {
    kernelParams = [ "nvidia-drm.modeset=1" ];
    kernelModules = [ "nvidia" ];
    # blacklistedKernelModules = ["nouveau"];
  };
  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
      modesetting.enable = lib.mkDefault true;
      powerManagement.enable = lib.mkDefault true;
      prime = {
        offload = {
          enable = lib.mkOverride 900 false;
        };
        # nvidiaBusId = lib.mkDefault "PCI:1:0:0";
      };
    };
  };
  environment.systemPackages = with pkgs; [
    glxinfo
    vulkan-tools
    # glmark2
  ];
}
