{ lib }:
{
  options = with lib; {
    PATH = lib.mkOption {
      default = [ ];
      type = types.listOf types.str;
      apply = x: lib.concatStringsSep ":" x;
      description = ''
        A list of directories that will be added to the PATH environment
      '';
    };
  };
}
