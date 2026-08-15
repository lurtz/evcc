#!/usr/bin/bash

set -euo pipefail

push_enabled=$1
if [ "$push_enabled" = "--push" ]; then
	shift
fi

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
git tag $latest_tag-lurtz

if [ "$push_enabled" = "--push" ]; then
	echo "Pushing tag ${latest_tag}-lurtz to origin."
	git push --force-with-lease
	git push origin $latest_tag-lurtz
else
	echo "Push is disabled. Skipping push of tag ${latest_tag}-lurtz to origin."
fi

exit 0
