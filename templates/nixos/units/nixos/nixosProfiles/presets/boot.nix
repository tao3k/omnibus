{
  imports = [ inputs.self.nixosModules.boot ];
  boot.__profiles__.test = "nixosProfiles.boot";
}
