{ lib, loadSubmodule }:
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
    minimal = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to use the minimal bootstrap";
    };
    default = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to use the default bootstrap";
    };
    full = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to use the full bootstrap";
    };
    contabo = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to use contabo init configuration";
    };
  };
  imports = [ (loadSubmodule ./packages.nix) ];
}
