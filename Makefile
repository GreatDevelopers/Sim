#
# \file Makefile
#
# \brief This file compile all the project code.
#
# \Compiler make
#
# \author Amritpal Singh
#

# Variables
# Compiler to use
CC = g++

# Compiler flag
CFLAGS = -I/header -L/usr/lib -lmysqlcppconn

# Object files
OBJ = structure.o material.o joint.o member.o job.o ConcreteDesign.o

# Output files
OUTPUT_FILE = Main Parse

# Special target
.PHONY = Doxygen Mysql clear clean delmysql

# Main target
all: Main

# sub targets
Main: main.cpp $(OBJ)
	$(CC) $^ -o $@ $(CFLAGS)

%.o: src/%.cpp src/header/%.h src/header/header.h
	$(CC) $< -c

# Optional targets
Doxygen:
	doxygen Doxyfile

Mysql:
	mysql -u root -p$(password) -e "create database Sim;"
	mysql -u root -p$(password) Sim<Sim.sql


Parse: src/scan.l src/grammar.y
	bison -dv src/grammar.y
	flex src/scan.l
	g++ -o $@ $(OBJ) src/grammar.tab.c lex.yy.c -lfl $(CFLAGS)

# Remove all the files made my Makefile
clear:
	rm ${OBJ} ${OUTPUT_FILE}

clean: clear delmysql

delmysql:
	mysql -u $(user) -p$(password) -e "drop database Sim;"
