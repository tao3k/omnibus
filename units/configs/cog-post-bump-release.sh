set -eu

version="{{version}}"
version_tag="{{version_tag}}"
next_dev_version="{{version+minor-dev}}"
release_branch="release/${version%.*}"

git push --set-upstream origin "$release_branch"
git push origin "$version_tag"
git switch main

# Stage the release branch onto `main` first, then replace `VERSION` with the
# next development marker before the merge commit is created.
git merge --no-commit --no-ff "$release_branch"
printf '%s\n' "$next_dev_version" > VERSION
git add VERSION
git commit -m "chore(version): start $next_dev_version"
git push origin main
