override-omnibus := "nix flake lock --override-input omnibus"
remove-flake-lock := "git rm flake.lock -f"

std-standard:
    nix develop ./local\#std --command bash -c "(cd examples/stdStandard \
    && {{ override-omnibus }} ../.. \
    && std //dev/scripts/hello:run \
    && {{ remove-flake-lock }})"

std-default: std-default-sync
    nix develop ./local\#std --command bash -c "(cd examples/stdDefault \
    && {{ override-omnibus }} ../.. \
    && std //dev/scripts/makes-test:run \
    && std //dev/scripts/hello:run \
    && std //dev/tasks/hello:run \
    && std //dev/packages/hello:build \
    && std //dev/shells/default:build \
    && rm result \
    && {{ remove-flake-lock }})"

std-default-sync:
    rsync -av ./units/std/defaultCellsFrom/dev/ ./units/std/defaultCellsFrom/prod

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

nixci-examples-packages:
    (cd examples && {{ override-omnibus }} .. && nixci && {{ remove-flake-lock }})

examples-simple:
    nix flake lock --update-input omnibus ./examples/simple --override-input omnibus ./.
    (cd examples/simple && \
    nix build ./#nixosConfigurations.simple.config.system.build.toplevel \
                                --dry-run --no-link \
    && {{ remove-flake-lock }})

examples-system-manager:
    nix flake lock --update-input omnibus ./examples/system-manager --override-input omnibus ./.
    (cd examples/system-manager && \
    nix run 'github:numtide/system-manager' --refresh --extra-substituters https://cache.garnix.io \
    --extra-trusted-public-keys cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g= \
    -- build --flake ./#example \
    && {{ remove-flake-lock }} && rm ./result)

nixci-examples-python:
    nix flake lock --update-input omnibus ./examples/python --override-input omnibus ./.
    (cd examples/python && nixci && git rm flake.lock -f)

nixci-jupyenv +quarto:
    # --execute-daemon-restart
    nix flake lock --update-input omnibus ./examples/jupyenv+quarto --override-input omnibus ./.
    (cd examples/jupyenv+quarto && nixci && \
    nix run .#quartoSimple -- render ./quarto \
    && {{ remove-flake-lock }})
