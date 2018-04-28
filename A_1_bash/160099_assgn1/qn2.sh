#!/bin/bash

read path
for i in $(find $path)
do
  sent=$(($(grep -ro '[\.\?\!]' $i | wc -w)-$(grep -ro '[0-9]\.[0-9]' $i | wc -w)))
  integers=$(($(grep -ro '\-*[0-9]*' $i | wc -w)-2*$(grep -ro '[0-9]\.[0-9]' $i | wc -w)))
  echo "$i-$sent-$integers" > x.txt
  if  [ -d $i ];then
    echo -n "(D) "
    cat x.txt | sed 's|[^\/]*\/|   |g'
    #
  else
    echo -n "(F) "
    cat x.txt | sed 's|[^\/]*\/|   |g'
    #
  fi

done
#cat x.txt | sed 's|[^\/]*\/|     |g'

#for i in $(find $path)
#do
#  count=$(($(grep -ro '\-*[0-9]*' $i | wc -w)-$(grep -ro '[0-9]\.[0-9]' $i | wc -w)))
#  echo "$i = $count"
#done
