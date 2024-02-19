# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ inputs, root }:
/* Use the Runnables Blocktype for targets that you want to
   make accessible with a 'run' action on the TUI.
*/
let
  inherit (inputs.std) actions;
  inherit (root) mkCommand run;
in
name: {
  inherit name;
  type = "jupyenv";
  actions =
    {
      currentSystem,
      fragment,
      fragmentRelPath,
      target,
      inputs,
    }:
    [
      (actions.build currentSystem target.config.build)
      (run currentSystem target.config.build)
      (mkCommand currentSystem "quarto" "pass any command to quarto" [ ] ''
        (cd "$PRJ_ROOT" && ${target.config.quartoEnv}/bin/quarto "$@")
      '' { })
    ];
}
