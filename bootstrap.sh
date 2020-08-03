#!/bin/bash
TAG="v8.5.2-3"
EXT_DIR="app/src/main/assets/extensions/ghostery"
DOWNLOAD_URL="https://cdncliqz.s3.amazonaws.com/update/fostery/ghostery-firefox-$TAG.zip"
mkdir -p "$EXT_DIR"
curl -L -o ghostery.zip "$DOWNLOAD_URL"
unzip ghostery.zip -d "$EXT_DIR"
rm ghostery.zip
