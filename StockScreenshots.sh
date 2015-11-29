#!/bin/bash

#--------------------------------------------------------------
# note: apple/ilife sound effects are under this folder:
#       /Library/Audio/Apple\ Loops/Apple/iLife\ Sound\ Effects
#--------------------------------------------------------------

function print_usage {
    echo ""
    echo "    Usage: StockScreenshots.sh -d dataFilename -o outputFilename -c croppingString -s soundFilename"
    echo "    Ex:    ./StockScreenshots.sh -d aa.dat -o aa.pdf -c 1300x1053+300+23 -s west_precinct_short.caf"
    echo ""
    echo "           croppingString format: 1088x624+470+318 works well for yahoo finance (just the graph)"
    echo "                                  1300x1053+300+23 works well for the full browser"
    echo ""
    echo "           The sound file is optional. If supplied, the sound will be played and then the script"
    echo "           will sleep for 30 seconds before starting. This is intended as a 'warning' in case"
    echo "           you have automated the starting of this script (like a crontab entry). If you hear"
    echo "           this sound while using the computer, you will then have 30 seconds before the script"
    echo "           starts."
    echo ""
}

# get the command line args
while getopts c:d:s:o: option
do
    case "$option" in
    c)
         CROPPING_STRING=$OPTARG
         ;;
    d)
         DATA_FILE=$OPTARG
         ;;
    o)
         OUTPUT_FILE=$OPTARG
         ;;
    s)
         SOUND_FILE=$OPTARG
         ;;
        esac
done


# exit if any required args are missing
if [ -z "$CROPPING_STRING" ] || [ -z "$DATA_FILE" ] || [ -z "$OUTPUT_FILE" ]
then
    print_usage
    exit 1
fi


# if sound file is given, play a sound file and then wait
if [ ! -z $SOUND_FILE ]
then
    afplay $SOUND_FILE
    sleep 30
fi


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



