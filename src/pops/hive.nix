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
      nodeNixpkgs =
        lib.mapAttrs (hostName: hostConfig: hostConfig.meta.colmena.nixpkgs)
          hosts;
      nodes =
        lib.mapAttrs
          (hostName: hostConfig: {
            inherit (hostConfig.meta.colmena) imports deployment;
          })
          hosts;
    };
  };
  hosts = {
    host-1 = {
      colmena = {
        nixpkgs = { };
        deployment = { };
        imports = [ ];
      };
    };
    host-2 = {
      meta = {
        a = 1;
      };
      colmena = {
        nixpkgs = { };
        deployment = { };
        imports = [ "2" ];
      };
    };
    host-3 = {
      meta = { };
      a = { };
    };
  };
in
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
        hosts;
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
        pops = super.hostsInterface;
        addLoadExtender = {
          load = {
            inputs = {
              inherit inputs;
            };
          };
        };
      };
    };
  };
}
