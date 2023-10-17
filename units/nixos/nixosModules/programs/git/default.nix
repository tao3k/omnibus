{
  enable = true;
  imports = [ ({
    environment.systemPackages = [
      pkgs.git
      inputs.nixpkgs.gh
    ];
  }) ];
}
