# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
# SPDX-FileCopyrightText: 2026 The omnibus Authors
#
# SPDX-License-Identifier: MIT

let
  /**
    Inline a versioned shell hook into `cog.toml` while keeping nixago as the
    single place that renders repository config.
  */
  shellHook = path: ''
    sh -eu <<'SH'
    ${builtins.readFile path}
    SH
  '';
in
{
  default = {
    data = {
      tag_prefix = "v";
      branch_whitelist = [
        "main"
        "release/**"
      ];
      ignore_fixup_commits = true;
      ignore_merge_commits = true;
      /**
        Keep the hook bodies in versioned shell files, but still inline them
        into `cog.toml` so nixago remains the single source of truth.
      */
      pre_bump_hooks = [
        (shellHook ./cog-pre-bump-release.sh)
      ];
      post_bump_hooks = [
        (shellHook ./cog-post-bump-release.sh)
      ];
      changelog = {
        path = "CHANGELOG.md";
        template = "remote";
        remote = "github.com";
        owner = "tao3k";
        repository = "omnibus";
      };
    };
  };
}
