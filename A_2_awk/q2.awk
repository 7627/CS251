#!/bin/sh
read file1

awk  '{ print $1" " $3" " $5 " "$9" " $NF }' $file1 | sed 's/:/./g' | sed 's/ /./g' | sed 's/\./ /g' |sed 's/,//g' |sed 's/  / /g' > file


n=$(cat file | wc -l) 
reset=0
awk 'BEGIN {A B count_A count_B 
	packets_A=0; 
	packets_B=0; 
	D_packets_A=0; 
	D_packets_B=0; 
	bytes_A=0; 
	bytes_B=0;
	retrans_A retranss_B a1 b1 c1  a2 b2 c2  xput
	}
	{	
	if(NR==1){retrans_A=0;retrans_B=0;  A=$5"."$6"."$7"."$8 ":"$9  ; B=$10"."$11"."$12"."$13":"$14; a1=$1 ; b1=$2; c1=$3"."$4;}
	
	else{
		        
	if ($5"."$6"."$7"."$8 ":"$9==A && $10"."$11"."$12"."$13":"$14==B){
		count_A++;
		if($NF)D_packets_A+=1;
		if($NF){bytes_A=bytes_A+$16-$15;}
		if($NF && $NF != $16-$15)retrans_A+=$16-$15-$NF;
	}
	
	else if ($5"."$6"."$7"."$8 ":"$9==B && $10"."$11"."$12"."$13":"$14==A){
		count_B++;
		 if($NF)D_packets_B+=1;
	 	if($NF){bytes_B=bytes_B+$16-$15;}
	 	if($NF && $NF != $16-$15)retrans_B+=$16-$15-$NF;
	 }
	

	
		
	 if(NR==$n) {  
		a2=$1;b2=$2;c2=$3"."$4;
		put=(a2-a1)*3600+(b2-b1)*60+(c2 - c1);
		xput=(bytes/put);
		print "connection (A=" B " B=" A ")";
		print "B-->A #packets="count_B " #datapackets="D_packets_B  " #bytes=" bytes_B " #retrans="retrans_B " #xput="xput " bytes/sec";
		print "A-->B #packets="count_A " #datapackets="D_packets_A  " #bytes=" bytes_A " #retrans="retrans_A " #xput="xput " yeah bytes/sec";
		A=$5"."$6"."$7"."$8 ":"$9  ;   B=$10"."$11"."$12"."$13":"$14;  
		
	}
   		}
	
	
	}
END	{




	a2=$1;b2=$2;c2=$3"."$4;
	 put=(a2-a1)*3600+(b2-b1)*60+(c2 - c1);
	 xput=(bytes/put);
	  print "connection (A=" B " B=" A ")";

	 print "B-->A #packets="count_B " #datapackets="D_packets_B  " #bytes=" bytes_B " #retrans="retrans_B " #xput="xput" bytes/sec";
	 
         print "A-->B #packets="count_A " #datapackets="D_packets_A  " #bytes=" bytes_A " #retrans="retrans_A " #xput="xput" from end bytes/sec";




}' file

rm file
