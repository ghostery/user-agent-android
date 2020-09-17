#!/bin/bash
cd browser
git format-patch v79.0.5 --minimal --no-numbered --keep-subject --output-directory ../patches/
