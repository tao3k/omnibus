super.nixosModules.addLoadExtender {
  load = {
    src = projectDir + "/units/devshell/modules";
    type = "nixosModules";
  };
}
