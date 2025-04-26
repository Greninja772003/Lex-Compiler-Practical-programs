%{
#include <stdio.h>

#include <stdlib.h>

#include <ctype.h>

#include <string.h>


#define MAX 100


// Stack for evaluation of postfix expression

int stack[MAX];

int top = -1;


void push(int val) {

    stack[++top] = val;

}


int pop() {

    if (top == -1) return -1; // Stack underflow error

    return stack[top--];

}


int peek() {

    if (top == -1) return -1;

    return stack[top];

}


int precedence(char op) {

    switch(op) {

        case '+':

        case '-': return 1;

        case '*':

        case '/': return 2;

        default: return 0;

    }

}


// Evaluate a simple operator

int apply_operator(int val1, int val2, char operator) {

    switch (operator) {

        case '+': return val1 + val2;

        case '-': return val1 - val2;

        case '*': return val1 * val2;

        case '/': return val1 / val2;

        default: return 0;

    }

}


int yywrap() {

    return 1;  // Return 1 to signal end of input

}

%}


%%

[0-9]+      { push(atoi(yytext)); }   // Push number to stack

"("         { push('('); }

")"         {

                while (peek() != '(') {

                    int val2 = pop();

                    int val1 = pop();

                    char operator = pop();

                    push(apply_operator(val1, val2, operator));

                }

                pop(); // Remove '('

            }

[+\-*/]     { 

                while (top >= 2 && precedence(peek()) >= precedence(yytext[0])) {

                    int val2 = pop();

                    int val1 = pop();

                    char operator = pop();

                    push(apply_operator(val1, val2, operator));

                }

                push(yytext[0]);

            }

\n          { 

                while (top > 0) { // Process remaining operators

                    int val2 = pop();

                    int val1 = pop();

                    char operator = pop();

                    push(apply_operator(val1, val2, operator));

                }

                printf("Result: %d\n", pop());  // The result is in the top of the stack

            }

[ \t]       ; // Ignore whitespace


.           { printf("Invalid character: %s\n", yytext); }


%%


int main() {

    printf("Enter an infix expression to evaluate (e.g., 3 + 4 * (2 - 1)):\n");

    yylex();

    return 0;

}


