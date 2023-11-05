inputs.self.pops.lib.load.inputs
// {
  omnibus =
    (lib.recursiveUpdate root { pops.lib = inputs.self.pops.lib; })
    // root.flakeOutputs;
}
