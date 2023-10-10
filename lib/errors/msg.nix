_: name: ''
      please, add the home-manager into omnibus.lib.addLoadExtender {
                     load.inputs = {
                        inputs.${name} = inputs.${name};
                     };
            };
  }
''
