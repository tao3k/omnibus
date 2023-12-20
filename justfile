deadnix:
    deadnix . --edit --exclude ./units/std/blockTypes/*

justfmt:
    just --fmt --unstable

exmaples-nvfetcher:
    nix run .\#scripts.nvfetch-update ./examples/packages/source.toml

template-nixos:
    nix build ./templates/nixos#nixosConfigurations.nixos.config.system.build.toplevel \
                               --dry-run --override-input omnibus ./. --no-link

local-nixos:
    nix build ./local#eval.nixos.expr.nixosConfiguration.config.system.build.toplevel --dry-run --no-link


nixci-examples:
    nix flake lock --update-input omnibus ./examples --override-input omnibus ./.
    (cd examples && nixci && git rm flake.lock -f)

examples-simple:
    nix flake lock --update-input omnibus ./examples/simple --override-input omnibus ./.
    (cd examples/simple && \
    nix build ./#nixosConfigurations.simple.config.system.build.toplevel \
                                --dry-run --no-link \
    && git rm flake.lock -f)
