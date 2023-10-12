{
  imports = [ (loadSubmodule ./config.nix) ];

  options.__profiles__ =
    with lib;
    mkOption {
      default = { };
      type = types.submodule {
        options = {
          swww = {
            enable = mkEnableOption (lib.mdDoc "Whether to enable swww wallpaper profile");
            runtimeEnv = mkOption {
              type = types.attrs;
              default = { };
              description = "The runtime environment to use for swww";
            };
          };
          nvidia = mkEnableOption (lib.mdDoc "Whether to enable nvidia profile");
          autoLogin = {
            enable = mkEnableOption (lib.mdDoc "Whether to enable auto login");
            shell = mkOption {
              type = types.str;
              default = "zsh";
              description = "The shell to use for auto login";
            };
          };
        };
      };
    };
}
