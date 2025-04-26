%{
#include <stdio.h>

#include <math.h>


int binary_to_decimal(const char *binary) {

    int decimal = 0;

    for (int i = 0; binary[i] != '\0'; i++) {

        decimal = decimal * 2 + (binary[i] - '0');

    }

    return decimal;

}

%}


%%

[01]+ {

    int decimal = binary_to_decimal(yytext);

    printf("Binary: %s -> Decimal: %d\n", yytext, decimal);

}

.|\n    ; // Ignore other characters

%%


int main(int argc, char **argv) {

    yylex();

    return 0;

}


int yywrap() {

    return 1;

}
