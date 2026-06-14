#!/usr/bin/bash

set -euo pipefail

latest_tag=$1

if git ls-remote --exit-code --tags origin "refs/tags/${latest_tag}-lurtz" > /dev/null 2>&1; then
	echo "Tag ${latest_tag}-lurtz already exists on origin. Skipping."
	exit 0
fi

# Add evcc remote if it doesn't exist
git remote get-url evcc > /dev/null 2>&1 || git remote add evcc https://github.com/evcc-io/evcc.git

echo "Rebasing on tag $latest_tag"

git fetch evcc # evcc is upstream
git checkout master-lurtz
git pull
git rebase $latest_tag
git push --force-with-lease
git tag $latest_tag-lurtz
git push origin $latest_tag-lurtz

exit 0
