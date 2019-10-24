
%{
#include <stdio.h>

int yylex();
int yyerror(char *s);

%}

%token NUM
%token STRING
%token OP_ATRIB
%token OP_ARIT
%token OP_LOGIC
%token OP_COMP
%token ID
%token VIRGULA
%token ABRE_PAR
%token FECHA_PAR
%token PTVIRG
%token ABRE_CHAVE
%token FECHA_CHAVE
%token ABRE_COL
%token FECHA_COL
%token ASPAS
%token APOST
%token DOISP
%token OUTRO
%token TIPO
%token FOR
%token IF
%token ELSE
%token DO
%token SWITCH
%token WHILE
%token TO

%type <nome> ID
%type <numero> NUM


%union{
	char nome[20];
	int numero;
}

%%

prog:
	S;

S:
	comandos
;

comandos:
	comando comandos | %empty
;

comando:
	declaracao PTVIRG | atribuicao PTVIRG
	{printf("COMANDO!");}
;

operandos:
	ID | NUM
;

atribuicao:
	ID OP_ATRIB tram
	{printf("ATRIBUICAO!");}
;

tram:
	operacao_aritmetica | operandos
;

operacao_aritmetica:
	v OP_ARIT v
	{printf("OPERACAO!");}
;

v:
	NUM | ID | ABRE_PAR v FECHA_PAR b
;

b:
	OP_ARIT v | %empty
;

declaracao:
	TIPO bique
	{printf("DECLARACAO!");}
;

bique:
	ID | atribuicao | ID VIRGULA bique | atribuicao VIRGULA bique
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







