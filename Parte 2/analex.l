%{

#include <stdio.h>
#include "y.tab.h"

int contLinha = 0;

%}
descarte 		([ \t])+
numero		([0-9]+(\.[0-9]+)?)
letra			([A-Za-z])
id			({letra}+)
op_logico		("AND"|"OR")
op_arit		("+"|"-"|"/"|"%"|"*")
op_atrib		("=")
op_comp		("=="|"<"|">"|"<="|">="|"!=")
cesp			([(|)|,|;|:|\{|\}|\[|\]|\"|\'])
erro_id_num 	(({id}|{numero})*({id}{numero}|{numero}{id})({id}|{numero})*)+
string		(\".*\")
comentario  	("#".*"#")
virgula		,
abre_parenteses	\(
fecha_parenteses	\)
fim_cmd		;
abre_chave		\{
fecha_chave		\}
abre_colchete	\[
fecha_colchete	\]
apostofro		\'
aspas 		\"
dois_pontos		:


%%
{descarte}
[\n]				{contLinha++;}	
{comentario}
{virgula}			{printf("Virgula: %s \n", yytext); return(VIRGULA);}
{abre_parenteses}		{printf("Abre parenteses: %s \n", yytext); return(ABRE_PAR);}
{fecha_parenteses}	{printf("Fecha parenteses: %s \n", yytext); return(FECHA_PAR);}
{fim_cmd}			{printf("Fim cmd: %s \n", yytext); return(PTVIRG);}
{abre_chave}		{printf("Abre chave: %s \n", yytext); return(ABRE_CHAVE);}
{fecha_chave}		{printf("Fecha chave: %s \n", yytext); return(FECHA_CHAVE);}
{abre_colchete}		{printf("Abre colchete: %s \n", yytext); return(ABRE_COL);}
{fecha_colchete}		{printf("Fecha colchete: %s \n", yytext); return(FECHA_COL);}
{apostofro}			{printf("Apostofro: %s \n", yytext); return(APOST);}
{aspas}			{printf("Aspas: %s \n", yytext); return(ASPAS);}
{dois_pontos}		{printf("Dois pontos: %s \n", yytext); return(DOISP);}
{op_logico}			{printf("Operador logico: %s \n", yytext); return(OP_LOGIC);}
{op_arit}			{printf("Operador aritmético: %s \n", yytext); return(OP_ARIT);}
{op_atrib}			{printf("Operador atribuição: %s \n", yytext); return(OP_ATRIB);}
{op_comp}			{printf("Operador comparação: %s \n", yytext); return(OP_COMP);}
{numero}			{printf("Numero: %s \n", yytext); return(NUM);}
{id}				{printf("Identificador: %s \n", yytext); return(ID);}	
{string}			{printf("String: %s \n", yytext); return(STRING);}
{erro_id_num}		{printf("\033[1;31mErro léxico na linha [%d], não é permitido identificadores com número: \"%s\" \033[0m\n",contLinha, yytext);}	
.				{printf("\033[1;31mErro léxico na linha [%d], caractere \"%s\" não identificado. \033[0m\n", contLinha, yytext);}	

printf("\033[1;31m");
  printf("Hello world\n");
  printf("\033[0m;");


%%

int main() {
	yylex();
	printf("FIM! \n");
}

 
