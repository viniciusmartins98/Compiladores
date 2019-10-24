# Compiladores
Trabalho da disciplina de Compiladores, implementar um analisador sintático e um analisador léxico utilizando flex / bison

#Execução
bison -d parser.y; flex analex.l; gcc -c lex.yy.c parser.tab.c; gcc -o parser lex.yy.o parser.tab.o -lfl
