let
  inherit (moduleArgs) pkgs;
in
{
  enable = true;
  imports = [ ({ environment.systemPackages = [ pkgs.git ]; }) ];
}
