%{
#include "y.tab.h"

%}


%%

[0-9]+        { yylval.num = atoi(yytext); return NUMBER; }

[+\-*/()]     { return yytext[0]; }

[ \t]         ;   // ignore whitespace

\n            { return '\n'; }

.             { printf("Unknown character: %s\n", yytext); }

%%

int yywrap() {

    return 1;

}
