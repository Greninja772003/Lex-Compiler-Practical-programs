%{
#include <stdio.h>
#include <string.h>
#include <limits.h>

char smallest[1000];  // buffer for smallest word
int first_word = 1;
%}

%%
[a-zA-Z]+ {
    if (first_word) {
        strcpy(smallest, yytext);
        first_word = 0;
    } else {
        if (strlen(yytext) < strlen(smallest)) {
            strcpy(smallest, yytext);
        }
    }
}
.|\n  ;  // ignore all other characters
%%

int main(int argc, char **argv) {
    yylex();
    if (!first_word)
        printf("Smallest word: %s\n", smallest);
    else
        printf("No valid words found.\n");
    return 0;
}

int yywrap() {
    return 1;
}
