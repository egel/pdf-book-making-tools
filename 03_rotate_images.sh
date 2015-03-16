#!/bin/bash

green='\e[0;32m' # '\e[1;32m' is too bright for white bg.
red='\e[0;31m'
yellow='\e[0;33m'
purple='\e[0;35m'
endColor='\e[0m'

bash_ver=${BASH_VERSION}
AMOUNT_OF_FILES=$(ls -1 $DIR | wc -l)

EXT=png
DIR=~/Pulpit/book_step_4/

echo -e "${purple}##########################${endColor}"
echo -e "${purple}# Rotate Files 90 degree #${endColor}"
echo -e "${purple}##########################${endColor}"

echo "Bash version: ${bash_ver}"
cd $DIR
echo "Current DIR: "$(pwd)
echo "Number of files in DIR:" $AMOUNT_OF_FILES

TEMP_ARRAY=() # definicja tablicy
for currentFile in *.$EXT
do
  extension="${currentFile##*.}"
  filename="${currentFile%.*}"
  TEMP_ARRAY=( "${TEMP_ARRAY[@]}" "${filename}" ) # add item to array

  # Update max lenght of string if applicable
  if [[ "${#filename}" -gt "$max" ]]; then
      max="${#filename}"
  fi
done

echo -e "Number of files:" ${#TEMP_ARRAY[@]}
echo -e "The maximum lenght of filename (without extension):" ${max}
echo ""


echo -e "${purple}### Begin conversion ###${endColor}"

for (( i=0; i<${#TEMP_ARRAY[@]} ; i++ ))  # the 'i' would be the 'filename'
do
  # Assume that when using a stacking files 000, 001, 002, ect.
  # Are arranged sequentially in the order of scheduling files in Linux

  if [[ $((i%2)) -eq 0 ]]; then
    # Odd image (ex: 001, 003, 005 ...) (nieparzyste: 90)
    echo "${TEMP_ARRAY[i]}.$EXT" " is Odd"
    echo "${TEMP_ARRAY[i]}.$EXT" "-> converting"
    convert "${TEMP_ARRAY[i]}.$EXT" -rotate 90 "${TEMP_ARRAY[i]}.$EXT"
  else
    # Even image (ex: 002, 004, 006 ...) (parzyste: 270)
    echo "${TEMP_ARRAY[i]}.$EXT" " is Even"
    echo "${TEMP_ARRAY[i]}.$EXT" " -> converting"
    convert "${TEMP_ARRAY[i]}.$EXT" -rotate 270 "${TEMP_ARRAY[i]}.$EXT"
  fi
  # echo -ne "."
done

echo -e "${purple}### End conversion ###${endColor}"
