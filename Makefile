# Copyright 2007-2009 Russ Cox.  All Rights Reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

CC=gcc
CFLAGS=-ggdb -Wall -O3

FILE_A= libre1.a

.PHONE: all clean

all: re $(FILE_A)

TARG=re
LIBOFILES=\
	backtrack.o\
	compile.o\
	pike.o\
	recursive.o\
	sub.o\
	thompson.o\
	y.tab.o\

OFILES= $(LIBOFILES) main.o

$(FILE_A): $(LIBOFILES)
	ar rcus $@ $(LIBOFILES)

HFILES=\
	regexp.h\
	y.tab.h\

re: $(OFILES)
	$(CC) -o re $(OFILES)

%.o: %.c $(HFILES)
	$(CC) -c $(CFLAGS) $*.c

y.tab.h y.tab.c: parse.y
	bison -v -y parse.y

clean:
	rm -f *.o core re y.tab.[ch] y.output
