let
  pkgs' = nixpkgs.appendOverlays [ fenix.overlays.default ];
in
{
  imports = [ (extraModulesPath + "/language/rust.nix") ];

  language.rust = {
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
