deadnix:
    deadnix . --edit --exclude ./units/std/blockTypes/*

justfmt:
    just --fmt --unstable

exmaples-nvfetcher:
    nix run .\#scripts.nvfetch-update ./examples/packages/source.toml
