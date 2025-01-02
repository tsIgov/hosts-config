#!/usr/bin/env sh

REPO_DIR=$(dirname $(realpath "$0"))
cd $REPO_DIR

BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

git rm -rf .
git-crypt init -k $BRANCH_NAME
age -e -p -o key .git/git-crypt/keys/$BRANCH_NAME
echo "src/** filter=git-crypt-$BRANCH_NAME diff=git-crypt-$BRANCH_NAME" >> .gitattributes
mkdir src

git add key
git add .gitattributes
git commit -m "Initial commit"