{
  enable = true;
  imports = [ ({
    environment.systemPackages = [
      pkgs.git
      nixpkgs.gh
    ];
  }) ];
}
