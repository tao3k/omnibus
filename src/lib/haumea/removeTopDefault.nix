_: cursor: dir:
if (builtins.length cursor == 0 && (dir ? default)) then
  removeAttrs dir [ "default" ]
else
  dir
