{
  config =
    with lib;
    mkMerge [
      (mkIf cfg.__profiles__.catppuccin-mocha.enable {
        config = {
          theme = "Catppuccin-mocha";
          style = "changes,header";
        };
        # bat cache --build
        themes = {
          Catppuccin-mocha = builtins.readFile (
            __misc__.catppuccin-bat + "/Catppuccin-mocha.tmTheme"
          );
        };
      })
    ];

  options.__profiles__ = with lib; {
    catppuccin-mocha.enable =
      mkEnableOption
        "Whether to enable the catppuccino-mocha theme";
  };
}
