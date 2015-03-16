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

echo -e "${purple}##################################################${endColor}"
echo -e "${purple}# Massive Files Renaming (ex: 1.png -> 0001.png) #${endColor}"
echo -e "${purple}##################################################${endColor}"

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
  number_of_zeros=$(($max-${#TEMP_ARRAY[i]}))
  #echo "${TEMP_ARRAY[i]}, $number_of_zeros"   # for check if the number of zeros is correct
  fullname=""
  if [[ "$number_of_zeros" -ne "0" ]]; then
    for (( k = 0; k < $number_of_zeros; k++ )); do
      fullname+="0"
    done
    fullname+="${TEMP_ARRAY[i]}"
    fullname+=".$EXT"
    echo "${TEMP_ARRAY[i]}.$EXT" "$fullname"
    mv "${TEMP_ARRAY[i]}.$EXT" "$fullname"
  else
    fullname+="${TEMP_ARRAY[i]}"
    fullname+=".$EXT"
    echo -ne $fullname
    echo " -> No need to convert"
  fi
done
echo -e "${purple}### End conversion ###${endColor}"
