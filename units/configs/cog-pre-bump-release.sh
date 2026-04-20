set -eu

version="{{version}}"
release_branch="release/${version%.*}"

# Reuse an existing local branch when possible, otherwise track the remote
# release branch before creating a fresh one.
if git show-ref --verify --quiet "refs/heads/$release_branch"; then
  git switch "$release_branch"
elif git ls-remote --exit-code --heads origin "$release_branch" >/dev/null 2>&1; then
  git switch --track -c "$release_branch" "origin/$release_branch"
else
  git switch -c "$release_branch"
fi

git merge --ff-only main
printf '%s\n' "$version" > VERSION
