a.out: lex.yy.c token.h driver.c
	gcc -g driver.c
lex.yy.c: lexer.l 
	lex lexer.l
clean: 
	rm -f lex.yy.c
	rm -f a.out
	rm -f core*
	rm -f *~
	rm -f #*#
	
