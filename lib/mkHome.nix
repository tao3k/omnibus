{
  lib,
  inputs,
  root,
}:
userSet: shell: suites:
let
  inherit (root.errors.requiredInputs inputs "lib" [ "home-manager" ])
    home-manager
  ;
  user = lib.head (lib.attrNames userSet);
  pathsToLinkShell = lib.elem shell [
    "fish"
    "zsh"
    "bash"
  ];
in
{
  imports =
    [
      home-manager.nixosModules.default
      { users.users = userSet; }
      (
        { pkgs, lib, ... }:
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.${user} = {
            imports = lib.flatten suites;
            home.stateVersion =
              if pkgs.stdenv.isDarwin then pkgs.lib.trivial.release else "23.11";
          };
          users.users.${user} = {
            shell = pkgs."${shell}";
            home = if pkgs.stdenv.isDarwin then "/Users/${user}" else "/home/${user}";
          };
          programs.${shell}.enable = true;
        }
      )
    ]
    ++ lib.optionals pathsToLinkShell [ {
      environment.pathsToLink = [ "/share/${shell}" ];
    } ];
}
