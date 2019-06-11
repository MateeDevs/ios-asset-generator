
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
    Generates LaunchImage in all necessary sizes.

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
info 'Generate default960.png ...'
convert "$SRC_FILE" -resize 640x960\! "$DST_PATH/default960.png"
info 'Generate default1136.png ...'
convert "$SRC_FILE" -resize 640x1136\! "$DST_PATH/default1136.png"
info 'Generate default1334.png ...'
convert "$SRC_FILE" -resize 750x1334\! "$DST_PATH/default1334.png"
info 'Generate default2208.png ...'
convert "$SRC_FILE" -resize 1242x2208\! "$DST_PATH/default2208.png"
info 'Generate done.'

# Compress
info 'Compress default960.png ...'
pngquant "$DST_PATH/default960.png"
mv "$DST_PATH/default960-fs8.png" "$DST_PATH/default960.png"
info 'Compress default1136.png ...'
pngquant "$DST_PATH/default1136.png"
mv "$DST_PATH/default1136-fs8.png" "$DST_PATH/default1136.png"
info 'Compress default1334.png ...'
pngquant "$DST_PATH/default1334.png"
mv "$DST_PATH/default1334-fs8.png" "$DST_PATH/default1334.png"
info 'Compress default2208.png ...'
pngquant "$DST_PATH/default2208.png"
mv "$DST_PATH/default2208-fs8.png" "$DST_PATH/default2208.png"
info 'Compress done.'
