#!/bin/bash

set -o errexit -o nounset

terraform apply

echo "Setting git user name"
git config user.name "$GH_USER_NAME"

echo "Setting git user email"
git config user.email "$GH_USER_EMAIL"

echo "Adding git upstream remote"
git remote add upstream "https://$GH_TOKEN@github.com/$GH_REPO.git"

git checkout master
git add .
git commit -m "tfstate: $(TZ=Europe/Amsterdam date) [ci skip]"

echo "Pushing changes to upstream master"
git push upstream master