{ lib, loadSubmodule }:
{
  options = with lib; {
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
