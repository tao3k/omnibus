(omnibus.pops.loadData.addLoadExtender {
  loader = with haumea; [
    (matchers.regex "^(.+)\\.(yaml|yml)$" (
      _: _: path:
      super.inputs.outputs.std.lib.ops.readYAML path
    ))
  ];
})
