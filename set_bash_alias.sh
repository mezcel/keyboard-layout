#!/bin/bash

## Decorative tty colors
function Tput_Colors {
    ## Foreground Color using ANSI escape

    FG_BLACK=$(tput setaf 0)
    FG_RED=$(tput setaf 1)
    FG_GREEN=$(tput setaf 2)
    FG_YELLOW=$(tput setaf 3)
    FG_BLUE=$(tput setaf 4)
    FG_MAGENTA=$(tput setaf 5)
    FG_CYAN=$(tput setaf 6)
    FG_WHITE=$(tput setaf 7)
    FG_NoColor=$(tput sgr0)

    ## Background Color using ANSI escape

    BG_BLACK=$(tput setab 0)
    BG_RED=$(tput setab 1)
    BG_GREEN=$(tput setab 2)
    BG_YELLOW=$(tput setab 3)
    BG_BLUE=$(tput setab 4)
    BG_MAGENTA=$(tput setab 5)
    BG_CYAN=$(tput setab 6)
    BG_WHITE=$(tput setab 7)
    BG_NoColor=$(tput sgr0)

    ## set mode using ANSI escape

    MODE_BOLD=$(tput bold)
    MODE_DIM=$(tput dim)
    MODE_BEGIN_UNDERLINE=$(tput smul)
    MODE_EXIT_UNDERLINE=$(tput rmul)
    MODE_REVERSE=$(tput rev)
    MODE_ENTER_STANDOUT=$(tput smso)
    MODE_EXIT_STANDOUT=$(tput rmso)

    # clear styles using ANSI escape

    STYLES_OFF=$(tput sgr0)
    FGBG_NoColor=$(tput sgr0)
}

## make an alias variable in ~/.bashrc to launch keyboard-layout.sh
function make_bashrc_alias {
    aliasVar=$1
    bashFile=$2
    bashFilePath=$(pwd)/$bashFile

    echo -e "$FG_CYAN \
    \n## ################################################################## \
    \n## Making an alias variable in ~/.bashrc to launch keyboard-layout.sh \
    \n## the alias is \"kbd\" \
    \n## ################################################################## \
    \n $STYLES_OFF"

    ## make bash executable
    chmod +x $bashFilePath

    origianlBashrc=~/.bashrc
    backupBashrc=$origianlBashrc.backup_$(date +%d%b%Y%H%S)
    tempBashrc=$origianlBashrc.temp

    ## make a safety backup of ~/.bashrc
    cp $origianlBashrc $backupBashrc
    cp $origianlBashrc $tempBashrc

    ## Make a temporary .bashrc file to edit
    ## Delete previous line reference to bash file
    sed -i "/$bashFile/d" $tempBashrc
    sleep 1s

    aliasautoString="\
    \n## Alias for $bashFilePath \
    \nalias $aliasVar=\"bash $bashFilePath\" \
    \n"

    ## Append ~/.bashrc with alias and it's auto complete argv
    echo -e "$aliasautoString" >> $tempBashrc

    ## Make the temp file the ~/.bashrc file
    mv $tempBashrc $origianlBashrc
    sleep 2s

    ## apply the new ~/.bashrc
    source $origianlBashrc

    echo -e "${FG_YELLOW}Done.\n ${STYLES_OFF} Restrting Bash in 3 seconds ..."

    sleep 3s

    reset

    echo -e "${FG_GREEN}\nThe bash alias \"kbd\" was added to ~/.bashrc\n\tType \"kbd\" to launch the keyboard-layout.sh script.\n${STYLES_OFF}\n"
}

function main {
    Tput_Colors
    aliasVar=kbd
    bashFile=keyboard-layout.sh

    make_bashrc_alias $aliasVar $bashFile
}

## RUN
main
