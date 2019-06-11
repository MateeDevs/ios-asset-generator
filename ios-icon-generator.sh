
#!/bin/bash
#
# Copyright (C) 2014 Wenva <lvyexuwenfa100@126.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is furnished
# to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

set -e

SRC_FILE="$1"
DST_PATH="$2"

VERSION=1.0.0

info() {
     local green="\033[1;32m"
     local normal="\033[0m"
     echo -e "[${green}INFO${normal}] $1"
}

error() {
     local red="\033[1;31m"
     local normal="\033[0m"
     echo -e "[${red}ERROR${normal}] $1"
}

usage() {
cat << EOF
VERSION: $VERSION
USAGE:
    $0 srcfile dstpath

DESCRIPTION:
    Generates AppIcon in all necessary sizes.

    srcfile - The source png image.
    dstpath - The output folder.

    This script use ImageMagick and pngquant.
    You can use 'brew install ImageMagick' to install ImageMagick
    You can use 'brew install pngquant' to install pngquant

AUTHOR:
    Pawpaw<lvyexuwenfa100@126.com>

MODIFIED_BY:
    pchmelar<info@pchmelar.cz>

LICENSE:
    This script follow MIT license.

EXAMPLE:
    $0 1024.png ~/123
EOF
}

# Check ImageMagick and pngquant
command -v convert >/dev/null 2>&1 || { error >&2 "The ImageMagick is not installed. Please use brew to install it first."; exit -1; }
command -v pngquant >/dev/null 2>&1 || { error >&2 "The pngquant is not installed. Please use brew to install it first."; exit -1; }

# Check param
if [ $# != 2 ];then
    usage
    exit -1
fi

# Check whether dst path exist.
if [ ! -d "$DST_PATH" ];then
    mkdir -p "$DST_PATH"
fi

# Generate
info 'Generate icon_ipad@1x.png ...'
convert "$SRC_FILE" -resize 76x76 "$DST_PATH/icon_ipad@1x.png"
info 'Generate icon_ipad@2x.png ...'
convert "$SRC_FILE" -resize 152x152 "$DST_PATH/icon_ipad@2x.png"
info 'Generate icon_ipad_pro@2x.png ...'
convert "$SRC_FILE" -resize 167x167 "$DST_PATH/icon_ipad_pro@2x.png"
info 'Generate icon_settings_ipad@1x.png ...'
convert "$SRC_FILE" -resize 29x29 "$DST_PATH/icon_settings_ipad@1x.png"
info 'Generate icon_settings_ipad@2x.png ...'
convert "$SRC_FILE" -resize 58x58 "$DST_PATH/icon_settings_ipad@2x.png"
info 'Generate icon_settings@2x.png ...'
convert "$SRC_FILE" -resize 58x58 "$DST_PATH/icon_settings@2x.png"
info 'Generate icon_settings@3x.png ...'
convert "$SRC_FILE" -resize 87x87 "$DST_PATH/icon_settings@3x.png"
info 'Generate icon_spotlight_ipad@1x.png ...'
convert "$SRC_FILE" -resize 40x40 "$DST_PATH/icon_spotlight_ipad@1x.png"
info 'Generate icon_spotlight_ipad@2x.png ...'
convert "$SRC_FILE" -resize 80x80 "$DST_PATH/icon_spotlight_ipad@2x.png"
info 'Generate icon_spotlight@2x.png ...'
convert "$SRC_FILE" -resize 80x80 "$DST_PATH/icon_spotlight@2x.png"
info 'Generate icon_spotlight@3x.png ...'
convert "$SRC_FILE" -resize 120x120 "$DST_PATH/icon_spotlight@3x.png"
info 'Generate icon_notification_iphone@2x.png ...'
convert "$SRC_FILE" -resize 40x40 "$DST_PATH/icon_notification_iphone@2x.png"
info 'Generate icon_notification_iphone@3x.png ...'
convert "$SRC_FILE" -resize 60x60 "$DST_PATH/icon_notification_iphone@3x.png"
info 'Generate icon_notification_ipad@1x.png ...'
convert "$SRC_FILE" -resize 20x20 "$DST_PATH/icon_notification_ipad@1x.png"
info 'Generate icon_notification_ipad@2x.png ...'
convert "$SRC_FILE" -resize 40x40 "$DST_PATH/icon_notification_ipad@2x.png"
info 'Generate icon@2x.png ...'
convert "$SRC_FILE" -resize 120x120 "$DST_PATH/icon@2x.png"
info 'Generate icon@3x.png ...'
convert "$SRC_FILE" -resize 180x180 "$DST_PATH/icon@3x.png"
info 'Generate icon_appstore.png ...'
convert "$SRC_FILE" -resize 1024x1024 "$DST_PATH/icon_appstore.png"
info 'Generate done.'

# Compress
info 'Compress icon_ipad@1x.png ...'
pngquant "$DST_PATH/icon_ipad@1x.png"
mv "$DST_PATH/icon_ipad@1x-fs8.png" "$DST_PATH/icon_ipad@1x.png"
info 'Compress icon_ipad@2x.png ...'
pngquant "$DST_PATH/icon_ipad@2x.png"
mv "$DST_PATH/icon_ipad@2x-fs8.png" "$DST_PATH/icon_ipad@2x.png"
info 'Compress icon_ipad_pro@2x.png ...'
pngquant "$DST_PATH/icon_ipad_pro@2x.png"
mv "$DST_PATH/icon_ipad_pro@2x-fs8.png" "$DST_PATH/icon_ipad_pro@2x.png"
info 'Compress icon_settings_ipad@1x.png ...'
pngquant "$DST_PATH/icon_settings_ipad@1x.png"
mv "$DST_PATH/icon_settings_ipad@1x-fs8.png" "$DST_PATH/icon_settings_ipad@1x.png"
info 'Compress icon_settings_ipad@2x.png ...'
pngquant "$DST_PATH/icon_settings_ipad@2x.png"
mv "$DST_PATH/icon_settings_ipad@2x-fs8.png" "$DST_PATH/icon_settings_ipad@2x.png"
info 'Compress icon_settings@2x.png ...'
pngquant "$DST_PATH/icon_settings@2x.png"
mv "$DST_PATH/icon_settings@2x-fs8.png" "$DST_PATH/icon_settings@2x.png"
info 'Compress icon_settings@3x.png ...'
pngquant "$DST_PATH/icon_settings@3x.png"
mv "$DST_PATH/icon_settings@3x-fs8.png" "$DST_PATH/icon_settings@3x.png"
info 'Compress icon_spotlight_ipad@1x.png ...'
pngquant "$DST_PATH/icon_spotlight_ipad@1x.png"
mv "$DST_PATH/icon_spotlight_ipad@1x-fs8.png" "$DST_PATH/icon_spotlight_ipad@1x.png"
info 'Compress icon_spotlight_ipad@2x.png ...'
pngquant "$DST_PATH/icon_spotlight_ipad@2x.png"
mv "$DST_PATH/icon_spotlight_ipad@2x-fs8.png" "$DST_PATH/icon_spotlight_ipad@2x.png"
info 'Compress icon_spotlight@2x.png ...'
pngquant "$DST_PATH/icon_spotlight@2x.png"
mv "$DST_PATH/icon_spotlight@2x-fs8.png" "$DST_PATH/icon_spotlight@2x.png"
info 'Compress icon_spotlight@3x.png ...'
pngquant "$DST_PATH/icon_spotlight@3x.png"
mv "$DST_PATH/icon_spotlight@3x-fs8.png" "$DST_PATH/icon_spotlight@3x.png"
info 'Compress icon_notification_iphone@2x.png ...'
pngquant "$DST_PATH/icon_notification_iphone@2x.png"
mv "$DST_PATH/icon_notification_iphone@2x-fs8.png" "$DST_PATH/icon_notification_iphone@2x.png"
info 'Compress icon_notification_iphone@3x.png ...'
pngquant "$DST_PATH/icon_notification_iphone@3x.png"
mv "$DST_PATH/icon_notification_iphone@3x-fs8.png" "$DST_PATH/icon_notification_iphone@3x.png"
info 'Compress icon_notification_ipad@1x.png ...'
pngquant "$DST_PATH/icon_notification_ipad@1x.png"
mv "$DST_PATH/icon_notification_ipad@1x-fs8.png" "$DST_PATH/icon_notification_ipad@1x.png"
info 'Compress icon_notification_ipad@2x.png ...'
pngquant "$DST_PATH/icon_notification_ipad@2x.png"
mv "$DST_PATH/icon_notification_ipad@2x-fs8.png" "$DST_PATH/icon_notification_ipad@2x.png"
info 'Compress icon@2x.png ...'
pngquant "$DST_PATH/icon@2x.png"
mv "$DST_PATH/icon@2x-fs8.png" "$DST_PATH/icon@2x.png"
info 'Compress icon@3x.png ...'
pngquant "$DST_PATH/icon@3x.png"
mv "$DST_PATH/icon@3x-fs8.png" "$DST_PATH/icon@3x.png"
info 'Compress icon_appstore.png ...'
pngquant "$DST_PATH/icon_appstore.png"
mv "$DST_PATH/icon_appstore-fs8.png" "$DST_PATH/icon_appstore.png"
info 'Compress done.'
