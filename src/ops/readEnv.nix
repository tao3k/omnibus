# copyright: @domenkozar https://github.com/cachix/devenv/issues/516#issue-1652139691

{ lib }:
let
  parseLine =
    line:
    let
      parts = builtins.match "(.+) *= *(.+)" line;
    in
    if (!builtins.isNull parts) && (builtins.length parts) == 2 then
      {
        name = builtins.elemAt parts 0;
        value = builtins.elemAt parts 1;
      }
    else
      null;

  parseEnvFile =
    content:
    builtins.listToAttrs (
      lib.filter (x: !builtins.isNull x) (
        map parseLine (lib.splitString "\n" content)
      )
    );

  envContent = file: builtins.readFile file;
in
parseEnvFile envContent
