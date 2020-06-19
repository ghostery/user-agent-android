#!/bin/bash

TAG=v8.5.1
EXT_DIR=app/src/main/assets/extensions/ghostery
mkdir -p $EXT_DIR
curl -L -o ghostery.zip https://github.com/ghostery/ghostery-extension/releases/download/$TAG/ghostery-firefox-$TAG.zip
unzip ghostery.zip -d $EXT_DIR
rm ghostery.zip
