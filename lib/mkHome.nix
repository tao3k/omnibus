{
  lib,
  inputs,
  root,
}:
homeModule: userSet: shell: suites:
let
  user = lib.head (lib.attrNames userSet);
  pathsToLinkShell = lib.elem shell [
    "fish"
    "zsh"
    "bash"
  ];
  enableDefaultShellProgram =
    if pathsToLinkShell then { programs.${shell}.enable = true; } else { };
in
{
  imports =
    [
      homeModule
      { users.users = userSet; }
      (
        { pkgs, lib, ... }:
        {
          config =
            with lib;
            mkMerge [
              {
                home-manager.useGlobalPkgs = lib.mkDefault true;
                home-manager.useUserPackages = lib.mkDefault true;

                home-manager.users.${user} = {
                  imports = lib.flatten [
                    suites
                    { programs.${shell}.enable = true; }
                  ];
                  home.stateVersion =
                    if pkgs.stdenv.isDarwin then pkgs.lib.trivial.release else "23.11";
                };
                users.users.${user} = {
                  shell = pkgs."${shell}";
                  home = if pkgs.stdenv.isDarwin then "/Users/${user}" else "/home/${user}";
                };
              }
              enableDefaultShellProgram
            ];
        }
      )
    ]
    ++ lib.optionals pathsToLinkShell [
      { environment.pathsToLink = [ "/share/${shell}" ]; }
    ];
}
