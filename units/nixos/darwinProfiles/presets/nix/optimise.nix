# credit: https://github.com/montchr/dotfield/blob/68f6c9c3f6cc67c5c775b8a2a3f93cae6a76b3a5/profiles/darwinProfiles/core/nix-optimizations-darwin.nix#L9
{ config }:
{
  nix.settings.auto-optimise-store = false;
  # While it’s possible to set `auto-optimise-store` in `nix.conf`, it sometimes causes problems
  # on Darwin.  Run a job periodically to optimise the store.
  launchd.daemons."nix-store-optimise".serviceConfig = {
    ProgramArguments = [
      "/bin/sh"
      "-c"
      ''
        /bin/wait4path ${config.nix.package}/bin/nix && \
          exec ${config.nix.package}/bin/nix store optimise
      ''
    ];
    StartCalendarInterval = [
      {
        Hour = 2;
        Minute = 0;
      }
    ];
    StandardErrorPath = "/var/log/nix-store.log";
    StandardOutPath = "/var/log/nix-store.log";
  };

  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 2;
      Minute = 0;
    };
    options = "--delete-older-than 30d";
  };
}
