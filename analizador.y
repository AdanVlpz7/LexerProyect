%{
#include <stdio.h>

int yylex();
int yyerror(char *s);
extern FILE *yyin;
int Programa();

%}

%start program
%token i 

%%

program:
    i {printf("detecto identificador");} 
    ;

%%
int yyerror(char *s)
{
	printf("Syntax Error on line %s\n", s);
	return 0;
}

int Programa()
{
    printf("\nEmpezo analisis sintactico");
    //Aqui se verifica la apertura del archivo 
    if ((yyin = fopen("inputParser.txt", "rt")) == NULL) {
        printf("\nNo se puede abrir el archivo: %s\n", "inputParser.txt");
        return 1;
    } else {
        printf("\nEl archivo %s se abrio correctamente\n", "inputParser.txt");
        if(yyparse() == 0)
            printf("El analisis sintactico fue exitoso\n");
        
    }
    
    printf("\nBISON finalizo la lectura del archivo %s\n", "inputParser.txt");
    
    fclose(yyin);
    
    return 0;
}

