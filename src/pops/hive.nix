{
  POP,
  lib,
  flops,
  super,
}:
let
  inherit (POP) pop;

  genColmenaFromHosts = hosts: {
    meta = {
      nodes =
        lib.mapAttrs
          (hostName: hostConfig: {
            inherit (hostConfig.meta.colmena) imports deployment;
          })
          hosts;
      nodeNixpkgs =
        lib.mapAttrs
          (
            hostName: hostConfig: (super.types.hive.colmena hostConfig.meta.colmena).nixpkgs
          )
          hosts;
    };
  };
in
setHosts:
pop {
  defaults = {
    hosts =
      lib.mapAttrs
        (
          hostName: hostConfig:
          (hostConfig)
          // {
            meta = (hostConfig.meta or { }) // (removeAttrs hostConfig [ "meta" ]);
          }
        )
        setHosts;
    pops = {
      omnibus = { };
      nixosProfiles = { };
      nixosModules = { };
    };
    exports = {
      hosts = { };
    };
  };
  extension = final: prev: {
    colmena = genColmenaFromHosts (
      lib.filterAttrs (n: v: v.meta ? "colmena") prev.hosts
    );
    addMapLoadToPops = load: { };
    pops = { };
    exports = {
      hosts = lib.omnibus.mkHosts {
        # hostsDir = projectRoot + "/units/nixos/hosts";
        hostsDir = ./.;
        pops = super.hostsInterface;
        addLoadExtender = {
          load = { };
        };
      };
    };
  };
}
