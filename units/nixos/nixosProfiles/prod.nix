{root, lib}:
let
  presets = root.presets;
  inherit (lib.omnibus) mkSuites;
in
mkSuites {
  networking = with presets; [
    {
      keywords = [
        "bbr"
        "optimization"
        "networking"
        "tcp"
      ];
      knowledges = ["https://wiki.archlinux.org/title/sysctl#Networking"];
      profiles = [
        networking.bbr
        networking.optimise
      ];
    }
  ];
}
