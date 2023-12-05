{lib}:
{
  options.devices = with lib; {
    __profiles__ = {
      name = mkOption {
        type = types.str;
        default = "default";
        description = ''
          The name of the profile to use.
        '';
      };
      device = mkOption {
        type = types.str;
        default = "default";
        description = ''
          The name of the device to use.
        '';
      };
    };
  };
}
