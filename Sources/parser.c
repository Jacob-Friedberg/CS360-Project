#include <stdio.h>
#include "parser.h"

typedef struct yy_buffer_state * YY_BUFFER_STATE;
 
extern YY_BUFFER_STATE yy_scan_string(char * str);
extern void yy_delete_buffer(YY_BUFFER_STATE buffer);

int main( int numArgs, char** args )
{

    char string[] = "city";
    YY_BUFFER_STATE buffer = yy_scan_string(string);
    
    fprintf(stderr,"hello world.\n");
    
    if (yyparse()) return 1;
    printf(mySQLCommand);
    yy_delete_buffer(buffer);
    return 0;
}