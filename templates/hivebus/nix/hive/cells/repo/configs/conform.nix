{ inputs }:
with inputs.dmerge; {
  data = {
    commit.conventional.scopes = append [
      "nixosModules"
      "nixosProfiles"
      "homeProfiles"
      "homeModules"
      "darwinModules"
      "darwinProfiles"
      ".*."
    ];
  };
}
