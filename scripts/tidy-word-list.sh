#!/bin/sh

thisPath=$(dirname $0)

sort -o $thisPath/computerWords.txt $thisPath/computerWords.txt
sort -o $thisPath/wordsArray.txt $thisPath/wordsArray.txt
sort -o $thisPath/leftWords.txt $thisPath/leftWords.txt
sort -o $thisPath/rightWords.txt $thisPath/rightWords.txt

echo "done."