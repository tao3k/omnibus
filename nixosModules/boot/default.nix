with lib; {
  # do we need to import the submodules automatically in imports?
  imports = [
    (builtins.scopedImport { inherit mkOpt lib cfg; } ./systemd-initrd.nix)
  ];
  config = mkMerge [
    (mkIf cfg.__profiles__.systemd-boot.enable {
      loader = {
        timeout = 0;
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    })
  ];

  options = {
    __profiles__.systemd-boot.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable systemd-boot as bootloader.";
    };
  };
}
