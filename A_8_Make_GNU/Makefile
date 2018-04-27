all:APP

APP:prog.o function.o common.h
	gcc prog.o function.o -o APP -lm -lpthread
prog.o:prog.c common.h
	gcc -c prog.c -o prog.o -lm -lpthread
function.o:thread_function.c common.h
	gcc -c thread_function.c -o function.o -lm -lpthread

runtest: runtest.sh APP
	./runtest.sh

plot: runtest.sh APP
	./plot.gp
	rm threads_* avg_*
