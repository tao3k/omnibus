#!/usr/bin/env bash

# Move to the directory of the script
PRJ_ROOT="${PRJ_ROOT:-"$(git rev-parse --show-toplevel)"}"

# shellcheck disable=all
cd "$(dirname "$PRJ_ROOT/$@")"

# Run nvfetcher with the provided arguments
# shellcheck disable=all
nvfetcher -c "$PRJ_ROOT/$@" -l /tmp/nvfetcher-changelog

# If the changelog is not empty and the GITHUB_ENV variable is set
if [[ -s /tmp/nvfetcher-changelog && -n ${GITHUB_ENV:-} ]]; then
  # Append the changelog to the GITHUB_ENV variable
  {
    echo "COMMIT_MSG<<EOF"
    cat /tmp/nvfetcher-changelog
    echo "EOF"
  } >>"$GITHUB_ENV"
fi
