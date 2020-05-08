%{
    #define YYSTYPE char *
    #include <stdio.h>
    #include "parser.h"

    char *mySQLCommand; 
%}

%token ID DIGITS 
%token LESS_THAN GREATER_THAN LESS_THAN_EQAUAL GREATER_THAN_EQUAL NOT_EQUAL EQUAL
%token UNION JOIN DIFFERENCE INTERSECT PRODUCT
%token PROJECT SELECT
%token AND OR
%%
command: relational_expression 
        { mySQLCommand = mystringcat($1,"\n"); }
    | relational_name EQUAL relational_expression
        { mySQLCommand = mystringcat(mystringcat(mystringcat($1,"="),$3),"\n"); }
    ;

relational_expression: unary_term
        { $$ = $1; }
    | binary_term
        { $$ = $1; }
    | relational_name 
        { $$ = $1; }      
    ;

unary_term: PROJECT '(' attribute_list ')' '(' relational_expression ')' 
        { $$ = mystringcat(mystringcat(mystringcat("SELECT ", $3), "\n" ), $6); }

    | SELECT '(' relational_expression ')' '(' qualification ')' 
        { $$ = mystringcat(mystringcat("FROM ", $3), "\n"); 
          $$ = mystringcat(mystringcat( $$, "WHERE " ), $6 ); }
    ;

attribute_list: attribute_name
        { $$ = $1; }
    | attribute_name ',' attribute_list  
        { $$ = mystringcat(mystringcat( $1, "," ),$3); }  
    ;
qualification: attribute_comp 
    | attribute_comp and_or qualification
        { $$ = mystringcat(mystringcat( $1, $2 ), $3); }
    ;
binary_term: '(' relational_expression ')' operator '(' relational_expression ')'
        { $$ = mystringcat(mystringcat( $2, $4 ), $6); }
    |   JOIN '(' relational_expression ')' '(' relational_expression ')' '(' qualification ')'
        { $$ = mystringcat3(mystringcat4( "SELECT * \nFROM ", $3, "\nNATURAL JOIN ", $6 ),"\nWHERE ", $9); }
    |   JOIN '(' relational_expression ')' '(' relational_expression ')'
        { $$ = mystringcat4( "SELECT * \nFROM ", $3, "\nNATURAL JOIN ", $6 ); }
    ;
operator: UNION
        { $$ = $1; }
    | PRODUCT
        { $$ = $1; }
    | DIFFERENCE
        { $$ = $1; }
    | INTERSECT
        { $$ = $1; }
    ;
attribute_comp: attribute_name comparator attribute_name_value
        { $$ = mystringcat(mystringcat( $1, $2 ), $3 );}
    ; 
attribute_name_value: attribute_name
        { $$ = mystringcat(mystringcat("'",$1),"'"); }
    | value
        { $$ = $1; }
    ;

comparator: LESS_THAN
        { $$ = $1; }
    | GREATER_THAN
        { $$ = $1; }
    | LESS_THAN_EQAUAL
        { $$ = $1; }
    | GREATER_THAN_EQUAL
        { $$ = $1; }
    | NOT_EQUAL
        { $$ = $1; }
    | EQUAL
        { $$ = $1; }
    ;

and_or: AND
        { $$ = mystringcat3(" ", $1, " "); }
    | OR 
        { $$ = mystringcat3(" ", $1, " "); }
    ;

attribute_name: id
        { $$ = $1;}
    |   id '.' id
        { $$ = mystringcat(mystringcat($1,"."),$3);}
    ;
relational_name: id
        { $$ = $1;}
    ;
id  : ID
        { $$ = $1; }

value: DIGITS
        { $$ = $1; }
    ;
%%

#include "lexical.c"

yyerror(char *s)
{
    printf( "we have a problem: '%s'\nValue: '%s'\nLineNum:%d\n ", s,yytext,myLineNumber);
}
