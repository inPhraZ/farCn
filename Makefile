farcn: lex.yy.c
	gcc -o farcn  lex.yy.c
	rm -rf lex.yy.c

lex.yy.c:
	lex farcn.lex

clean:
	rm -rf lex.yy.c

cleanall: clean
	rm -rf farcn
