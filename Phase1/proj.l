%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>

	#include "y.tab.h"


	int line = 1;
	extern int scope;

	extern void yyerror(const char *);  
	extern struct node * checksym(char *);

%}
digit	[0-9]
letter	[a-zA-z]
WS  		[ \t\v\f]
%%
[\n]		{ fprintf(yyout, "%s", yytext);line++;	}
\/[\/]+.* ;
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]       { /* DO NOTHING */ }
[/][*]                                    { yyerror("Unterminated comment");}


int			{  fprintf(yyout, "%s", yytext); yylval.ival=0; return(INT); 	}
float		{  fprintf(yyout, "%s", yytext); yylval.ival=1; return(FLOAT); }
char		{  fprintf(yyout, "%s", yytext); yylval.ival=2; return(CHAR); }
void		{  fprintf(yyout, "%s", yytext); yylval.ival=3; return(VOID); }


"#"         {   fprintf(yyout, "%s", yytext); return HASH;    }
include     {   fprintf(yyout, "%s", yytext); return INCLUDE;  }


"math"	    {   fprintf(yyout, "%s", yytext); return MATH; }
"iostream"	{   fprintf(yyout, "%s", yytext); return STDIO; }
"array"	    {   fprintf(yyout, "%s", yytext); return STDLIB; }
"string"	{   fprintf(yyout, "%s", yytext); return STRING; }
"vector"	{   fprintf(yyout, "%s", yytext); return TIME; }


while       {   fprintf(yyout, "%s", yytext); return WHILE;   }
switch		{   fprintf(yyout, "%s", yytext); return SWITCH;   }
case		{   fprintf(yyout, "%s", yytext); return CASE;   }
default		{   fprintf(yyout, "%s", yytext); return DEFAULT;   }
break		{   fprintf(yyout, "%s", yytext); return BREAK;   }

printf 		{   fprintf(yyout, "%s", yytext); return PRINT; }
return 		{   fprintf(yyout, "%s", yytext); return RETURN; }

{letter}({letter}|{digit})*         	    {   fprintf(yyout, "%s", yytext);
												yylval.ptr = checksym(yytext);
												return IDENTIFIER;  
											}

{digit}+\.{digit}+                          {   fprintf(yyout, "%s", yytext);
												yylval.fval=atof(yytext);
									            return FLOAT_LITERAL;   }

{digit}+					    		    {   fprintf(yyout, "%s", yytext);
												yylval.ival=atoi(yytext);
									            return INTEGER_LITERAL; }	

"'"."'"							            {   fprintf(yyout, "%s", yytext);
												yylval.cval= yytext[1];
					                            return CHARACTER_LITERAL;   }

\"({letter}|{digit})+(".h"|".c")\"			{   fprintf(yyout, "%s", yytext); return HEADER_LITERAL;  }

\".*\"							            {   fprintf(yyout, "%s", yytext); return STRING_LITERAL;  }



"+="		{  fprintf(yyout, "%s", yytext); return(ADD_ASSIGN); }
"-="		{  fprintf(yyout, "%s", yytext); return(SUB_ASSIGN); }
"*="		{  fprintf(yyout, "%s", yytext); return(MUL_ASSIGN); }
"/="		{  fprintf(yyout, "%s", yytext); return(DIV_ASSIGN); }
"%="		{  fprintf(yyout, "%s", yytext); return(MOD_ASSIGN); }


"++"		{  fprintf(yyout, "%s", yytext); return(INC_OP); }
"--"		{  fprintf(yyout, "%s", yytext); return(DEC_OP); }
"<="		{  fprintf(yyout, "%s", yytext); return(LE_OP); }
">="		{  fprintf(yyout, "%s", yytext); return(GE_OP); }
"=="		{  fprintf(yyout, "%s", yytext); return(EQ_OP); }
"!="		{  fprintf(yyout, "%s", yytext); return(NE_OP); }



";"			{  fprintf(yyout, "%s", yytext); return(';'); }
"{"			{  fprintf(yyout, "%s", yytext); scope++; return('{'); }
"}"			{  fprintf(yyout, "%s", yytext); return('}'); }
","			{  fprintf(yyout, "%s", yytext); return(','); }
":"			{  fprintf(yyout, "%s", yytext); return(':'); }
"="			{  fprintf(yyout, "%s", yytext); return('='); }
"("			{  fprintf(yyout, "%s", yytext); return('('); }
")"			{  fprintf(yyout, "%s", yytext); return(')'); }
"."			{  fprintf(yyout, "%s", yytext); return('.'); }
"&"			{  fprintf(yyout, "%s", yytext); return('&'); }
"~"			{  fprintf(yyout, "%s", yytext); return('~'); }
"!"			{  fprintf(yyout, "%s", yytext); return('!'); }
"-"			{  fprintf(yyout, "%s", yytext); return('-'); }
"+"			{  fprintf(yyout, "%s", yytext); return('+'); }
"*"			{  fprintf(yyout, "%s", yytext); return('*'); }
"/"			{  fprintf(yyout, "%s", yytext); return('/'); }
"%"			{  fprintf(yyout, "%s", yytext); return('%'); }
"<"			{  fprintf(yyout, "%s", yytext); return('<'); }
">"			{  fprintf(yyout, "%s", yytext); return('>'); }
"?"			{  fprintf(yyout, "%s", yytext); return('?'); }

{WS}+		{ fprintf(yyout, "%s", yytext); /* whitespace separates tokens */}

.           {   printf("No match,Invalid Expression %s\n",yytext);  return yytext[0];}

%%

int yywrap(void){
    return 1;
}