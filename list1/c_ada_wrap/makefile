all:
	gnatmake -c integer_functions_rec
	gcc -c wrapper.c
	gnatbind -n integer_functions_rec
	gnatlink integer_functions_rec -o main -LINK=gcc wrapper.o
