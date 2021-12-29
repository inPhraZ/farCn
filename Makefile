all: farcn clean

farcn: farcn.o lex.yy.c
	gcc -o farcn  farcn.o lex.yy.c

farcn.o: farcn.c farcn.h
	gcc -c farcn.c

lex.yy.c: tokens.h
	lex farcn.lex

clean:
	rm -rf farcn.o lex.yy.c

cleanall: clean
	rm -rf farcn
