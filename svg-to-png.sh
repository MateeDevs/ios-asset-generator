#!/bin/bash

directory="./input/*"

size="$1"

count=$(find $directory -maxdepth 0 | wc -l)
j=1

for f in $directory
do
	filename=`basename $f .svg`
  	echo "[$j / $((count))] Converting $filename"

  	mkdir ./output/$filename.imageset

  	convert -density 1200 -resize $(($size))x$(($size)) -background none -gravity center -extent $(($size))x$(($size)) ./input/$filename.svg ./output/$filename.imageset/$filename@1x.png
  	pngquant ./output/$filename.imageset/$filename@1x.png
	mv ./output/$filename.imageset/$filename@1x-fs8.png ./output/$filename.imageset/$filename@1x.png

	convert -density 1200 -resize $(($size*2))x$(($size*2)) -background none -gravity center -extent $(($size*2))x$(($size*2)) ./input/$filename.svg ./output/$filename.imageset/$filename@2x.png
  	pngquant ./output/$filename.imageset/$filename@2x.png
	mv ./output/$filename.imageset/$filename@2x-fs8.png ./output/$filename.imageset/$filename@2x.png

	convert -density 1200 -resize $(($size*3))x$(($size*3)) -background none -gravity center -extent $(($size*3))x$(($size*3)) ./input/$filename.svg ./output/$filename.imageset/$filename@3x.png
  	pngquant ./output/$filename.imageset/$filename@3x.png
	mv ./output/$filename.imageset/$filename@3x-fs8.png ./output/$filename.imageset/$filename@3x.png

	touch ./output/$filename.imageset/Contents.json
	echo "{
	\"images\" : [
		{
			\"idiom\" : \"universal\",
			\"filename\" : \"$filename@1x.png\",
			\"scale\" : \"1x\"
		},
		{
			\"idiom\" : \"universal\",
			\"filename\" : \"$filename@2x.png\",
			\"scale\" : \"2x\"
		},
		{
			\"idiom\" : \"universal\",
			\"filename\" : \"$filename@3x.png\",
			\"scale\" : \"3x\"
		}
	],
	\"info\" : {
		\"version\" : 1,
		\"author\" : \"xcode\"
	}
}" > ./output/$filename.imageset/Contents.json

  ((j++))
done
