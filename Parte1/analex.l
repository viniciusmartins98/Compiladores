%{

#include <stdio.h>
int contLinha = 0;

%}
descarte 	([ \t])+
numero	([0-9]+(\.[0-9]+)?)
letra		([A-Za-z])
id		({letra}+)
op_logico	("AND"|"OR")
op_arit	("+"|"-"|"/"|"%"|"*")
op_atrib	("=")
op_comp	("=="|"<"|">"|"<="|">="|"!=")
cesp		([(|)|,|;|:|\{|\}|\[|\]|\"|\'])
erro_id_num (({id}|{numero})*({id}{numero}|{numero}{id})({id}|{numero})*)+
string	(\".*\")
comentario  ("#".*"#")

%%
{descarte}
[\n]				{contLinha++;}	
{comentario}
{cesp}			{printf("Caractere especial: %s \n", yytext);}
{op_logico}		{printf("Operador logico: %s \n", yytext);}
{op_arit}		{printf("Operador aritmético: %s \n", yytext);}
{op_atrib}		{printf("Operador atribuição: %s \n", yytext);}
{op_comp}		{printf("Operador comparação: %s \n", yytext);}
{numero}			{printf("Numero: %s \n", yytext);}
{id}				{printf("Identificador: %s \n", yytext);}	
{string}			{printf("String: %s \n", yytext);}
{erro_id_num}	{printf("\033[1;31mErro léxico na linha [%d], não é permitido identificadores com número: \"%s\" \033[0m\n",contLinha, yytext);}	
.					{printf("\033[1;31mErro léxico na linha [%d], caractere \"%s\" não identificado. \033[0m\n", contLinha, yytext);}	

printf("\033[1;31m");
  printf("Hello world\n");
  printf("\033[0m;");


%%

int main() {
	yylex();
	printf("FIM! \n");
}

 
