with lib; {
  # do we need to import the submodules automatically in imports?
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    # (modulesPath + "/virtualisation/google-compute-image.nix")
    (loadSubmodule ./systemd-initrd.nix)
    ({ environment.systemPackages = [ nixpkgs.hello ]; })
  ];

  config = mkMerge [
    (mkIf cfg.__profiles__.systemd-boot.enable {
      loader = {
        timeout = mkIf cfg.__profiles__.speedup 0;
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    })
  ];

  # config.loader.timeout = 1;

  options = {
    __profiles__.speedup = mkOption {
      type = types.bool;
      default = false;
      description = "Enable systemd-boot speedup.";
    };
    __profiles__.systemd-boot.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable systemd-boot as bootloader.";
    };
  };
}
