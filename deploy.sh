#!/bin/bash

set -o errexit -o nounset

if [ "$TRAVIS_BRANCH" != "master" ]
then
  echo "This commit was made against the $TRAVIS_BRANCH and not the master! No deploy!"
  exit 0
fi

rev=$(git rev-parse --short HEAD)

cd _book

git init
git config user.name "kangweng"
git config user.email "45530841+kangweng@users.noreply.github.com"

git remote add upstream "https://$GH_TOKEN@github.com/kangweng/kangweng.github.io.git"
git fetch upstream && git reset upstream/master

# echo "example.com" > CNAME

touch .

git add -A .
git commit -m "rebuild pages at ${rev}"
git push -q upstream HEAD:master
