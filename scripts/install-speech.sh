#!/bin/bash

sudo apt install wget espeak

#sudo apt install mbrola

sudo mkdir -p /usr/share/mbrola/

wget "https://web.archive.org/web/20180627172600/http://www.tcts.fpms.ac.be/synthesis/mbrola/bin/pclinux/mbr301h.zip" -O ~/Downloads/
wget "https://web.archive.org/web/20160706052143/http://www.tcts.fpms.ac.be/synthesis/mbrola/dba/en1/en1-980910.zip" -O ~/Downloads/

unzip ~/Downloads/mbr301h.zip
sudo cp ~/Downloads/mbrola-linux-i386 /usr/bin/mbrola

unzip ~/Downloads/en1-980910.zip
cp ~/Downloads/en1/en1 /usr/share/mbrola/en1
