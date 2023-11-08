super.nixosProfiles.addLoadExtender {
  load = {
    src = projectDir + "/units/devshell/profiles";
    loader =
      with haumea;
      [ (matchers.nix loaders.default) ]
      ++ lib.optionals (inputs ? devshell) [
        (matchers.regex "^(.+)\\.(toml)$" (
          _matches: _: path:
          inputs.devshell.lib.importTOML path
        ))
      ];
  };
}
