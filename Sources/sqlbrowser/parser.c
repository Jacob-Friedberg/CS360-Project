#include <stdio.h>
#include "parser.h"

typedef struct yy_buffer_state * YY_BUFFER_STATE;
 
extern YY_BUFFER_STATE yy_scan_string(char * str);
extern void yy_delete_buffer(YY_BUFFER_STATE buffer);


int parse(char *s)
{

    fprintf(stderr,"String being parsed: %s\n",s);
    YY_BUFFER_STATE buffer = yy_scan_string(s);



    if (yyparse()) return 1;
    fprintf(stderr,"SQL COMMAND:%s\n",mySQLCommand);
    yy_delete_buffer(buffer);
    return 0;
}


//int main( int numArgs, char** args )
//{

//    char s1[] = "city";
//    YY_BUFFER_STATE buffer = yy_scan_string(s1);
    
//    fprintf(stderr,"hello world.\n");
    
//    if (yyparse()) return 1;

//    char *s=mySQLCommand;

//    while(*s)
//    {
//        printf("[%x] ",*s++);
//    }
//    printf(mySQLCommand);
//    yy_delete_buffer(buffer);
//    return 0;
//}
