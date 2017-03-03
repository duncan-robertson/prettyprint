grammar PrettyPrinter;

@members {
    int l = 0;
    public void indent() {
        for(int i=0; i<l; i++) {
            System.out.printf("  ");
        }
    }
}

selector : ('.' IDENT{System.out.printf(".%s", $IDENT.text);} 
         | '['{System.out.printf("[");} expression ']'{System.out.printf("]");})*;
factor : IDENT{System.out.printf("%s", $IDENT.text);} selector
       | INTEGER{System.out.printf("%s", $INTEGER.text);}
       | '('{System.out.printf("(");} expression ')'{System.out.printf(")");}
       | 'not'{System.out.printf("not ");} factor;
term : factor ({System.out.printf(" ");}
     ('*' {System.out.printf("*");}
     | 'div' {System.out.printf("*");}
     | 'mod' {System.out.printf("*");}
     | 'and' {System.out.printf("*");}){System.out.printf(" ");} factor)*;
simpleExpr : ('+'{System.out.printf("+");} 
           | '-'{System.out.printf("-");})? term (('+'{System.out.printf(" + ");}
           | '-'{System.out.printf(" - ");}
           | 'or'{System.out.printf(" or ");}) term)*;
expression : simpleExpr ({System.out.printf(" ");} 
           ('=' {System.out.printf("=");}
           | '<>' {System.out.printf("<>");}
           | '<' {System.out.printf("<");}
           | '<=' {System.out.printf("<=");}
           | '>' {System.out.printf(">");}
           | '>='{System.out.printf(">=");}){System.out.printf(" ");} simpleExpr)*;

assignment : IDENT{System.out.printf("%s", $IDENT.text);} selector ':='{System.out.printf(" := ");} expression;
actualParameters : '('{System.out.printf("(");} (expression (','{System.out.printf(", ");} expression)*)? ')'{System.out.printf(")");};
procedureCall : IDENT{System.out.printf("%s", $IDENT.text);} selector actualParameters?;
compoundStatement : 'begin'{System.out.printf("begin\n");l+=1;indent();}
                  statement (';'{System.out.printf(";\n");indent();} statement)*
                  {System.out.printf("\n");l-=1;indent();} ('end'{System.out.printf("end");} | 'end.'{System.out.printf("end.");});
ifStatement : 'if'{System.out.printf("if ");} expression 'then'{System.out.printf(" then\n");l+=1;indent();} statement {l-=1;}
            ('else'{System.out.printf("\n");indent();System.out.printf("else\n");l+=1;indent();} statement {l-=1;})?;
whileStatement : 'while'{System.out.printf("while ");} expression
               'do'{System.out.printf(" do\n");l+=1;indent();} statement{l-=1;};
statement : (assignment | procedureCall | compoundStatement | ifStatement | whileStatement)?;

identList : IDENT{System.out.printf("%s", $IDENT.text);} (',' IDENT{System.out.printf(", %s", $IDENT.text);})*;
arrayType : 'array' '['{System.out.printf("array [");} expression '..'{System.out.printf(" .. ");} 
          expression ']' 'of'{System.out.printf("] of ");} type;
fieldList : (identList ':'{System.out.printf(": ");} type)?;
recordType : 'record'{System.out.printf("record\n");l+=1;indent();} 
           fieldList (';'{System.out.printf(";\n");indent();} fieldList)* 'end'{System.out.printf("\n");l-=1;indent();System.out.printf("end");};
type : IDENT{System.out.printf("%s", $IDENT.text);} 
     | {System.out.printf("\n");l+=1;indent();}arrayType{l-=1;}
     | {System.out.printf("\n");l+=1;indent();}recordType{l-=1;};
fpSection : ('var'{System.out.printf("var ");})? identList ':'{System.out.printf(": ");} type;
formalParameters : '('{System.out.printf("(");} (fpSection (';'{System.out.printf(";\n\n");indent();} fpSection)*)? ')'{System.out.printf(")");};
procedureDeclaration : 'procedure' IDENT{System.out.printf("procedure %s", $IDENT.text);}
                     formalParameters? ';'{System.out.printf(";\n\n");} declarations compoundStatement;
declarations : ('const'{l+=1;indent();System.out.printf("const\n");l+=1;indent();} 
               (IDENT '='{System.out.printf("%s = ", $IDENT.text);} expression ';'{System.out.printf(";\n\n");l-=2;indent();})*)?
               ('type'{l+=1;indent();System.out.printf("type\n");l+=1;indent();}
               (IDENT '='{System.out.printf("%s = ", $IDENT.text);} type ';'{System.out.printf(";\n\n");l-=2;indent();})*)? 
               ('var'{l+=1;indent();System.out.printf("var\n");l+=1;indent();}
               (identList ':'{System.out.printf(": ");} type ';'{System.out.printf(";\n");indent();})*{System.out.printf("\n");l-=2;indent();})? 
               ({l+=1;indent();}procedureDeclaration ';'{System.out.printf(";\n\n");l-=1;indent();})*;

r : 'program' IDENT ';' {System.out.printf("program %s;\n\n", $IDENT.text);indent();} declarations compoundStatement;

IDENT : [A-Za-z][A-Za-z0-9]*;
INTEGER : [0-9]+;
WS : [ \t\r\n]+ -> skip;
