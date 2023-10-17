{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg' = config.virtualisation.hive;
in
{
  environment.systemPackages =
    with pkgs; (lib.optionals cfg'.dockerCompose [ docker-compose ]);
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
