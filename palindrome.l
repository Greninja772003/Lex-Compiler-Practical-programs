%{
#include "y.tab.h"

%}


%%

[a-z]+     { yylval.str = strdup(yytext); return STRING; }

\n         { return EOL; }

.          ; // ignore all other characters

%%

int yywrap() {

    return 1;

}
