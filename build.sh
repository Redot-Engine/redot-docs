#!/bin/bash

DATE=`date`
REPORT_DIR="build-report"
REPORT_FILE="$REPORT_DIR/index.html"

GIT_BRANCH=`git rev-parse --abbrev-ref HEAD`
if [ $CF_PAGES -gt 0 ]
then
    echo "We are on pages"
    GIT_BRANCH=$CF_PAGES_BRANCH
fi
GIT_COMMIT_MESSAGE="branch $GIT_BRANCH on $DATE"
GIT_LIVE_BRANCH=${2:-develop}

INPUT_DIR="."
MIGRATE_DIR="_migrated"
SPHINX_DIR="_sphinx"
REPO_DIR="_repo"

LIVE_ROOT="redot-docs-live"
LIVE_REPO="https://github.com/Redot-Engine/$LIVE_ROOT.git"
BUILD_DIR="html/en/$GIT_BRANCH"

mkdir -p $REPORT_DIR
rm $REPORT_FILE
echo "reporting to $REPORT_FILE" 2>&1 | tee -a $REPORT_FILE
echo "Building $GIT_COMMIT_MESSAGE" 2>&1 | tee -a $REPORT_FILE
echo "Live branch: $GIT_LIVE_BRANCH" 2>&1 | tee -a $REPORT_FILE
echo "Temp dirs: $MIGRATE_DIR, $SPHINX_DIR, $REPO_DIR" 2>&1 | tee -a $REPORT_FILE
echo "Live root: $LIVE_ROOT, live repo: $LIVE_REPO, build dir: $BUILD_DIR, report dir: $REPORT_DIR" 2>&1 | tee -a $REPORT_FILE

echo "Delete temps" 2>&1 | tee -a $REPORT_FILE
rm -rf $MIGRATE_DIR 2>&1 | tee -a $REPORT_FILE
rm -rf $SPHINX_DIR 2>&1 | tee -a $REPORT_FILE
rm -rf $REPO_DIR 2>&1 | tee -a $REPORT_FILE

echo "Migrate Godot to Redot, options $1" 2>&1 | tee -a $REPORT_FILE
mkdir -p $MIGRATE_DIR
python migrate.py $1 $INPUT_DIR $MIGRATE_DIR 2>&1 | tee -a $REPORT_FILE

echo "Translate to html"
mkdir -p $SPHINX_DIR
sphinx-build -b html -j 4 $MIGRATE_DIR $SPHINX_DIR 2>&1 | tee -a $REPORT_FILE

echo "Cloning $LIVE_REPO $REPO_DIR"
git clone $LIVE_REPO $REPO_DIR 2>&1 | tee -a $REPORT_FILE

echo "Checking out $GIT_LIVE_BRANCH"
cd $REPO_DIR
git checkout $GIT_LIVE_BRANCH 2>&1 | tee -a ../$REPORT_FILE
echo "mkdir -p $BUILD_DIR"
mkdir -p $BUILD_DIR
echo "cp -r ../$SPHINX_DIR/* $BUILD_DIR" 2>&1 | tee -a ../$REPORT_FILE
cp -r ../$SPHINX_DIR/* $BUILD_DIR 2>&1 | tee -a ../$REPORT_FILE

echo "Commit and push to $GIT_REMOTE_BRANCH, with message $GIT_COMMIT_MESSAGE" 2>&1 | tee -a ../$REPORT_FILE
git add . 2>&1 | tee -a ../$REPORT_FILE

git commit -m "$GIT_COMMIT_MESSAGE" 2>&1 | tee -a ../$REPORT_FILE
git push -f 2>&1 | tee -a ../$REPORT_FILE

echo "Done. Made by @Craptain" 2>&1 | tee -a ../$REPORT_FILE
