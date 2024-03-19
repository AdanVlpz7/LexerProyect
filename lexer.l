%{
    #include <string.h> //Para manejar las cadenas
    #include <stdio.h>
    #include <stdlib.h> // Agregamos esta inclusión para strdup
    FILE *yyin;     //Para abrir el archivo

    //CHECAR ESTA PARTE
    char *tab_op_rel[] = {"<", ">", "<=", ">=", "==", "!="};  //Tabla de op. relacionales

    char *tab_lit_num[50];          //Tabla para almacenar las literales numericas
    int indice_tab_lit_num = 0;     //Indice para agregar las literales numericas

    char *tab_lit_cad[50];          //Tabla para almacenar las cadenas
    int indice_tab_lit_cad = 0;         //Indice para agregar las cadenas

    //Estructura para almacenar los identificadores
    struct Tabla_simbolos {
        int posicion;
        char identificador[20];
        int tipo;
    };
    struct Tabla_simbolos simbolos[50]; //Se genera la tabla de simbolos
    int indice_tab_simb = 0;        //Indice para agregar identificadores


    char *tabla_tokens[50];                                     //Tabla para guardar los tokens
    int indice_tabla_tokens = 0;                                //Indice para agregar los tokens

    char *tabla_no_reconocidos[50];         //Tabla para almacenar lo que no reconozca el analizador
    int indice_no_reconocidos = 0;          //Indice para agregar los errores

    //Funcion para buscar las coincidencias con las tablas de palabras reservadas, op. asig y op. rel.
    int buscarCadena(char *cadena, char *arreglo[], int longitud) {
        for (int i = 0; i < longitud; i++) {
            if (strcmp(cadena, arreglo[i]) == 0) {
                return i;
            }
        }
        return -1;
    }

    //Funcion para almacenar los errores en la tabla
    int noReconocido(void){
        tabla_no_reconocidos[indice_no_reconocidos] = strdup(yytext);
        indice_no_reconocidos++;
    }
%}

/* TOKENS */ 
ID \$[a-zA-Z]+
ENTERO10 [0|[1-9][0-9]*]
ENTERO8 [(O|o)(0|([1-7]([0-7]?)+))]
NUM_REAL [(([1-9]([0-9]?)+\.([0-9]+))|\.([0-9]+)) ]
CTE_CAD \"([^"]|\\.)*\"|'([^']|\\.)*'

DELIMITADOR [ \t\n]+

%%

"alternative"      { printf("Palabra reservada: alternative\n"); char token[20]; snprintf(token, sizeof(token), "(0, 0)"); tabla_tokens[indice_tabla_tokens] = strdup(token); indice_tabla_tokens++; }
"big"       { printf("Palabra reservada: big\n"); char token[20]; snprintf(token, sizeof(token), "(0, 1)"); tabla_tokens[indice_tabla_tokens] = strdup(token); indice_tabla_tokens++;}
"evaluate"  { printf("Palabra reservada: evaluate\n"); char token[20]; snprintf(token, sizeof(token), "(0, 2)"); tabla_tokens[indice_tabla_tokens] = strdup(token); indice_tabla_tokens++;}
"instead"   { printf("Palabra reservada: instead\n"); char token[20]; snprintf(token, sizeof(token), "(0, 3)"); tabla_tokens[indice_tabla_tokens] = strdup(token); indice_tabla_tokens++;}
"large"      { printf("Palabra reservada: large\n"); char token[20]; snprintf(token, sizeof(token), "(0, 4)"); tabla_tokens[indice_tabla_tokens] = strdup(token); indice_tabla_tokens++;}
"loop"      { printf("Palabra reservada: loop\n"); char token[20]; snprintf(token, sizeof(token), "(0, 5)"); tabla_tokens[indice_tabla_tokens] = strdup(token); indice_tabla_tokens++;}
"make"      { printf("Palabra reservada: make\n"); char token[20]; snprintf(token, sizeof(token), "(0, 6)"); tabla_tokens[indice_tabla_tokens] = strdup(token); indice_tabla_tokens++;}
"number"      { printf("Palabra reservada: number\n"); char token[20]; snprintf(token, sizeof(token), "(0, 7)"); tabla_tokens[indice_tabla_tokens] = strdup(token); indice_tabla_tokens++;}
"other"      { printf("Palabra reservada: other\n"); char token[20]; snprintf(token, sizeof(token), "(0, 8)"); tabla_tokens[indice_tabla_tokens] = strdup(token); indice_tabla_tokens++;}
"real"      { printf("Palabra reservada: real\n"); char token[20]; snprintf(token, sizeof(token), "(0, 9)"); tabla_tokens[indice_tabla_tokens] = strdup(token); indice_tabla_tokens++;}
"repeat"      { printf("Palabra reservada: repeat\n"); char token[20]; snprintf(token, sizeof(token), "(0, 10)"); tabla_tokens[indice_tabla_tokens] = strdup(token); indice_tabla_tokens++;}
"select"      { printf("Palabra reservada: select\n"); char token[20]; snprintf(token, sizeof(token), "(0, 11)"); tabla_tokens[indice_tabla_tokens] = strdup(token); indice_tabla_tokens++;}
"small"      { printf("Palabra reservada: small\n"); char token[20]; snprintf(token, sizeof(token), "(0, 12)"); tabla_tokens[indice_tabla_tokens] = strdup(token); indice_tabla_tokens++;}
"step"      { printf("Palabra reservada: step\n"); char token[20]; snprintf(token, sizeof(token), "(0, 13)"); tabla_tokens[indice_tabla_tokens] = strdup(token); indice_tabla_tokens++;}
"stop"      { printf("Palabra reservada: stop\n"); char token[20]; snprintf(token, sizeof(token), "(0, 14)"); tabla_tokens[indice_tabla_tokens] = strdup(token); indice_tabla_tokens++;}
"symbol"      { printf("Palabra reservada: symbol\n");char token[20]; snprintf(token, sizeof(token), "(0, 15)"); tabla_tokens[indice_tabla_tokens] = strdup(token); indice_tabla_tokens++; }
"throw"      { printf("Palabra reservada: throw\n"); char token[20]; snprintf(token, sizeof(token), "(0, 16)"); tabla_tokens[indice_tabla_tokens] = strdup(token); indice_tabla_tokens++;}

\$[a-zA-Z]+ {
    //Clase 1

    char *texto = yytext;
    //Se llena la tabla de simbolos
    simbolos[indice_tab_simb].posicion = indice_tab_simb;
    strcpy(simbolos[indice_tab_simb].identificador, texto);
    simbolos[indice_tab_simb].tipo = -1;

    // Construir el token correctamente
    char token[20]; // Ajusta el tamaño según las necesidades

    //Se le asigna el numero de clase con la posicion en la tabla
    snprintf(token, sizeof(token), "(1, %d)", indice_tab_simb);
        
    // Almacena el token en la tabla_tokens
    tabla_tokens[indice_tabla_tokens] = strdup(token);
    indice_tabla_tokens++;
    indice_tab_simb++;

}


[ENTERO10]|[ENTERO8] {
    //Clase 2

    char *texto = yytext;
    //Almacena la constante en la tabla de constantes numericas
    //printf("%s",texto);
    //for(int i = 0; i < yytext.length; i++){
        tab_lit_num[indice_tab_lit_num] = strdup(texto);
        
    //}
    printf(tab_lit_num[indice_tab_lit_num]);


    // Construir el token correctamente
    char token[20]; // Ajusta el tamaño según las necesidades
    snprintf(token, sizeof(token), "(2, %d)", indice_tab_lit_num);
        
    // Almacena el token en la tabla_tokens
    tabla_tokens[indice_tabla_tokens] = strdup(token);
    indice_tabla_tokens++;
    indice_tab_lit_num++;
}

(([1-9][0-9]*\.[0-9]+)|(\.[0-9]+)) {
    //Clase 3

    char *texto = yytext;
    //Almacena la constante en la tabla de constantes numericas
    tab_lit_num[indice_tab_lit_num] = strdup(texto);


    // Construir el token correctamente
    char token[20]; // Ajusta el tamaño según tus necesidades
    snprintf(token, sizeof(token), "(3, %d)", indice_tab_lit_num);
        
    // Almacena el token en la tabla_tokens
    tabla_tokens[indice_tabla_tokens] = strdup(token);
    indice_tabla_tokens++;
    indice_tab_lit_num++;
}

\"([^"]|\\.)*\"|'([^']|\\.)*' {
    //Clase 4

    char *texto = yytext;
    printf("Cadena detectada: %s\n", texto); // Agregar mensaje de depuración
    //Almacena la cadena en la tabla de literales
    tab_lit_cad[indice_tab_lit_cad] = strdup(texto);

    // Construir el token correctamente
    char token[20]; // Ajusta el tamaño según tus necesidades
    snprintf(token, sizeof(token), "(4, %d)", indice_tab_lit_cad);
        
    // Almacena el token en la tabla_tokens
    tabla_tokens[indice_tabla_tokens] = strdup(token);
    indice_tabla_tokens++;
    indice_tab_lit_cad++;
}

[\[\]\(\)\{\},:;] {
    //Lectura de simbolos
    //Clase 5

    char *texto = yytext;
    // Construir el token correctamente
    char token[20]; // Ajusta el tamaño según las necesidades
    snprintf(token, sizeof(token), "(5, %s)", texto);
        
    // Almacena el token en la tabla_tokens
    tabla_tokens[indice_tabla_tokens] = strdup(token);
    indice_tabla_tokens++;
}

[+\-*/%\\^] {
    //Clase 6

    char *texto = yytext;
    //Se llama a la funcion para buscar el operador en la tabla
    // Construir el token correctamente
    char token[20]; // Ajusta el tamaño según las necesidades
    snprintf(token, sizeof(token), "(6, %c)", texto[0]);
        
    // Almacena el token en la tabla_tokens
    tabla_tokens[indice_tabla_tokens] = strdup(token);
    indice_tabla_tokens++;
}


[<>]=?|==|!= {
    //Clase 7 - Operadores relacionales
    char *texto = yytext;
    //Se llama a la funcion para buscar el operador en la tabla
    int posicion = buscarCadena(texto, tab_op_rel, 6);
    if (posicion != -1) {

        // Construir el token correctamente
        char token[20]; // Ajusta el tamaño según las necesidades

        //Se le asigna el numero de clase con la posicion en la tabla
        snprintf(token, sizeof(token), "(7, %d)", posicion);
        
        // Almacena el token en la tabla_tokens
        tabla_tokens[indice_tabla_tokens] = strdup(token);
        indice_tabla_tokens++;
    }
}

[=] {
    //Clase 8

    char *texto = yytext;
    //Se llama a la funcion para buscar el operador en la tabla
    // Construir el token correctamente
    char token[20]; // Ajusta el tamaño según las necesidades
    snprintf(token, sizeof(token), "(8, =)");
        
    // Almacena el token en la tabla_tokens
    tabla_tokens[indice_tabla_tokens] = strdup(token);
    indice_tabla_tokens++;
}
.   noReconocido();

%%

int yywrap() {
    return 1; // Indica que no hay más datos de entrada disponibles
}

int main(int argc, char *argv[]) {
    //Aqui se verifica la apertura del archivo 
    if ((yyin = fopen(argv[1], "rt")) == NULL) {
        printf("\nNo se puede abrir el archivo: %s\n", argv[1]);
        return 1;
    } else {
        printf("\nEl archivo %s se abrio correctamente\n", argv[1]);
        //Inicia el analisis si se pudo abrir el archivo
        yylex();
    }
    printf("\nFLEX finalizo la lectura del archivo %s\n", argv[1]);
    //Se cierra el archivo al finalizar el analisis
    fclose(yyin);

    //Se imprime la tabla de simbolos
    printf("\nTabla de simbolos\n");
    FILE* tablaSimbolosTxt;
    tablaSimbolosTxt = fopen("tablaSimbolos.txt","wt");
    for (int i=0; i < indice_tab_simb; i++){
        //escribir en archivo Tabla de Simbolos
        char aux[21]; //cadena que se agregara en archivo tabla tokens
        //sprintf("%d\t%s\t%d\n",simbolos[i].posicion,simbolos[i].identificador,simbolos[i].tipo);
        //fputs(aux,tablaSimbolosTxt);
        printf("%d\t%s\t%d\n",simbolos[i].posicion,simbolos[i].identificador,simbolos[i].tipo);
    }
    fclose(tablaSimbolosTxt);

    //Se imprime la tabla de cadenas
    printf("\nTabla de literales(cadenas)\n");
    FILE* tablaLitCadTxt;
    tablaLitCadTxt = fopen("tablaLiteralesCad.txt","wt");
    for(int i=0; i < indice_tab_lit_cad; i++){
        if(tab_lit_cad[i]){
            char aux[21]; //cadena que se agregara en archivo tabla tokens
            sprintf(aux, "(%d,%s)\n",i,tab_lit_cad[i]);
            fputs(aux,tablaLitCadTxt);
            printf("%d     %s\n",i,tab_lit_cad[i]);
        }
    }
    fclose(tablaLitCadTxt);

    //Se imprime la tabla de literales numericas
    printf("\nTabla de literales(numericas)\n");
    FILE* tablaLitNumTxt;
    tablaLitNumTxt = fopen("tablaLiteralesNum.txt","wt");
    for(int i=0; i < indice_tab_lit_num; i++){
        if(tab_lit_num[i]){
            char aux[21]; //cadena que se agregara en archivo tabla tokens
            sprintf(aux, "(%d,%s)\n",i,tab_lit_num[i]);
            fputs(aux,tablaLitNumTxt);
            printf("%d     %s\n",i,tab_lit_num[i]);
        }
    }
    fclose(tablaLitNumTxt);

    //Se imprime la tabla de tokens
    printf("\nTokens\n");
    //abre archivo para escribir la tabla
    FILE* tablaTokensTxt;
    tablaTokensTxt = fopen("tablaTokens.txt","wt");
    for (int i = 0; i < indice_tabla_tokens; i++) {
        if (tabla_tokens[i]) {
            char aux[21]; //cadena que se agregara en archivo tabla tokens
            sprintf(aux, "%s\n",tabla_tokens[i]);
            fputs(aux,tablaTokensTxt);
            printf("%s\n",tabla_tokens[i]);
        }
    }
    fclose(tablaTokensTxt);

    //Se imprime la tabla de los no no reconocidos
    printf("\nErrores:\n");
    for (int i=0; i < indice_no_reconocidos; i++){
        if (tabla_no_reconocidos[i]){
            printf("%s no reconocido\n",tabla_no_reconocidos[i]);
        }
    }

    return 0;
}