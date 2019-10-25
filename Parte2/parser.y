
%{
#include <stdio.h>

int contLinha = 1;
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
	comandos;

// TODOS OS COMANDOS
comandos:
	comandof comandos| comandol comandos | %empty
;

// COMANDOSQUE PRECISAM DE ;
comandof:
	declaracao PTVIRG 
	{printf("\n\033[32mDECLARACAO -> SUCESSO!\033[0m\n");}
	| atribuicao PTVIRG
	{printf("\n\033[32mATRIBUICAO -> SUCESSO!\033[0m\n");}
	| decFunc PTVIRG
	{printf("\n\033[32mDECLARACAO DE FUNCAO -> SUCESSO!\033[0m\n");}
	| chamaFunc PTVIRG
	{printf("\n\033[32mCHAMADA DE FUNCAO -> SUCESSO!\033[0m\n");}
;

//COMANDOS QUE NAO PRECISAM DE ;
comandol:
	if 
	| while 
	{printf("\n\033[32mCOMANDO WHILE -> SUCESSO!\033[0m\n");}
	| for 
	{printf("\n\033[32mCOMANDO FOR -> SUCESSO!\033[0m\n");}
	| switch
	{printf("\n\033[32mCOMANDO SWITCH -> SUCESSO!\033[0m\n");}
;

// OPERADORES BASICOS (IDENTIFICADOR OU NUMERO OU FUNCAO)
operandos:
	ID | NUM | chamaFunc
;

// ATRIBUICAO, PODE SER UTILIZADO COM ; EM SEU TERMINO OU PODE SER UTILIZADA SEM A NECESSIDADE DO ; , POR EXEMPLO EM UM FOR (DEPENDE DO CAMINHO SEGIUDO)
atribuicao:
	ID OP_ATRIB expatribuicao
;

// EXPRESSAO QUE SERA ATRIBUIDA AO IDENTIFICADOR
expatribuicao:
	operacao_aritmetica | operandos
;

// OPERACAO ARITMETICA, ACEITA PARENTESES

operacao_aritmetica:
	expressao OP_ARIT expressao
	{printf("\n\033[34mOPERACAO_ARITMETICA!\033[0m");}
	| ABRE_PAR expressao FECHA_PAR
	{printf("\n\033[34mOPERACAO_ARITMETICA!\033[0m");}
;

expressao:
	operandos | operacao_aritmetica 
;

// inicio declaracao de variaveis
declaracao:
	TIPO var
;

// VARIAVEL UTILIZADA NA DECLARACAO
var:
	ID | atribuicao | ID VIRGULA var | atribuicao VIRGULA var
;

// COMANDO CONDICIONAL IF
if:
	IF condicao DO ABRE_CHAVE comandos FECHA_CHAVE ELSE DO ABRE_CHAVE comandos FECHA_CHAVE 
	{printf("\033[32mCOMANDO IF ELSE -> SUCESSO!\033[0m");}	
	| IF condicao DO ABRE_CHAVE comandos FECHA_CHAVE
	{printf("\033[32mCOMANDO IF -> SUCESSO!\033[0m");}
;

// COMANDO DE REPEICAO WHILE
while:
	WHILE condicao DO ABRE_CHAVE comandos FECHA_CHAVE
;

// operacao de comparacao
comparacao:
	expatribuicao OP_COMP expatribuicao 
	{printf("\n\033[34mOPERACAO COMPARATIVA\033[0m");}
;

// CONDICAO UTILIZADA NO IF E NO WHILE
condicao:
	comparacao | comparacao OP_LOGIC condicao
	{printf("\n\033[34mOPERACAO COMPARATIVA E LOGICA\033[0m");}
;

// COMANDO DE REPETICAO FOR
for:
	FOR parametroa TO parametrob DO ABRE_CHAVE comandos FECHA_CHAVE
;

// Valor utilizado para indicar o inicio do for
parametroa:
	atribuicao | ID
;

// Valor utilizado para indicar o fim do for e de quantos em quantos deve percorrer o for
parametrob:
	operandos DOISP operandos | operandos
;


// Declaracao de funcao
decFunc:
	TIPO ID ABRE_PAR listParametros1 FECHA_PAR
;

// Parametros que serao utilizados para declaracao da funcao
listParametros1:
	TIPO ID listParametros1 | VIRGULA TIPO ID listParametros1 | %empty 
;

// Chamada de funcao
chamaFunc:
	ID ABRE_PAR listParametros2 FECHA_PAR
;

// Parametros que serao utilizados para chamada da funcao
listParametros2:
	ID listParametros2 | VIRGULA ID listParametros2 | %empty 
;

// Comando condicional switch
switch:
	SWITCH ID ABRE_CHAVE cases FECHA_CHAVE
;

// Cases tilizados no switch
cases:
	CASE OP_COMP operandos DO DOISP comandos | CASE OP_COMP operandos DO DOISP comandos cases
;

%%

int yyerror(char *s) {
	printf("\033[1;31mErro sintatico na linha [%d]\033[0m\n",contLinha);
	return 0;
}
int main() {
	yyparse();
	return 0;
}







