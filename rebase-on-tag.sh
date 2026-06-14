#!/usr/bin/bash

set -euo pipefail

latest_tag=$1

echo "Rebasing on tag $latest_tag"

git fetch evcc # evcc is upstream
git checkout master-lurtz
git pull
git rebase $latest_tag
git push --force-with-lease
git tag $latest_tag-lurtz
git push origin $latest_tag-lurtz

exit 0
