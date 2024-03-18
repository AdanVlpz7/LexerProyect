
%{
#include <stdio.h>
%}

/* TOKENS */

ID [\$(([a-zA-z])+)]
ENTERO10 [(0|([1-9]([0-9]?)+))]
ENTERO8 [(O|o)(0|([1-7]([0-7]?)+))]
NUM_REAL [(([1-9]([0-9]?)+\.([0-9]+))|\.([0-9]+)) ]
CTE_CAD []
SIMBOLO [[](){},:;]
OPERADOR [+-*/%\^]
OP_ASIGN ["="]
OP_REL [[<>]=?|==]

SALTO [ \t\n]+


%%

/* Palabras reservadas */

"alternative"      { printf("Palabra reservada: alternative\n"); }
"big"       { printf("Palabra reservada: big\n"); }
"evaluate"  { printf("Palabra reservada: evaluate\n"); }
"instead"   { printf("Palabra reservada: instead\n"); }
"large"      { printf("Palabra reservada: large\n"); }
"loop"      { printf("Palabra reservada: loop\n"); }
"make"      { printf("Palabra reservada: make\n"); }
"number"      { printf("Palabra reservada: number\n"); }
"other"      { printf("Palabra reservada: other\n"); }
"real"      { printf("Palabra reservada: real\n"); }
"repeat"      { printf("Palabra reservada: repeat\n"); }
"select"      { printf("Palabra reservada: select\n"); }
"small"      { printf("Palabra reservada: small\n"); }
"step"      { printf("Palabra reservada: step\n"); }
"stop"      { printf("Palabra reservada: stop\n"); }
"symbol"      { printf("Palabra reservada: symbol\n"); }
"throw"      { printf("Palabra reservada: throw\n"); }


%%

int main(int argc, char *argv[]) {
    //abrir archivo que se pasara por consola al compilar (Input.txt)
    FILE *archivo = fopen(argv[1], "r");
    if (!archivo) {
        printf("Error al abrir el archivo");
        return 1;
    }
    yyin = archivo;

    yylex();

    fclose(archivo); //cerrar archivo Input.txt
    return 0;
}