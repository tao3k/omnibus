writeShellApplication {
  name = "nvfetcher-update";
  runtimeInputs = [nixpkgs.nvfetcher];
  text = nixpkgs.lib.fileContents ./entrypoint.sh;
}
