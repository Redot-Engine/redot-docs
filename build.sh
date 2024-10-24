#!/bin/bash

INPUT_DIR="."
MIGRATE_DIR="_migrated"
SPHINX_DIR="_sphinx"

BUILD_ROOT="redot-docs-build"
BUILD_DIR="$BUILD_ROOT/en/master"

touch test.txt 
echo 'hello' >> test.txt 

mkdir -p $MIGRATE_DIR
python migrate.py --tiny $INPUT_DIR $MIGRATE_DIR
mkdir -p $SPHINX_DIR
sphinx-build -b html -j 4 $MIGRATE_DIR $SPHINX_DIR

git clone git@github.com:Redot-Engine/$BUILD_ROOT.git

echo "mkdir -p $BUILD_DIR"
mkdir -p $BUILD_DIR
echo "cp -r $SPHINX_DIR/* $BUILD_DIR"
cp -r $SPHINX_DIR/* $BUILD_DIR

cp test.txt $BUILD_DIR
cp test.txt $BUILD_DIR/index.html 

cd $BUILD_DIR
ls -la
git push -f
