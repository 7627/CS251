#!/bin/bash

for i in $(cat params.txt);
do
	for j in $(cat threads.txt)
	do
		sum=0;
		for k in {1..100}
		do
			x=$(./APP $i $j);
			#echo $x | awk '{sum+=$4}';
			echo "num_elem = $i $x" >> threads_$j.txt;
			
		done
		#echo $i $j;
		#sum=$((sum/100));
		#echo "average time of $i params with $j threads = $sum" >> avg_$j.txt 
	done

done

for j in $(cat threads.txt)
do
	cat threads_$j.txt | awk 'BEGIN {i=1;} {if (i==100) {i=0;print "params = "$3" avg time =  "sum/100; sum=0}}{i+=1; sum+=$7} END {print "params = "$3" avg time =  "sum/100}' >> avg_$j.txt
done

