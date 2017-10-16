# Makefile for source file ArithmeticTest.cpp # Source ArithmeticTest.cpp call functions # in my library Arithmetic.lib# ArithmeticTest.cpp includes header file in Arithmetic.lib
# a macro for our library base
BASE = ../Arithmetic
# macro for name of my compiler 
CC = c++

# macro for compilation options 
CFLAGS = -O

# paths for my libraries
LIB = $(BASE)/Arithmetic.lib


#name of executable file
EFILE = Executable


OBJS = ArithmeticTest.o


Executable:	$(OBJS)           
		$(CC) $(CFLAGS) -o $(EFILE) $(OBJS) $(LIB)


$(OBJS):
		$(CC) -I $(BASE) $(INCLS) -c $*.cpp



clean:			
	rm -f $(OBJS) $(EFILE)


# ArithmeticTest.o depends on ArithmeticTest.cpp
ArithmeticTest.o: 	ArithmeticTest.cpp