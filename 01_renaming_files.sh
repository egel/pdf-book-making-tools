#!/bin/bash

green='\e[0;32m' # '\e[1;32m' is too bright for white bg.
red='\e[0;31m'
yellow='\e[0;33m'
purple='\e[0;35m'
endColor='\e[0m'

bash_ver=${BASH_VERSION}
AMOUNT_OF_FILES=$(ls -1 $DIR | wc -l)

EXT=png   # files extension
DIR=~/Pulpit/Latex_book_step_2/ # path to images (source)

echo -e "${purple}######################################${endColor}"
echo -e "${purple}# Program for massive renaming files #${endColor}"
echo -e "${purple}######################################${endColor}"
echo ""
echo "Example 1: 'Obraz.png' will change into '1.png'"
echo "Example 2: 'Obraz (10).png' will change into '010.png'"
echo ""

echo "Bash version: ${bash_ver}"
cd $DIR
echo "Current DIR: "$(pwd)
echo "Number of files in DIR:" $AMOUNT_OF_FILES

echo ""
echo -e "${purple}Removing unnecessary elements from each filename${endColor}"
echo -e "${purple}------------------------------------------------${endColor}"

PHRASE="Empty spaces: "
rename "s/ *//g" *.$EXT      # Usunie wszystkie spacje spośród nazw plików
PHRASE+=" ${green}Done${endColor}"
echo -e $PHRASE

PHRASE="Phrase 'Obraz': "
rename 's/Obraz\./1\./' *.$EXT   # Zamieni tekst 'Obraz.' na '1.' spośród nazw plików
PHRASE+=" ${green}Done${endColor}"
echo -e $PHRASE

PHRASE="Phrase 'Obraz(': "
rename 's/Obraz\(//' *.$EXT  # Usunie tekst 'Obraz(' spośród nazw plików
PHRASE+=" ${green}Done${endColor}"
echo -e $PHRASE

PHRASE="Phrase ')': "
rename 's/\)//' *.$EXT       # Usunie tekst ')'
PHRASE+=" ${green}Done${endColor}"
echo -e $PHRASE

