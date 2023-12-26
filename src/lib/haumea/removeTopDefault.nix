{ lib }:
cursor: dir:
if (lib.length cursor == 0 && (dir ? default)) then
  removeAttrs dir [ "default" ]
else
  dir
