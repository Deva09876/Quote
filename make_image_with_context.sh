#!/bin/bash

# ./make_image.sh "quote" "name" "context" "profile.jpg" "result.jpg"

set -e

QUOTE=`python3 wordwrap.py "$1"`
NAME=$2
CONTEXT=$3
PROFILE=$4
RESULT=$5

echo `date`

convert \
  -background black \
  -fill white \
  -pointsize 80 \
  -bordercolor Black \
  -border 30x10 \
  -style Italic \
  pango:"<span font=\"Twitter-Color-Emoji-SVGinOT\"><i>\“$QUOTE\”</i></span>" \
  "${RESULT}-quote.png"

convert \
  -background black \
  -fill white \
  -pointsize 40 \
  -bordercolor Black \
  -border 30x10 \
  label:"$NAME" \
  "${RESULT}-name.png"


convert \
  -background black \
  -fill white \
  -pointsize 40 \
  -bordercolor Black \
  -border 30x10 \
  label:"$CONTEXT" \
  "${RESULT}-context.png"

convert \
  -background black \
   xc:none \
  "${RESULT}-quote.png" -append \
  "${RESULT}-name.png" \
  -gravity SouthEast \
  -append \
  +repage \
  -bordercolor Black \
  -border 20x20 \
  "${RESULT}-namequote.png"

  convert \
  -background black \
   xc:none \
  "${RESULT}-namequote.png" -append \
  "${RESULT}-context.png" \
  -gravity SouthWest \
  -append \
  +repage \
  -bordercolor Black \
  -border 20x20 \
  "${RESULT}-namequotecontext.png"


convert \
  "$PROFILE" \
  -colorspace Gray \
  "$PROFILE-black.png"

convert \
  -background black \
   xc:none \
  "${RESULT}-namequotecontext.png" -append \
   "$PROFILE-black.png" \
  -gravity center \
  +append \
  +repage \
  -bordercolor Black \
  -border 20x20 \
  "$RESULT"

rm "${RESULT}-quote.png"
rm "${RESULT}-name.png"
rm "${RESULT}-namequote.png"
rm "${RESULT}-context.png"
rm "${RESULT}-namequotecontext.png"
rm "${PROFILE}-black.png"