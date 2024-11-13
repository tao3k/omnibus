# SPDX-FileCopyrightText: 2024 The divnix/hive Authors
#
# SPDX-License-Identifier: Unlicense

{
  lib,
  root,
  super,
}:
let
  inherit (lib) pipe;
  l = lib // builtins;
  inherit (root.hive) checks transformers;

  # Error reporting
  showAssertions =
    let
      collectFailed =
        cfg: l.map (x: x.message) (l.filter (x: !x.assertion) cfg.assertions);
      showWarnings =
        res:
        let
          f = w: x: l.trace "warning: ${w}" x;
        in
        l.fold f res res.config.warnings;
    in
    evaled:
    showWarnings (
      let
        failed = collectFailed evaled.config;
        failedStr = l.concatStringsSep "\n" (map (x: "- ${x}") failed);
      in
      if failed == [ ] then evaled else throw "\nFailed assertions:\n${failedStr}"
    );

  hmCliSchema =
    evaled:
    let
      asserted = showAssertions evaled;
    in
    {
      inherit (asserted) options config;
      inherit (asserted.config.home) activationPackage;
      newsDisplay = evaled.config.news.display;
      newsEntries = l.sort (a: b: a.time > b.time) (
        l.filter (a: a.condition) evaled.config.news.entries
      );
    };
in
super.walk transformers.homeConfiguration [
  (config: config.bee._evaled)
  hmCliSchema
]
