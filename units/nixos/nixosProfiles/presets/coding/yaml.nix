{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ yaml-language-server ];
}
