#!/bin/sh

# Wait to prevent Git conflicts between jobs
DELAY=$(echo $TRAVIS_JOB_NUMBER | awk -F '.' '{print $NF}')
DELAY=$(($DELAY - 1))
DELAY=$(($DELAY * 2 * 60))
if [ $DELAY -gt "0" ]; then
    echo "Waiting $DELAY seconds before deploying"
    sleep $DELAY
fi

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
if [ $DELAY -eq "0" ]; then
    git add ./libvlc/src/main/java/*
    git add ./libvlc/src/main/res/*
    git commit -m "libVLC v$LIBVLC_VERSION" -m "[ci skip]"
fi
git add ./libvlc/src/main/jniLibs/*
git commit -m "libVLC v$LIBVLC_VERSION ($ARCH)" -m "[ci skip]"

# Upload files
echo "Pushing commits"
git remote add origin-master https://$GH_TOKEN@github.com/$TRAVIS_REPO_SLUG.git > /dev/null 2>&1
git push --set-upstream origin-master master
