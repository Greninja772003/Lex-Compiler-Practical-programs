%{
#include <stdio.h>

#include <stdlib.h>


void yyerror(const char *s);

int yylex(void);

%}


%union {

    int num;

}


%token <num> NUMBER

%left '+' '-'

%left '*' '/'

%right UMINUS


%%


input:

    input line

  | /* empty */

  ;


line:

    expr '\n'   { printf("\n"); }

  ;


expr:

    expr '+' expr    { printf("+ "); }

  | expr '-' expr    { printf("- "); }

  | expr '*' expr    { printf("* "); }

  | expr '/' expr    { printf("/ "); }

  | '-' expr %prec UMINUS { printf("~ "); }

  | '(' expr ')'     { /* Grouping */ }

  | NUMBER           { printf("%d ", $1); }

  ;


%%


void yyerror(const char *s) {

    fprintf(stderr, "Error: %s\n", s);

}


int main() {

    printf("Enter an infix expression (e.g., 3 + 4 * (2 - 1)):\n");

    yyparse();

    return 0;

}
