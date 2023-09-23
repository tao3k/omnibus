let
  pkgs' = nixpkgs.appendOverlays [ config.language.rust.overlays.default ];
  cfg = config.language.rust;
in
{
  imports = [
    POS.devshellModules.language.rust
    (extraModulesPath + "/language/rust.nix")
  ];

  language.rust = {
    overlays = fenix.overlays;
    rustSrc = pkgs'.fenix.complete.rust-src;
    packageSet = pkgs'.fenix.default;
    enableDefaultToolchain = true;
    tools = [ "toolchain" ];
  };

  devshell.startup.link-cargo-home =
    let
      toolchain =
        let
          packageSet = map (n: cfg.packageSet.${n}) cfg.tools;
        in
        pkgs'.fenix.combine (packageSet ++ [ cfg.rustSrc ]);
    in
    {
      deps = [ ];
      text = ''
        # ensure CARGO_HOME is populated
        mkdir -p $PRJ_DATA_DIR/cargo
        ln -snf -t $PRJ_DATA_DIR/cargo $(ls -d ${toolchain.outPath}/*)
      '';
    };

  env = [
    {
      # ensures subcommands are picked up from the right place
      # but also needs to be writable; see link-cargo-home above
      name = "CARGO_HOME";
      eval = "$PRJ_DATA_DIR/cargo";
    }
    {
      # ensure we know where rustup_home will be
      name = "RUSTUP_HOME";
      eval = "$PRJ_DATA_DIR/rustup";
    }
    {
      name = "RUST_SRC_PATH";
      # accessing via toolchain doesn't fail if it's not there
      # and rust-analyzer is graceful if it's not set correctly:
      # https://github.com/rust-lang/rust-analyzer/blob/7f1234492e3164f9688027278df7e915bc1d919c/crates/project-model/src/sysroot.rs#L196-L211
      value = "${config.language.rust.rustSrc}/lib/rustlib/src/rust/library";
    }
  ];
}
