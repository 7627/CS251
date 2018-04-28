#!/bin/bash
declare -A ones=([0]="" [1]="one" [2]="two" [3]="three" [4]="four" [5]="five" [6]="six" [7]="seven" [8]="eight" [9]="nine");
declare -A tens=([0]="" [2]="twenty" [3]="thirty" [4]="forty" [5]="fifty" [6]="sixty" [7]="seventy" [8]="eighty" [9]="ninety");
declare -A eleven=([10]="ten" [11]="eleven" [12]="twelve" [13]="thirteen" [14]="fourteen" [15]="fifteen" [16]="sixteen" [17]="seventeen" [18]="eighteen" [19]="nineteen");

function words(){
  input=$1
  input=$((10#$input)) #removed leading zero and if not so, converted to decimal form from octal
  #echo $input
  len=$(echo $input | wc -c)
  #echo "$len"
  if [ $len == 2 ];then #i.e one digit numbe
    echo -n "${ones[$input]} "
  fi
  if [ $len == 3 ];then
    if [ $(($input/10)) == 1 ];then
      echo -n "${eleven[$input]} "

    else
      echo -n "${tens[$(echo $input | cut -c1)]} "
      echo -n "${ones[$(echo $input | cut -c2)]} "
    fi
  fi
  if [ $len == 4 ];then
    echo -n "${ones[$(echo $input | cut -c1)]} "
    echo -n "hundred "
    words $[ $input%100 ]
  fi
  if [ $len == 5 ];then
    echo -n "${ones[$(echo $input | cut -c1)]} "
    echo -n "thousand "
    words $[ $input%1000]
  fi
}

number=$1
number=$((10#$number)) #removed leading zero and if not so, converted to decimal form from octal
#echo "$number"
l=$(($number/10000000))
if [ $l != 0 ];then
  words $l
  echo -n "crore "
  number=$(($number%10000000))
fi

l=$(($number/100000))
if [ $l != 0 ];then
  words $l
  echo -n "lakh "
  number=$(($number%100000))
fi

l=$(($number/1000))
if [ $l != 0 ];then
  words $l
  echo -n "thousand "
  number=$(($number%1000))
fi

words $number
