{
  enable = true;
  imports = [ ({ environment.systemPackages = [ nixpkgs.git ]; }) ];
}
