%{
#include <stdio.h>
#include <string.h>

void reverse(char *str) {
    int i, j;
    char temp;
    int len = strlen(str);
    for (i = 0, j = len - 1; i < j; i++, j--) {
        temp = str[i];
        str[i] = str[j];
        str[j] = temp;
    }
}
%}

%%

[a-zA-Z]+ {
    reverse(yytext);
    printf("%s", yytext);
}

.|\n { // Match everything else (punctuation, whitespace, etc.)
    printf("%s", yytext);
}

%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
