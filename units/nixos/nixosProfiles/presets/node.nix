{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    yarn
    nodejs
  ];
}
