(super.data.addLoadExtender {
  load = {
    loader = with haumea; [
      (matchers.regex "^(.+)\\.(yaml|yml)$" (
        _: _: path:
        root.ops.readYAML path
      ))
    ];
  };
})
