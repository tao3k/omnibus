# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  inputs,
  omnibus,
  lib,
  pkgs,
}:
let
  inherit
    (omnibus.errors.requiredInputsLazily inputs "omnibus.pops.flake-parts.profiles"
      [ "chinookDb" ]
    )
    chinookDb
    ;

  port = 8213;
  dataFile = "data.sqlite";
in
{
  process-compose.sqlite-example = {
    settings = {
      environment = {
        SQLITE_WEB_PASSWORD = "demo";
      };

      processes = {
        # Print a pony every 2 seconds, because why not.
        ponysay.command = ''
          while true; do
            ${lib.getExe pkgs.ponysay} "Enjoy our sqlite-web demo!"
            sleep 2
          done
        '';

        # Create .sqlite database from chinook database.
        sqlite-init.command = ''
          echo "$(date): Importing Chinook database (${dataFile}) ..."
          ${lib.getExe pkgs.sqlite} "${dataFile}" < ${chinookDb}/ChinookDatabase/DataSources/Chinook_Sqlite.sql
          echo "$(date): Done."
        '';

        # Run sqlite-web on the local chinook database.
        sqlite-web = {
          command = ''
            ${pkgs.sqlite-web}/bin/sqlite_web \
              --password \
              --port ${builtins.toString port} "${dataFile}"
          '';
          # The 'depends_on' will have this process wait until the above one is completed.
          depends_on."sqlite-init".condition = "process_completed_successfully";
          readiness_probe.http_get = {
            host = "localhost";
            inherit port;
          };
        };
        test = {
          command = pkgs.writeShellApplication {
            name = "sqlite-web-test";
            runtimeInputs = [ pkgs.curl ];
            text = ''
              curl -v http://localhost:${builtins.toString port}/
            '';
          };
          depends_on."sqlite-web".condition = "process_healthy";
        };
      };
    };
  };
}
