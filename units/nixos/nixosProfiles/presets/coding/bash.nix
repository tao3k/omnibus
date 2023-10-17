{
  pkgs,
  config,
  omnibus,
  ...
}:
let
  cfg = config.omnibus.coding.bash;
in
{
  imports = [ omnibus.nixosModules.omnibus.coding.bash ];
  environment.systemPackages =
    with pkgs;
    [ shellcheck ] ++ lib.optionals cfg.lsp [ nodePackages.bash-language-server ];
}
