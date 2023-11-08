{ pkgs }:
{
  kernel.bash.omnibus = {
    enable = true;
    runtimePackages = [ pkgs.git ];
  };
}
