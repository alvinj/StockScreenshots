#!/bin/bash

URLS="
http://finance.yahoo.com/echarts?s=AFL+Interactive%23%7B%2522range%2522:%25226mo%2522,%2522allowChartStacking%2522:true%7D#{"range":"5y","allowChartStacking":true}
http://finance.yahoo.com/echarts?s=F+Interactive%23%7B%2522range%2522:%25226mo%2522,%2522allowChartStacking%2522:true%7D#{"range":"5y","allowChartStacking":true}
http://finance.yahoo.com/echarts?s=GWW+Interactive%23%7B%2522range%2522:%25226mo%2522,%2522allowChartStacking%2522:true%7D#{"range":"5y","allowChartStacking":true}
"

OUTPUT_FILE=stock_screenshots.pdf

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
    mogrify -crop 1088x624+470+318 $i             # corresponds to the size in OpenSafariAndSizeIt.sh
done
sleep 1


#echo "making the images smaller ..."
#mogrify -resize 80% *jpg


echo "Creating PDF ..."
convert -quality 80 *.jpg $OUTPUT_FILE     # create a pdf from all jpg images


echo "Opening PDF ..."
open $OUTPUT_FILE



