{
  pkgs,
  lib,
  ...
}:

let
  omnibus = import ./.;

  configsPrek = (
    (omnibus.pops.configs {
      inputs.inputs = {
        nixago = omnibus.flake.inputs.nixago;
        nixpkgs = pkgs;
      };
    }).exports.default.prek
  );

  generatedHooks = [ configsPrek.cog.nixago ];
in
{
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = [
    pkgs.nixtamal
    pkgs.namaka
  ]
  ++ lib.flatten (map (g: g.__passthru.packages) generatedHooks);

  # https://devenv.sh/languages/
  # languages.rust.enable = true;

  # https://devenv.sh/processes/
  # processes.dev.exec = "${lib.getExe pkgs.watchexec} -n -- ls -la";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  scripts.hello.exec = "";

  # https://devenv.sh/basics/
  enterShell = lib.concatMapStringsSep "\n" (g: g.shellHook) generatedHooks;

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  enterTest = "";

  # https://devenv.sh/git-hooks/
  git-hooks = {
    package = pkgs.prek;
    hooks = {
      cocogitto-verify = configsPrek.cog.git-hooks.hooks.cocogitto-verify;
      nixfmt.enable = true;
    };
  };
  # See full reference at https://devenv.sh/reference/options/
}
