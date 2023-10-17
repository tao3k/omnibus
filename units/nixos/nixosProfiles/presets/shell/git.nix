{ pkgs, inputs }:
{
  programs.git.enable = true;
  environment.systemPackages = [
    pkgs.git
    # inputs.nixpkgs.gh
  ];
}
