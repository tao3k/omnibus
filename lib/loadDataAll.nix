(omnibus.pops.loadData.addLoadExtender {
  load = {
    loader = with haumea; [
      (matchers.regex "^(.+)\\.(yaml|yml)$" (
        _: _: path:
        super.readYAML path
      ))
    ];
  };
})
