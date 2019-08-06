#!/bin/sh

# Configure Git
git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"

# Pull remote changes
git status # TODO
git stash
git checkout master
git pull origin master
git stash pop

# Commit latest libVLC files
git status # TODO
cd ./libvlc
git add . --all
cd ..
git status # TODO
git commit --message "libVLC v$LIBVLC_VERSION"
git status # TODO

# Upload files
git remote add origin-master https://$GH_TOKEN@github.com/$TRAVIS_REPO_SLUG.git > /dev/null 2>&1
git push --set-upstream origin-master master
