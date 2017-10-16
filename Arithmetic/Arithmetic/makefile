Executable: 	main.o Arithmetic.o 				# mat depends on main.o, Arithmetic.o 
		c++ -o Executable main.o Arithmetic.o 	# link object code Executable

main.o: 	main.cpp Arithmetic.h				# main.o rely on main.cpp, Arithmetic.h 
		c++ -c -O main.cpp 				# compile main.cpp and optimize


Arithmetic.o: 	Arithmetic.cpp Arithmetic.h 			# what Arithmetic.o depends on ? 
		c++ -c -O Arithmetic.cpp 			# compile with option -O