let
  pkgs' = nixpkgs.appendOverlays [ config.language.rust.overlays.default ];
in
{
  imports = [
    POS.devshellModules.language.rust
    (extraModulesPath + "/language/rust.nix")
  ];

  language.rust = {
    overlays = fenix.overlays;
    packageSet = pkgs'.fenix.default;
    enableDefaultToolchain = true;
    tools = [ "toolchain" ];
  };

  devshell.startup.link-cargo-home = {
    deps = [ ];
    text = ''
      # ensure CARGO_HOME is populated
      mkdir -p $PRJ_DATA_DIR/cargo
      ln -snf -t $PRJ_DATA_DIR/cargo $(ls -d ${config.language.rust.packageSet.toolchain}/*)
    '';
  };
}
