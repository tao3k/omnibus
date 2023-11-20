let
  lock = builtins.fromJSON (builtins.readFile ./flake.lock);
  call-flake = import (
    (fetchTarball {
      url = "https://github.com/divnix/call-flake/archive/${lock.nodes.call-flake.locked.rev}.tar.gz";
      sha256 = lock.nodes.call-flake.locked.narHash;
    })
    + "/flake.nix"
  );
in
call-flake.outputs { } ./.
