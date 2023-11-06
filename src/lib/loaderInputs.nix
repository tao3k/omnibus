inputs.self.pops.self.load.inputs
// {
  omnibus =
    (lib.recursiveUpdate root { pops.self = inputs.self.pops.self; })
    // root.flakeOutputs;
}
