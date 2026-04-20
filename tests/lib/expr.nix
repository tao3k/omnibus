# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ omnibus, system }:
let
  inherit (omnibus.lib.omnibus) inputsToPaths;
  addedLoads =
    omnibus.lib.omnibus.addLoadToPops [ "host-a" "host-b" ]
      {
        keep = {
          value = 1;
        };
        test = {
          addLoadExtender = selectors: selectors;
        };
      }
      (
        host: popName: _value: {
          inherit host popName;
        }
      );
  concatProfilesResult = omnibus.lib.omnibus.concatProfiles [
    "a"
    {
      keywords = [ ];
      knowledges = [ ];
      profiles = [
        "b"
        "c"
      ];
    }
  ];
  generatedAttrs = omnibus.lib.attrsets."genAttrs'" [ "a" "b" ] (name: {
    inherit name;
    value = "${name}-value";
  });
  mapPopsExportsPrime = omnibus.lib.omnibus."mapPopsExports'" {
    group = {
      leaf = {
        exports = {
          default = {
            value = 1;
          };
          extra = {
            value = 2;
          };
        };
      };
    };
  };
  mkSuitesResult = omnibus.lib.omnibus.mkSuites {
    passthru = 1;
    suite = [
      "a"
      {
        keywords = [ ];
        knowledges = [ ];
        profiles = [
          "b"
          "c"
        ];
      }
    ];
  };
  overlaysPop = omnibus.pops.overlays { src = ./__fixture; };
  pkgs = omnibus.flake.inputs.nixpkgs.legacyPackages.${system};
  cleanSourceTopDefaultEntries = builtins.attrNames (
    builtins.readDir (omnibus.lib.omnibus.cleanSourceTopDefault ../hive/__fixture/test)
  );
  filteredDerivations = omnibus.lib.attrsets.filterDerivations {
    nested = {
      recurseForDerivations = true;
      package = pkgs.hello;
      ignored = 1;
      child = {
        recurseForDerivations = true;
        package = pkgs.bash;
        ignored = "value";
      };
    };
    plain = {
      package = pkgs.hello;
    };
    package = pkgs.coreutils;
    ignored = 1;
  };
  recursiveDerivationValues = omnibus.lib.recursiveAttrValues {
    drv = pkgs.writeText "recursive-attr-values-leaf" "ok";
  };
  strippedAttrsForHydra = omnibus.lib.attrsets.stripAttrsForHydra {
    recurseForDerivations = true;
    dimension = "matrix";
    nested = {
      recurseForDerivations = true;
      dimension = "job";
      keep = 1;
    };
    keep = 1;
  };
  writeShellApplicationText =
    (omnibus.ops.writeShellApplication { nixpkgs = pkgs; } {
      name = "demo";
      text = "echo hi";
      runtimeEnv = {
        BAR = "a b";
        FOO = "$(echo pwned)";
      };
    }).text;
in
{
  addLoadToPopsShape = {
    hostNames = builtins.attrNames addedLoads;
    hostATest = addedLoads.host-a.test;
    hostBKeep = addedLoads.host-b.keep.value;
  };
  cleanSourceTopDefaultEntries = cleanSourceTopDefaultEntries;
  filterDerivationsShape = {
    rootNames = builtins.attrNames filteredDerivations;
    nestedNames = builtins.attrNames filteredDerivations.nested;
    nestedChildNames = builtins.attrNames filteredDerivations.nested.child;
    packageIsDerivation = pkgs.lib.isDerivation filteredDerivations.package;
    nestedPackageIsDerivation = pkgs.lib.isDerivation filteredDerivations.nested.package;
    nestedChildPackageIsDerivation = pkgs.lib.isDerivation filteredDerivations.nested.child.package;
  };
  concatProfiles = concatProfilesResult;
  genAttrsPrime = generatedAttrs;
  inputsToPaths = inputsToPaths {
    b = {
      inputs = {
        d = {
          outPath = "/nix/store/w065s95yy5k456kwa1h6bg9mc46gy89n-tracing-log-0.2.0";
          inputs = {
            nested = {
              outPath = "/nix/store/nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-deeper-source/share/doc";
            };
          };
        };
        f = {
          outPath = "<PATH-b.f>";
        };
      };
      outPath = "<PATH-b>";
    };
    a = {
      inputs = {
        b = {
          outPath = "<PATH-a.b>";
        };
        c = {
          outPath = "<PATH-a.c>";
        };
      };
      outPath = "/nix/store/w065s95yy5k456kwa1h6bg9mc46gy89n-tracing-log-0.3.0";
    };
  };
  inputsSourceNames = map (source: source.name) (
    omnibus.errors.inputsSource [
      "nixpkgs"
      "disko"
    ]
  );
  overlayLayoutNames = builtins.attrNames overlaysPop.layouts.default;
  composeOverlaysType = builtins.typeOf overlaysPop.exports.composeOverlays;
  recursiveAttrValuesDerivation = {
    length = builtins.length recursiveDerivationValues;
    isDerivation = pkgs.lib.isDerivation (builtins.elemAt recursiveDerivationValues 0);
  };
  mkSuitesShape = {
    metaSuiteProfiles = (builtins.elemAt mkSuitesResult.meta.suite 1).profiles;
    passthru = mkSuitesResult.passthru;
    suite = mkSuitesResult.suite;
  };
  mapPopsExportsPrime = {
    leafNames = builtins.attrNames mapPopsExportsPrime.group.leaf;
    defaultValue = mapPopsExportsPrime.group.leaf.default.value;
    extraValue = mapPopsExportsPrime.group.leaf.extra.value;
  };
  stripAttrsForHydra = strippedAttrsForHydra;
  writeShellApplicationLiteralRuntimeEnvDefaults =
    pkgs.lib.all (needle: pkgs.lib.hasInfix needle writeShellApplicationText) [
      "if [ -n \"\${BAR:-}\" ]; then"
      "export BAR='a b'"
      "if [ -n \"\${FOO:-}\" ]; then"
      "export FOO='$(echo pwned)'"
    ]
    && !(pkgs.lib.hasInfix "export FOO=\"\${FOO:-$(echo pwned)}\"" writeShellApplicationText);
}
