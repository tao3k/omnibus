super.nixosModules.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/units/devshell/modules";
    type = "nixosModules";
  };
}
