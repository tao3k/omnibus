/* This file holds configuration data for repo dotfiles.

   Q: Why not just put the put the file there?

   A: (1) dotfile proliferation
      (2) have all the things in one place / fromat
      (3) potentially share / re-use configuration data - keeping it in sync
*/
{ inputs, cell }:
(inputs.repo.inputs.omnibus.pops.exporter.addLoadExtender {
  load.src = ./configs;
}).outputs
  { }
