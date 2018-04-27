#!/usr/bin/gnuplot
plot 'threads_1.txt' using 3:7
pause -1
plot 'threads_2.txt' using 3:7
pause -1
plot 'threads_4.txt' using 3:7
pause -1
plot 'threads_8.txt' using 3:7
pause -1
plot 'threads_16.txt' using 3:7
pause -1


plot 'avg_1.txt' using 3:7 with line, 'avg_2.txt' using 3:7 with line, 'avg_4.txt' using 3:7 with line, 'avg_8.txt' using 3:7 with line, 'avg_16.txt' using 3:7 with line
pause -1
