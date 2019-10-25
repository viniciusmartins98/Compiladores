
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
%token DESCARTE
%token CASE

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
	comandof comandos| comandol comandos | %empty
		{printf("COMANDOS!");}
;

comandof:
	declaracao PTVIRG 
	{printf("COMANDOF!");}
	| atribuicao PTVIRG
	{printf("COMANDOF!");}
	| decFunc PTVIRG
	{printf("COMANDOF!");}
	| chamaFunc PTVIRG
	{printf("COMANDOF!");}
;

comandol:
	if | while | for | switch
	{printf("COMANDOL!");}
;

operandos:
	ID | NUM | chamaFunc
;

atribuicao:
	ID OP_ATRIB valor
	{printf("ATRIBUICAO!");}
;

valor:
	operacao_aritmetica | operandos
;

operacao_aritmetica:
	e OP_ARIT e
	{printf("OPERACAO_ARITMETICA!");}
	| ABRE_PAR e FECHA_PAR
	{printf("OPERACAO_ARITMETICA!");}
;

e:
	e OP_ARIT e | f
;

f:
	ABRE_PAR e FECHA_PAR | operandos
;


declaracao:
	TIPO var
	{printf("DECLARACAO!");}
;

var:
	ID | atribuicao | ID VIRGULA var | atribuicao VIRGULA var
;

if:
	IF condicao DO ABRE_CHAVE comandos FECHA_CHAVE ELSE DO ABRE_CHAVE comandos FECHA_CHAVE 
	{printf("ifzera!");}	
	| IF condicao DO ABRE_CHAVE comandos FECHA_CHAVE
	{printf("ifzera!");}
;

condicao:
	comparacao  {printf("condicao!");}
	| comparacao OP_LOGIC comparacao bom
	{printf("condicao!");}
	 
	//comparacao OP_LOGIC condicao
	//{printf("condicao!");}
	//| comparacao 
	//{printf("condicao!");}
;

bom:
	OP_LOGIC comparacao bom | %empty
;

comparacao:
	ruim OP_COMP ruim
	{printf("COMPARACAO!");}
;

ruim:
	operandos | operacao_aritmetica
;

while:
	WHILE condicao DO ABRE_CHAVE comandos FECHA_CHAVE
	{printf("whilezera!");}
;

for:
	FOR condicaoa TO condicaob DO ABRE_CHAVE comandos FECHA_CHAVE
	{printf("forzera!");}	
;

condicaoa:
	atribuicao | ID
;

condicaob:
	operandos DOISP operandos | operandos
;


decFunc:
	TIPO ID ABRE_PAR listParametros1 FECHA_PAR
	{printf("DEC FUNC JAO!!");}
;

listParametros1:
	TIPO ID listParametros1 | VIRGULA TIPO ID listParametros1 | %empty 
;


chamaFunc:
	ID ABRE_PAR listParametros2 FECHA_PAR
	{printf("CHAMA FUNC JAO!!");}
;

listParametros2:
	ID listParametros2 | VIRGULA ID listParametros2 | %empty 
;

switch:
	SWITCH ID ABRE_CHAVE cases FECHA_CHAVE
	{printf("SWITCH!");}
;

cases:
	CASE OP_COMP operandos DO DOISP comandos | CASE OP_COMP operandos DO DOISP comandos cases
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







