# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib }:
{
  homeModule ? [ ],
  user,
  shell,
  suites ? [ ],
}:
let
  userName = lib.head (lib.attrNames user);
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
    lib.flatten [
      homeModule
      { users.users = user; }
      (
        { pkgs, lib, ... }:
        {
          config =
            with lib;
            mkMerge [
              {
                home-manager.useGlobalPkgs = lib.mkDefault true;
                home-manager.useUserPackages = lib.mkDefault true;

                home-manager.users.${userName} = {
                  imports = lib.flatten [
                    suites
                    { programs.${shell}.enable = true; }
                  ];
                  home.stateVersion =
                    if pkgs.stdenv.isDarwin then pkgs.lib.trivial.release else "24.05";
                };
                users.users.${userName} = {
                  shell = pkgs."${shell}";
                  home =
                    if pkgs.stdenv.isDarwin then "/Users/${userName}" else "/home/${userName}";
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
