#!/bin/bash
set -x
set -e

EXT_DIR="app/src/main/assets/extensions/ghostery"
DOWNLOAD_URL="https://s3.amazonaws.com/ghostery-deployments/ghostery-extension/8.8.1.5afb6f4c/ghostery-dawn-v8.8.1.5afb6f4c.xpi"
rm -rf "$EXT_DIR"
mkdir -p "$EXT_DIR"
curl -L -o ghostery.zip "$DOWNLOAD_URL"
unzip -o ghostery.zip -d "$EXT_DIR"
rm ghostery.zip

SEARCH_EXT_DIR="app/src/main/assets/extensions/ghostery-search"
SEARCH_DOWNLOAD_URL="https://github.com/ghostery/ghostery-search-extension/releases/download/v1.0.2/ghostery_glow-1.0.2.zip"
rm -rf "$SEARCH_EXT_DIR"
mkdir -p "$SEARCH_EXT_DIR"
curl -L -o ghostery_search.zip "$SEARCH_DOWNLOAD_URL"
unzip -o ghostery_search.zip -d "$SEARCH_EXT_DIR"
rm ghostery_search.zip

echo "/app/src/main/assets/extensions/ghostery-search" >> .gitignore
echo "/app/src/main/assets/extensions/ghostery" >> .gitignore