
%{
#include <stdio.h>

int yylex();
int yyerror(char *s);

%}

%token NUM STRING OP_ATRIB OP_ARIT OP_LOGIC OP_COMP ID VIRGULA ABRE_PAR FECHA_PAR PTVIRG ABRE_CHAVE FECHA_CHAVE ABRE_COL FECHA_COL ASPAS APOST DOISP OUTRO

%type <nome> ID
%type <numero> NUM


%union{
	char nome[20];
	int numero;
}

%%

prog:
	padrao;

padrao:
	exemplo PTVIRG padrao | %empty
;

exemplo:
	ID {printf("Identificador: %s", $1);} |
	NUM {printf("Num: %d", $1);}
;
	

%%

int yyerror(char *s) {
	printf("Syntax error: %s", s);
	return 0;
}
int main() {
	yyparse();
	return 0;
}







