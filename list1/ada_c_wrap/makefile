all:
	gcc -c rec_module.c
	gnatmake -c main
	gnatbind main.ali
	gnatlink main.ali rec_module.o -o main
