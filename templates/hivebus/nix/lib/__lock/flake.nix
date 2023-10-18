{
  inputs = {
    nix-filter = {
      url = "github:numtide/nix-filter";
    };
    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };
  };
  outputs = _: { };
}
