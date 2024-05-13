%{
#include <stdio.h>

int yylex();
int yyerror(char *s);
FILE *yyin;
%}

%token 'a'
%token 'b' 
%token 'f' 
%token 't' 
%token 'g' 
%token 'w' 
%token 'm' 
%token '#' 
%token 'o' 
%token 'x' 
%token 'j' 
%token 'h' 
%token 'p' 
%token 'c' 
%token 'q' 
%token 'y' 
%token 'z' // palabras reservadas
%token 'i'
%token 'n' 'r' //constantes numericas
%token 's'
%token '='
%token 'l' 'u' 'e' 'd' 
%token '>'
%token '<'
%token '['
%token ']'
%token '('
%token ')'
%token '{'
%token '}'
%token ','
%token ':'
%token ';'
%token '%'
%token '\\'
%token '^'
%left '>' '<'
%left '+' '-'
%left '*' '/'
%%

program:
    statement
    | program statement
    ;

statement:
    A
    | /* other types of statements */
    ;

A :
    'i' '=' asignacion ';' {printf("Sentencia de asignacion correcta");}
    ;

asignacion: 
    's'
    | expresionAritmetica
    ;
expresionAritmetica:
    'n'
    | 'r'
    | /* other types of expressions */
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
        //Inicia el analisis si se pudo abrir el archivo
        //Se cierra el archivo al finalizar el analisis
        yyparse();
    }
     
    printf("\nBISON finalizo la lectura del archivo %s\n", "inputParser.txt");
    
    fclose(yyin);
    
    return 0;
}

