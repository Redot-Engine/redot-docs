#!/bin/bash

GIT_BRANCH=`git rev-parse --abbrev-ref HEAD`
DATE=`date`
GIT_COMMIT_MESSAGE="branch $GIT_BRANCH on $DATE"
GIT_LIVE_BRANCH=${2:-develop}
echo "Building $GIT_COMMIT_MESSAGE"
echo "Live branch: $GIT_LIVE_BRANCH"

INPUT_DIR="."
MIGRATE_DIR="_migrated"
SPHINX_DIR="_sphinx"
REPO_DIR="_repo"
echo "Temp dirs: $MIGRATE_DIR, $SPHINX_DIR, $REPO_DIR"

LIVE_ROOT="redot-docs-live"
LIVE_REPO="git@github.com:Redot-Engine/$LIVE_ROOT.git"
BUILD_DIR="html/en/$GIT_BRANCH"

echo "Live root: $LIVE_ROOT, live repo: $LIVE_REPO, build dir: $BUILD_DIR"

echo "Migrate Godot to Redot, options $1"
mkdir -p $MIGRATE_DIR
python migrate.py $1 $INPUT_DIR $MIGRATE_DIR

echo "Translate to html"
mkdir -p $SPHINX_DIR
sphinx-build -b html -j 4 $MIGRATE_DIR $SPHINX_DIR

echo "Cloning $LIVE_REPO $REPO_DIR"
git clone $LIVE_REPO $REPO_DIR

echo "Checking out $GIT_LIVE_BRANCH"
cd $REPO_DIR
git checkout $GIT_LIVE_BRANCH
echo "mkdir -p $BUILD_DIR"
mkdir -p $BUILD_DIR
echo "cp -r ../$SPHINX_DIR/* $BUILD_DIR"
cp -r ../$SPHINX_DIR/* $BUILD_DIR

echo "Commit and push to $GIT_REMOTE_BRANCH, with message $GIT_COMMIT_MESSAGE"
git add .
git commit -m "$GIT_COMMIT_MESSAGE"
git push -f

echo "Delete temps"
rm -rf $MIGRATE_DIR
rm -rf $SPHINX_DIR
rm -rf $REPO_DIR

echo "Done. Made by @Craptain"
