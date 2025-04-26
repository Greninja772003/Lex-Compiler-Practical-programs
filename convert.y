%{
#include <stdio.h>

#include <stdlib.h>


void dec_to_bin(int n);

int yylex(void);

void yyerror(const char *s);

%}


%token BINARY DECIMAL EOL


%%

input:

    input line

  | /* empty */

  ;


line:

    BINARY EOL    { printf("Decimal: %d\n", $1); }

  | DECIMAL EOL   { 

                    printf("Binary: ");

                    dec_to_bin($1); 

                    printf("\n");

                  }

  ;

%%


void yyerror(const char *s) {

    fprintf(stderr, "Error: %s\n", s);

}


void dec_to_bin(int n) {

    if (n == 0) {

        printf("0");

        return;

    }


    int bin[32], i = 0;

    while (n > 0) {

        bin[i++] = n % 2;

        n = n / 2;

    }

    for (int j = i - 1; j >= 0; j--)

        printf("%d", bin[j]);

}


int main() {

    printf("Enter a number (prefix binary with 0b):\n");

    yyparse();

    return 0;

}

