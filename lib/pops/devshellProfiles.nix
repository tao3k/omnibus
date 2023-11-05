super.nixosProfiles.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/units/devshell/profiles";
    loaders =
      with haumea;
      [ (matchers.nix loaders.default) ]
      ++ lib.optionals (inputs ? devshell) [
        (matchers.regex "^(.+)\\.(toml)$" (
          matches: _: path:
          inputs.devshell.lib.importTOML path
        ))
      ];
  };
}
