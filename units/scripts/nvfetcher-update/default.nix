makeScript {
  name = "nvfetcher-update";
  searchPaths.bin = [ nixpkgs.nvfetcher ];
  searchPaths.source = [ ];
  entrypoint = ./entrypoint.sh;
}
