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
