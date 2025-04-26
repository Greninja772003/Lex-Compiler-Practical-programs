%{
#include <stdio.h>

#include <stdlib.h>

#include <string.h>

#include <ctype.h>


#define MAX 100


char stack[MAX];

int top = -1;


// Stack operations

void push(char ch) {

    stack[++top] = ch;

}


char pop() {

    if (top == -1) return '\0';

    return stack[top--];

}


char peek() {

    if (top == -1) return '\0';

    return stack[top];

}


// Operator precedence

int precedence(char op) {

    switch(op) {

        case '+':

        case '-': return 1;

        case '*':

        case '/': return 2;

        default: return 0;

    }

}


void print_remaining_stack() {

    while (top != -1) {

        printf("%c ", pop());

    }

}


// Disable yywrap requirement

int yywrap() {

    return 1;

}

%}


%%

[0-9]+      { printf("%s ", yytext); }


"("         { push('('); }


")"         {

              while (peek() != '(' && top != -1)

                  printf("%c ", pop());

              pop(); // Discard '('

            }


[+\-*/]     {

              while (precedence(peek()) >= precedence(yytext[0]))

                  printf("%c ", pop());

              push(yytext[0]);

            }


\n          {

              print_remaining_stack();

              printf("\n");

              top = -1;

            }


[ \t]       ; // Ignore spaces/tabs


.           { printf("Invalid character: %s\n", yytext); }


%%


int main() {

    printf("Enter an infix expression (e.g., 3+4*(2-1)) and press Enter:\n");

    yylex();

    return 0;

}

