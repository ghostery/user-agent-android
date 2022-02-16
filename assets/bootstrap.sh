#!/bin/bash
set -x
set -e
EXT_DIR="app/src/main/assets/extensions/ghostery"
DOWNLOAD_URL="https://github.com/ghostery/ghostery-extension/releases/download/v8.6.2/ghostery-dawn-v8.6.2.zip"
mkdir -p "$EXT_DIR"
curl -L -o ghostery.zip "$DOWNLOAD_URL"
unzip -o ghostery.zip -d "$EXT_DIR"
rm ghostery.zip
