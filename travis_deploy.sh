#!/bin/sh

# Configure Git
git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"

# Pull remote changes
echo "Stashing changes"
git stash
echo "Pulling latest commits"
git checkout master
git pull origin master
echo "Restoring stashed changes"
git stash pop

# Commit latest libVLC files
echo "Committing changes"
cd ./libvlc
git add . --all
cd ..
git commit -m "libVLC v$LIBVLC_VERSION" -m "[ci skip]"

# Upload files
echo "Pushing commits"
git remote add origin-master https://$GH_TOKEN@github.com/$TRAVIS_REPO_SLUG.git > /dev/null 2>&1
git push --set-upstream origin-master master
