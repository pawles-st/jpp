all:
	gnatmake -c integer_functions_rec.ads
	gcc -c main.c
	gnatbind -n integer_functions_rec.ali
	gnatlink integer_functions_rec.ali main.o -o main
