{ pkgs, ... }:
{
  environment.variables.PLAYWRIGHT_BROWSERS_PATH =
    pkgs.playwright-driver.browsers.outPath;
  environment.systemPackages = with pkgs; [
    playwright
    d2
  ];
}
