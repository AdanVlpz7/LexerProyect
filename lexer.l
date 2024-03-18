/* TOKENS */

ID [\$(([a-zA-z])+)]
ENTERO10 [(0|([1-9]([0-9]?)+))]
ENTERO8 [(O|o)(0|([1-7]([0-7]?)+))]
REAL [(([1-9]([0-9]?)+\.([0-9]+))|\.([0-9]+)) ]
CTE_CAD []
SIMBOLO ["[](){},:;"]
OPERADOR ["+-*/%\^"]
OP_ASIGN ["="]
OP_REL [[<>]=?|==]

SALTO [ \t\n]+


%%


%%