{
  config =
    with lib;
    mkMerge [
      (mkIf cfg.__profiles__.systemd-initrd.enable {
        boot = {
          loader = {
            # timeout = 0;
            efi.canTouchEfiVariables = true;
            # https://discourse.nixos.org/t/configure-grub-on-efi-system/2926/7
            grub = {
              enable = true;
              efiSupport = true;
              device = "nodev";
              useOSProber = true;
            };
          };
          initrd = {
            systemd = {
              enable = true;
              # emergencyAccess = true;
            };
          };
        };
      })
    ];

  options =
    with lib;
    mkOpt {
      __profiles__.systemd-initrd.enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable systemd-initrd as bootloader.";
      };
    };
}
