#!/bin/bash
set -e

source ./config.sh

./reset.sh

cd browser

# remove translations
for LANG in 'an' 'ar' 'ast' 'az' 'be' 'bg' 'bn' 'br' 'bs' 'ca' 'cak' 'co' 'cs' 'cy' 'da' 'dsb' 'el' 'en-rCA' 'en-rGB' 'eo' 'es-rAR' 'es-rCL' 'es-rES' 'es-rMX' 'et' 'eu' 'fa' 'ff' 'fi' 'fy-rNL' 'ga-rIE' 'gd' 'gn' 'gu-rIN' 'hi-rIN' 'hr' 'hsb' 'hy-rAM' 'in' 'is' 'iw' 'ka' 'kab' 'kk' 'kn' 'lij' 'lo' 'lt' 'ml' 'mr' 'my' 'nb-rNO' 'nn-rNO' 'oc' 'pa-rIN' 'pt-rPT' 'rm' 'ro' 'sk' 'sl' 'sq' 'sr' 'su' 'sv-rSE' 'ta' 'te' 'th' 'tr' 'trs' 'uk' 'ur' 'uz' 'vec' 'vi'
do
  git rm -r app/src/main/res/values-$LANG
done
git commit -m "Remove unsupported translations"

# copy assets into browser tree
rsync -av ../assets/ ../browser/
git add . && git commit -a -m "Copy static assets"

# Install Ghostery Browser Extension
./bootstrap.sh

git tag -f $FENIX_TAG-start
# apply patches
git am --ignore-space-change --ignore-whitespace ../patches/*
