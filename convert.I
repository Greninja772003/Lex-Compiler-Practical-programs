%{
#include "y.tab.h"

#include <string.h>


extern int yylval;

%}


%%

0b[01]+      {

                yylval = strtol(yytext + 2, NULL, 2); // skip "0b"

                return BINARY;

             }

[0-9]+       {

                yylval = atoi(yytext);

                return DECIMAL;

             }

\n           { return EOL; }

.            ;

%%

int yywrap() {

    return 1;

}
