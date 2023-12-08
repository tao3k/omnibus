{root, lib}:
let
  presets = root.presets;
  inherit (lib.omnibus) mkSuites;
in
mkSuites {
  default = with presets; [
    {
      keywords = ["screenshot"];
      knowledges = ["https://github.com/gabm/satty"];
      profiles = [satty];
    }
  ];
}
