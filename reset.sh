#!/bin/bash
set -e

source ./config.sh

cd browser

git checkout $FENIX_TAG
# create a workspace branch to work with
git checkout -B workspace

cd ..