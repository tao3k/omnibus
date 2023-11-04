super.nixosProfiles.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/units/devshell/profiles";
    type = "nixosProfiles";
  };
}
