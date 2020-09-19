#!/bin/bash
set -e

# apply patches
(cd browser && git am --ignore-space-change --ignore-whitespace ../patches/*)
# copy assets into browser tree
rsync -av ./assets/ ./browser/