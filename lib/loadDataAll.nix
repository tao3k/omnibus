(omnibus.loadData.addLoadExtender {
  loader = with haumea; [
    (matchers.regex "^(.+)\\.(yaml|yml)$" (
      _: _: path:
      super.readYAML path
    ))
  ];
})
