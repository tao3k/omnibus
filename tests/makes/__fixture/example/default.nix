makeScript {
  name = "runScriptWithEnv";
  searchPaths.bin = [ nixpkgs.awscli ];
  searchPaths.source = [ ./env ];
  entrypoint = ./entrypoint.sh;
}
