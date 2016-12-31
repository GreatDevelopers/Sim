%{
#include <cstdio>
#include <iostream>
using namespace std;
#define YY_DECL extern "C" int yylex()

#include "grammar.tab.h"  // to get the token types that we return

%}

%%
\n  {return EF;}
";"   {return SC;}
"JOINT COORDINATES" {return JC;}
[-+]?[0-9]*\.?[0-9]*    { yylval.ival = atof(yytext); return INT; }
.
%%
