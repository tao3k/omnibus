/* This file holds configuration data for repo dotfiles.

   Q: Why not just put the put the file there?

   A: (1) dotfile proliferation
      (2) have all the things in one place / fromat
      (3) potentially share / re-use configuration data - keeping it in sync
*/
{ inputs, cell }:
with inputs.std.inputs.dmerge; {
  conform.data = {
    commit.conventional.scopes = append [ "nixosModules" ];
  };
}
