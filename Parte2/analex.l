%{

#include <stdio.h>
#include "parser.tab.h"

extern int contLinha;

%}
descarte 		    	 (" "|\t|\r)+

tipo			          ("num"|"char"|"bool")
for			            ("for")
if				          ("if")
else			          ("else")
do				          ("do")
switch		          ("switch")
while			          ("while")
to				          ("to")
case 						 ("case")
break						 ("break")

numero		          ([0-9]+(\.[0-9]+)?)
letra			          ([A-Za-z])
id			             ({letra}+)
op_logico	          ("AND"|"OR")
op_arit		          ("+"|"-"|"/"|"%"|"*")
op_atrib	         	 ("=")
op_comp		          ("=="|"<"|">"|"<="|">="|"!=")

cesp			          ([(|)|,|;|:|\{|\}|\[|\]|\"|\'])
erro_id_num 	       (({id}|{numero})*({id}{numero}|{numero}{id})({id}|{numero})*)+
string		          (\".*\")
comentario  	       ("#".*"#")
virgula		          ,
abre_parenteses	    \(
fecha_parenteses	    \)
fim_cmd		          ;
abre_chave		       \{
fecha_chave		       \}
abre_colchete	       \[
fecha_colchete	       \]
apostofro		       \'
aspas 		          \"
dois_pontos	  	       :


%%

[\n]					 {contLinha++;}	

{descarte}

{comentario}		 {printf("\n%s\n", yytext);}

{tipo}			    {printf("%s ", yytext); return(TIPO);}

{for}              {printf("%s ", yytext); return(FOR);}

{if}				    {printf("%s ", yytext); return(IF);}

{else}			    {printf("%s ", yytext); return(ELSE);}

{do}				    {printf("%s ", yytext); return(DO);}

{switch}		       {printf("%s ", yytext); return(SWITCH);}

{while}            {printf("%s ", yytext); return(WHILE);}

{to}	     			 {printf("%s ", yytext); return(TO);}

{case}	     		 {printf("%s ", yytext); return(CASE);}

{break}				 {printf("%s ", yytext); return(BREAK);}

{virgula}	       {printf("%s ", yytext); return(VIRGULA);}

{abre_parenteses}  {printf("%s ", yytext); return(ABRE_PAR);}

{fecha_parenteses} {printf("%s ", yytext); return(FECHA_PAR);}

{fim_cmd}		    {printf("%s ", yytext); return(PTVIRG);}

{abre_chave}		 {printf("%s ", yytext); return(ABRE_CHAVE);}

{fecha_chave}	    {printf("%s ", yytext); return(FECHA_CHAVE);}

{abre_colchete}	 {printf("%s ", yytext); return(ABRE_COL);}

{fecha_colchete}   {printf("%s ", yytext); return(FECHA_COL);}

{apostofro}			 {printf("%s ", yytext); return(APOST);}

{aspas}			    {printf("%s ", yytext); return(ASPAS);}

{dois_pontos}		 {printf("%s ", yytext); return(DOISP);}

{op_logico}			 {printf("%s ", yytext); return(OP_LOGIC);}

{op_arit}			 {printf("%s ", yytext); return(OP_ARIT);}

{op_atrib}			 {printf("%s ", yytext); return(OP_ATRIB);}

{op_comp}			 {printf("%s ", yytext); return(OP_COMP);}

{numero}			    {printf("%s ", yytext); return(NUM);}

{id}				    {printf("%s ", yytext); return(ID);}	

{erro_id_num}		 {printf("\033[1;31mErro léxico na linha [%d], não é permitido identificadores com número: \"%s\" \033[0m\n",contLinha, yytext);}	
.				       {printf("\033[1;31mErro léxico na linha [%d], caractere \"%s\" não identificado. \033[0m\n", contLinha, yytext);}	


%%
 
