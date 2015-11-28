#!/bin/bash

# script expects three command-line args
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]
then
    echo ""
    echo "    Usage: StockScreenshots.sh dataFilename outputPdfFilename croppingString"
    echo "    Ex:    StockScreenshots.sh aa.dat aa.pdf 1300x1053+300+23"
    echo ""
    echo "           croppingString format: 1088x624+470+318 works well for yahoo finance (just the graph)"
    echo "                                  1300x1053+300+23 works well for the full browser"
    echo ""
    exit -1
fi
DATA_FILE=$1
OUTPUT_FILE=$2
CROPPING_STRING=$3

source $DATA_FILE

rm *.jpg 2> /dev/null


./MoveMouse.sh 20 20
sleep 1


# note: script expects safari to have a certain size, and no tabs open
./OpenSafariAndSizeIt.sh
sleep 2
./CloseSafariWindow.sh
sleep 1


counter=0
for url in $URLS
do
    let counter=counter+1
    # this `if` statement may not be needed
    if [ ! -z $url ]
    then
        open $url                                 # in safari
        sleep 12
        screencapture -m -t jpg $counter.jpg      # create a jpg
        sleep 4
        ./CloseSafariWindow.sh
        sleep 2
    fi
done


osascript -e 'quit app "Safari"'
sleep 4


echo "cropping the images ..."
for i in `ls *.jpg`
do
    mogrify -crop $CROPPING_STRING $i             # corresponds to the size in OpenSafariAndSizeIt.sh
                                                  # "1088x624+470+318" for yahoo finance
done
sleep 1


#echo "making the images smaller ..."
#mogrify -resize 80% *jpg


echo "Creating PDF ..."
convert -quality 80 *.jpg $OUTPUT_FILE     # create a pdf from all jpg images


echo "Opening PDF ..."
open $OUTPUT_FILE



