
%{
#include <stdio.h>

int contLinha = 1;
int yylex();
void yyerror(char *s);

%}

%token NUM			// Numeros
%token STRING		// String
%token OP_ATRIB	// Operadores de atribuicao
%token OP_ARIT		// Operadores aritmeticos
%token OP_LOGIC	// Operadores logicos
%token OP_COMP		// Operadores de comparacao
%token ID			// Identificador
%token VIRGULA		// Virgula
%token ABRE_PAR	// Abre parenteses
%token FECHA_PAR	// Fecha parenteses
%token PTVIRG		// Ponto e virgula
%token ABRE_CHAVE	// Abre chave
%token FECHA_CHAVE//	Fecha chave
%token ABRE_COL	// Abre colchetes
%token FECHA_COL	// Fecha colchetes
%token ASPAS		// Aspas
%token APOST		// Apostrofo
%token DOISP		// Dois pontos
%token OUTRO		// Outro
%token TIPO			// Tipo
%token FOR			// For
%token IF			// If
%token ELSE			// Else
%token DO			// Do
%token SWITCH		// Switch
%token WHILE		// While
%token TO			// To
%token DESCARTE	// caracateres que serao ignorados
%token CASE			// Case
%token BREAK		// Break

%type <nome> ID
%type <numero> NUM


%union{
	char nome[20];
	int numero;	
}

%%

prog:
	comandos
;

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
	| chamaFunc PTVIRG
	{printf("\n\033[32mCHAMADA DE FUNCAO -> SUCESSO!\033[0m\n");}
	| BREAK PTVIRG
	{printf("\n\033[32mBREAK -> SUCESSO!\033[0m\n");}
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
	| decFunc
	{printf("\n\033[32mDECLARACAO DE FUNCAO -> SUCESSO!\033[0m\n");}
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
	TIPO ID ABRE_PAR listParametros1 FECHA_PAR ABRE_CHAVE comandos FECHA_CHAVE
;

// Parametros que serao utilizados para declaracao da funcao
listParametros1:
	TIPO ID VIRGULA listParametros1 | TIPO ID | %empty
;

// Chamada de funcao
chamaFunc:
	ID ABRE_PAR listParametros2 FECHA_PAR
;

// Parametros que serao utilizados para chamada da funcao
listParametros2:
	ID | ID VIRGULA listParametros2 | %empty
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

void yyerror(char *s) {
	printf("\033[1;31mErro sintatico na linha [%d]\033[0m\n",contLinha);
}
int main() {
	yyparse();
	return 0;
}







