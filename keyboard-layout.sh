#!/bin/bash

## this script is used to help my muscle memmory for the keyboard
## Keyboards come in many sizes and shapes, and some keyboards are ergonomic.
## This is just a script to get my fingers used to moveing correctly where ever the letter keys are on the keyboard.

thisPath=$(dirname $0)

function tput_color_variables {
    FG_RED=$(tput setaf 1)
    FG_GREEN=$(tput setaf 2)
    FG_YELLOW=$(tput setaf 3)
    FG_BLUE=$(tput setaf 4)
    FG_MAGENTA=$(tput setaf 5)
    #FG_CYAN=$(tput setaf 6)    ## the string to type
    FG_CYAN=$(tput sgr0)        ## no custom color

    FG_BOLD=$(tput bold)
    BLINK=$(tput blink)
    FG_START_UNDERLINE=$(tput smul)
    FG_END_UNDERLINE=$(tput rmul)

    ## turn off attributes
    BG_NoColor=$(tput sgr0)
    FG_NoColor=$(tput sgr0)

    ## you may need a special font to read the X or check marks
    ## not sure what the dependency is for this
    ## known to work with powerline, DejaVu Sans

    ## CHECKMARK='\u2714'
    CHECKMARK='\u2713'

    ## XMARK='\u274c'
    ## XMARK='\u2715'
    XMARK='\u2717'
}

function greetings {
    clear
    echo "${FG_CYAN}"
    echo "#################################################################"
    echo "###                     Keyboard Layout                       ###"
    echo "#################################################################"
    echo "## About: This tool is used to develop keyboard muscle memory. ##"
    echo "##        Compatible with Bash or GitBash                      ##"
    echo "##                                                             ##"
    echo "## By:    Mezcel                                               ##"
    echo "##        ${FG_START_UNDERLINE}https://github.com/mezcel/keyboard-layout.git${FG_END_UNDERLINE}${FG_NoColor}        ##"
    echo "#################################################################"
}

function letter_array {

    echo -e "\n$FG_YELLOW Loading database of letter and words ..."

    letterArray=( $(cat $thisPath/text-files/letterArray.txt) )
    wordsArray=( $(cat $thisPath/text-files/wordsArray.txt) )

    leftArray=( $(cat $thisPath/text-files/leftArray.txt) )
    leftPinky=( $(cat $thisPath/text-files/leftPinky.txt) )
    leftRing=( $(cat $thisPath/text-files/leftRing.txt) )
    leftMiddle=( $(cat $thisPath/text-files/leftMiddle.txt) )
    leftIndex=( $(cat $thisPath/text-files/leftIndex.txt) )
    leftWords=( $(cat $thisPath/text-files/leftWords.txt) )

    rightArray=( $(cat $thisPath/text-files/rightArray.txt) )
    rightIndex=( $(cat $thisPath/text-files/rightIndex.txt) )
    rightMiddle=( $(cat $thisPath/text-files/rightMiddle.txt) )
    rightRing=( $(cat $thisPath/text-files/rightRing.txt) )
    rightPinky=( $(cat $thisPath/text-files/rightPinky.txt) )
    rightWords=( $(cat $thisPath/text-files/rightWords.txt) )

    toprowArray=( $(cat $thisPath/text-files/toprowArray.txt) )
    toprowWords=( $(cat $thisPath/text-files/toprowWords.txt) )
    homerowArray=( $(cat $thisPath/text-files/homerowArray.txt) )
    homerowWords=( $(cat $thisPath/text-files/homerowWords.txt) )
    bottomrowArray=( $(cat $thisPath/text-files/bottomrowArray.txt) )

    computerWords=( $(cat $thisPath/text-files/computerWords.txt) )

    echo -e " Loading finished. $FG_NoColor"
    sleep 1s
}

function define_digit {

    echo -e "\n\nWhich finger do you want to focus on:\n"
    echo -e "\t1. Left pinky\t7. Right index"
    echo -e "\t2. Left ring\t8. Right middle"
    echo -e "\t3. Left middle\t9. Right ring"
    echo -e "\t4. Left index\t0. Right pinky"
    echo -e "\t*. default to all fingers\n"

    read -p "${FG_MAGENTA}Which finger? [ 0 - 9 ]:${FG_NoColor} " -n1 digit

    case $digit in
        [1qaz]* ) ## Left pinky
            training="Left pinky"
            ARRAY=("${leftPinky[@]}")
            ;;
        [2wsx]* ) ## Right ring
            training="Right ring"
            ARRAY=("${leftRing[@]}")
            ;;
        [3edc]* ) ## Left middle
            training="Left middle"
            ARRAY=("${leftMiddle[@]}")
            ;;
        [456rfvtgb]* ) ## Left index
            training="Left index"
            ARRAY=("${leftIndex[@]}")
            ;;
        [7yhnujm]* ) ## Right index
            training="Right index"
            ARRAY=("${rightIndex[@]}")
            ;;
        [8ik,]* ) ## Right middle
            training="Right middle"
            ARRAY=("${rightMiddle[@]}")
            ;;
        [9ol.]* ) ## Right ring
            training="Right ring"
            ARRAY=("${rightRing[@]}")
            ;;
        [0p\;\/]* ) ## Right pinky
            training="Right pinky"
            ARRAY=("${rightPinky[@]}")
            ;;
        * )
            training="all individual digits"
            ARRAY=("${letterArray[@]}")
            ;;
    esac
}

function define_hand {
    echo -e "\n\nFull hand exercise:\n"
    echo -e "\t1. Left handed letters\t2. Left handed words"
    echo -e "\t3. Right handed letters\t4. Right handed words"
    echo -e "\t5. Top row letters\t6. Top row words"
    echo -e "\t7. Home row letters\t8. Home row words"
    echo -e "\t9. Bottom row letters\t0. All letters"
    echo -e "\ta. All words\t\tc. Computer words"
    echo -e "\t*. Default to basic words\n"

    read -p "${FG_MAGENTA}Select option? [ 0 - 9, a, c ]:${FG_NoColor} " -n1 hand

    case $hand in
        0 ) ## All letters
            handhint="${FG_START_UNDERLINE}B${FG_END_UNDERLINE}oth hands"
            training="all individual digits"
            ARRAY=("${letterArray[@]}")
            ;;
        1 ) ## Left hand letters
            training="left handed letters"
            ARRAY=("${leftArray[@]}")
            ;;
        2 ) ## Left hand words
            handhint="${FG_START_UNDERLINE}L${FG_END_UNDERLINE}eft hand"
            training="left handed words"
            ARRAY=(${leftWords[@]})
            ;;
        3 ) ## Right hand letters
            training="right handed letters"
            ARRAY=("${rightArray[@]}")
            ;;
        4 ) ## Right hand words
            handhint="${FG_START_UNDERLINE}R${FG_END_UNDERLINE}ight hand"
            training="right handed words"
            ARRAY=(${rightWords[@]})
            ;;
        5 ) ## Top row letters
            training="top row letters"
            ARRAY=("${toprowArray[@]}")
            ;;
        6 ) ## Top row words
            handhint="${FG_START_UNDERLINE}T${FG_END_UNDERLINE}op row"
            training="top row words"
            ARRAY=(${toprowWords[@]})
            ;;
        7 ) ## Home row letters
            training="home row letters"
            ARRAY=("${homerowArray[@]}")
            ;;
        8 ) ## Home row words
            handhint="${FG_START_UNDERLINE}H${FG_END_UNDERLINE}ome row"
            training="home row words"
            ARRAY=(${homerowWords[@]})
            ;;
        9 ) ## Bottom row letters
            training="bottom row letters"
            ARRAY=("${bottomrowArray[@]}")
            ;;
        "a" ) ## All words
            handhint="${FG_START_UNDERLINE}B${FG_END_UNDERLINE}oth hands"
            training="common words and computer words"
            ARRAY=(${wordsArray[@]})
            ARRAY+=(${computerWords[@]})
            ;;
        "c" ) ## Computer words
            handhint="${FG_START_UNDERLINE}B${FG_END_UNDERLINE}oth hands"
            training="computer words"
            ARRAY=(${computerWords[@]})
            ;;
        * )
            handhint="${FG_START_UNDERLINE}B${FG_END_UNDERLINE}oth hands"
            training="common words"
            ARRAY=(${wordsArray[@]})
            ;;
    esac
}

function menu {
    echo -e "\nTraining options:\n"
    echo -e "\t1. finger training\t2. hand training\n\t3. practice word\t4. pracice centence\n\t*. all single fingers\n"

    read -p "${FG_MAGENTA}Enter an option number? [ 1, 2, 3, 4 ]:${FG_NoColor} " -n1 hand

    case $hand in
        1 )
            isRandom=1
            define_digit
            ;;
        2 )
            isRandom=1
            define_hand
            ;;
        3 )
            isRandom=1
            echo -e "\n\nEnter a word you want to practice typing. (no spaces)\n"
            read -p "${FG_MAGENTA}Enter a word string:${FG_NoColor} " letter
            ARRAY=("$letter")
            training="typing the \"$letter\" string"
            handhint="freestyle"
            ;;
        4 )
            isRandom=0
            echo -e "\n\nEnter a centence you want to practice typing.\n"
            read -p "${FG_MAGENTA}Enter a centence string:${FG_NoColor} " letter
            ARRAY=($letter)
            training="typing the \"$letter\" centence"
            handhint="freestyle"
            ;;
        * )
            isRandom=1
            training="all individual digits"
            ARRAY=("${letterArray[@]}")
            ;;
    esac

    ## Starting message and UI guide

    echo -e "${FG_BLUE}\n\n-------------------------\n Training: $training"
    echo -e "${FG_BLUE} Interface layout:\n\t[ ${FG_START_UNDERLINE}H${FG_END_UNDERLINE}int ]  <type this string> ==> ${FG_GREEN}(${CHECKMARK} pass)${FG_BLUE} or ${FG_RED}(${XMARK} fail)${FG_BLUE} flag\n Performance status:\n\t( wpm ) @timestamp | ( total wpm ) avg"
    echo -e "${FG_BLUE} Exit:\n\tPress \"Esc\" or \"Esc+Enter\" or \"Ctrl+c\" to EXIT"
    echo -e "${FG_BLUE}-------------------------\n${FG_NoColor}"
}

function random_letter {
    CEILING=${#ARRAY[@]}
    CEILING=$((CEILING-1))

    FLOOR=0
    RANGE=$(($CEILING-$FLOOR+1))

    random_number=$RANDOM
    let "random_number %= $RANGE"
    random_number=$(($random_number+$FLOOR))
    letter=(${ARRAY[$random_number]})
}

function sequential_words {
    CEILING=${#ARRAY[@]}
    CEILING=$((CEILING-1))

    FLOOR=0
    RANGE=$(($CEILING-$FLOOR))

    if [ $index -le $RANGE ]; then
        letter=(${ARRAY[$index]})
        index=$(($index+1))
    else
        index=0
        letter=(${ARRAY[$index]})
        index=$(($index+1))
    fi
}

function finger_digit {
    #letter=$1

    case $letter in
        [qaz]* )
            fingerhint="${FG_START_UNDERLINE}L${FG_END_UNDERLINE}eft pinky"
            ;;
        [p\;\/]* )
            fingerhint="${FG_START_UNDERLINE}R${FG_END_UNDERLINE}ight pinky"
            ;;
        [wsx]* )
            fingerhint="${FG_START_UNDERLINE}L${FG_END_UNDERLINE}eft ring"
            ;;
        [ol.]* )
            fingerhint="${FG_START_UNDERLINE}R${FG_END_UNDERLINE}ight ring"
            ;;
        [edc]* )
            fingerhint="${FG_START_UNDERLINE}L${FG_END_UNDERLINE}eft middle"
            ;;
        [ik,]* )
            fingerhint="${FG_START_UNDERLINE}R${FG_END_UNDERLINE}ight middle"
            ;;
        [rtfgvb]* )
            fingerhint="${FG_START_UNDERLINE}L${FG_END_UNDERLINE}eft index"
            ;;
        [yuhjnm]* )
            fingerhint="${FG_START_UNDERLINE}R${FG_END_UNDERLINE}ight index"
            ;;
        * )
            fingerhint="${FG_START_UNDERLINE}R${FG_END_UNDERLINE}ight pinky"
            ;;
    esac
}

function summary {
    totalCount=$(($passCount+$failCount))
    if [ $min -lt 1 ]; then
        min=1
    fi

    command -v bc
    isBC=$?
    if [ $isBC -eq 0 ]; then
        avgPassString=${FG_MAGENTA}$(echo "$passCount/$min" | bc)
    else
        avgPassString="? bc not installed!"
    fi

    echo -e "\n\n ${FG_START_UNDERLINE}Training${FG_END_UNDERLINE}:\t$training"

    echo -e " ${FG_START_UNDERLINE}Performance${FG_END_UNDERLINE}:\t${FG_GREEN} $CHECKMARK Pass:$passCount/$totalCount ${FG_RED} $XMARK Fail:$failCount/$totalCount ${FG_NoColor} ( $avgPassString ${FG_GREEN}$CHECKMARK${FG_MAGENTA}'s / min ${FG_NoColor}) avg"

    echo -e " ${FG_START_UNDERLINE}Elapsed time${FG_END_UNDERLINE}:\t${FG_CYAN}$(print_elapsed_time) ${FG_NoColor}"
    echo -e "\n Quit App."
}

function finger_check {
    pass=0
    escKey=$'\e'
    tabVar=$(echo -e "\t")

    while [ $pass -eq 0 ]
    do
        string_length=${#letter}

        ## Read aloud using mbrola
        # command -v mbrola
        # if [[ $? -eq 0 ]] text_to_speech
        # text_to_speech

        if [ $string_length -eq 1 ]; then
        #if [ $string_length -le 3 ]; then
            prompt_length=${#fingerhint}

            if [ $prompt_length -le 20 ]; then
                spacer=$(echo -e "\t")$(echo -e "\t")
            else
                spacer=$(echo -e "\t")
            fi
            
            read -p "[ ${FG_START_UNDERLINE}$handhint${FG_END_UNDERLINE} ]  ${FG_CYAN}${FG_BOLD}$letter${FG_NoColor}${spacer}==> " -n$string_length inputPress

        else

            tabDiff=$(( 4 - ( ${#letter} % 4 ) ))

            if [ $tabDiff -ne 0 ]; then
                spacer=" "
                for i in { 1..$tabDiff }; do
                    spacer=$spacer$spacer
                done
                spacer=${spacer}$(echo -e "\t")
            fi

            if [ ${#letter} -le 3 ]; then
                spacer=$(echo -e "\t")$(echo -e "\t")
            fi

            if [ $string_length -ge 15 ]; then
                spacer=" "
            elif [ $string_length -ge 8 ]; then
                spacer=$(echo -e "\t")
            fi

            read -p "[ ${FG_START_UNDERLINE}$handhint${FG_END_UNDERLINE} ]  ${FG_CYAN}${FG_BOLD}$letter${FG_NoColor}${spacer}==> " -n$string_length inputPress

        fi

        case $inputPress in
            $escKey )
                summary
                exit
                ;;
            $letter )
                if [ ${#spacer} -le 3 ] || [ ${#letter} -le 3 ]; then
                    spacer=${spacer}$(echo -e "\t")
                fi
                echo -e "$spacer${FG_GREEN}$CHECKMARK  pass ${FG_NoColor}"

                pass=1
                passCount=$((passCount + 1))
                ;;
            * )
                if [ ${#spacer} -le 3 ] || [ ${#letter} -le 3 ]; then
                    spacer=${spacer}$(echo -e "\t")
                fi
                echo -e "$spacer${FG_RED}$XMARK fail, you entered: ${FG_CYAN}${FG_BOLD}$inputPress ${FG_RED}"

                pass=0
                failCount=$((failCount + 1))
                ;;
        esac
    done

    print_minute_flag
}

function start_timer {
    start_time="$(date -u +%s)"
    minute_counter=0
    pass_per_min=0
}

function get_elapsed_time {
    end_time="$(date -u +%s)"
    elapsed_seconds="$(($end_time-$start_time))"

    duration=$elapsed_seconds
    min=$(($duration/60))
    sec=$((duration % 60))
}

function print_elapsed_time {
    get_elapsed_time

    [[ ${min} -eq 0 && ${sec} -gt 0 ]] && echo "$sec Seconds"
    #[[ ${min} -gt 0 && ${sec} -gt 0 ]] && echo "${min}m ${sec}s"
    if [ ${min} -gt 0 ]; then
        if [ ${sec} -gt 0 ]; then
            echo "${min}m ${sec}s"
        else
            echo "${min}m 0s"
        fi
    fi
    [[ ${min} -eq 0 && ${sec} -eq 0 ]] && echo "${sec}s"
}

function print_minute_flag {
    get_elapsed_time

    if [ $minute_counter -ne $min ]; then
        minute_counter=${min}

        pass_per_min=$(($passCount-$pass_per_min))

        command -v bc
        isBC=$?
        if [ $isBC -eq 0 ]; then
            avgPassString=${FG_MAGENTA}$(echo "$passCount/$min" | bc)
        else
            avgPassString="? bc not installed!"
        fi

        echo -e "\n\t( ${FG_MAGENTA}${FG_BOLD}$pass_per_min ${FG_NoColor}${FG_GREEN}${CHECKMARK}${FG_MAGENTA}'s / min ${FG_NoColor})${FG_MAGENTA} @$(print_elapsed_time)${FG_NoColor} | ( $avgPassString ${FG_GREEN}${CHECKMARK}${FG_MAGENTA}'s / min ${FG_NoColor}) avg \n"
        pass_per_min=$passCount
    fi
}

function text_to_speech {
    command -v espeak
    if [ $? -eq 0 ]; then
        espeak -v mb-en1 -s 120 "$letter"
    fi
}

function main {
    tput_color_variables
    greetings
    letter_array

    menu

    run=1
    pass=0
    passCount=0
    failCount=0
    index=0
    min=0

    start_timer

    while [ $run -eq 1 ]; do
        if [ $isRandom -eq 1 ]; then
            random_letter
        else
            sequential_words
        fi

        finger_digit
        finger_check
    done
}

main
