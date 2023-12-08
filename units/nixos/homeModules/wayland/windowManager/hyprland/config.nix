# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  config =
    with lib;
    mkIf cfg.enable (
      mkMerge [
        {
          home.sessionVariables = {
            QT_QPA_PLATFORM = "wayland";
            SDL_VIDEODRIVER = "wayland";
            GDK_BACKEND = "wayland";
            _JAVA_AWT_WM_NONREPARENTING = 1;
            MOZ_ENABLE_WAYLAND = "1";
            XDG_CURRENT_DESKTOP = "Hyprland";
            XDG_SESSION_DESKTOP = "Hyprland";
            XDG_SESSION_TYPE = "wayland";
          };
        }
        (mkIf cfg.__profiles__.nvidia {
          wayland.windowManager.hyprland.enableNvidiaPatches = true;
          home.sessionVariables = {
            LIBVA_DRIVER_NAME = "nvidia";
            GBM_BACKEND = "nvidia-drm";
            __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          };
        })
        (mkIf cfg.__profiles__.autoLogin.enable {
          programs.${cfg.__profiles__.autoLogin.shell} = {
            loginExtra = ''
              # If running from tty1 start hyprland
              if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
                Hyprland
              fi
            '';
          };
        })
        (mkIf cfg.__profiles__.swww.enable {
          home.packages = [
            pkgs.swww
            (pkgs.writeShellApplication {
              name = "swww-random";
              runtimeInputs = [pkgs.swww];
              text =
                ''
                  ${lib.concatStringsSep "\n" (
                    lib.mapAttrsToList (n: v: "export ${n}=${''"$''}{${n}:-${toString v}}${''"''}")
                      (
                        {
                          # Edit bellow to control the images transition
                          SWWW_TRANSITION_FPS = 60;
                          SWWW_TRANSITION_STEP = 2;
                          INTERVAL = 3000;
                        }
                        // cfg.__profiles__.swww.runtimeEnv
                      )
                  )}
                ''
                + lib.fileContents ./swww_randomize.sh;
            })
          ];
        })
      ]
    );
}
