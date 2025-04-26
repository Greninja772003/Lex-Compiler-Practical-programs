%{
#include <stdio.h>

#include <string.h>

#include <stdlib.h>


void yyerror(const char *s);

int yylex(void);


%}


%union {

    char *str;

}


%token <str> STRING

%token EOL


%%


input:

    input line

  | /* empty */

  ;


line:

    STRING EOL {

        int len = strlen($1);

        int is_palindrome = 1;

        for (int i = 0; i < len / 2; i++) {

            if ($1[i] != $1[len - 1 - i]) {

                is_palindrome = 0;

                break;

            }

        }

        if (is_palindrome)

            printf("Palindrome \n");

        else

            printf("Not a palindrome \n");

        free($1);

    }

  ;


%%


void yyerror(const char *s) {

    fprintf(stderr, "Error: %s\n", s);

}


int main() {

    printf("Enter a lowercase word to check for palindrome:\n");

    yyparse();

    return 0;

}
