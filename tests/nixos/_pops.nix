{
  omnibus,
  root,
  inputs',
}:
(omnibus.pops.exporter.addLoadExtender {
  load = {
    src = ./__fixture;
    inputs = {
      data = root.data;
      nixpkgs = inputs'.nixpkgs;
      darwin = inputs'.darwin;
    };
  };
})
