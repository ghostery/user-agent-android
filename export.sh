#!/bin/bash
source ./config.sh
rm patches/*
cd browser
git format-patch $FENIX_TAG-start --minimal --no-numbered --keep-subject --output-directory ../patches/
