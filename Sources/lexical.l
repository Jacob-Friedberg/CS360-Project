%{
%}

%%
[\n]                    {myLineNumber++;}
[ \t\f\r]+              {;}


Project                 {yylval = "Project"; return PROJECT; }
"\xCE\xA0"              {yylval = "Project"; return PROJECT; }
Select                  {yylval = "Select"; return SELECT; }
"\xCF\x83"              {yylval = "Select"; return SELECT; }
And                     {yylval = "And"; return AND; }
Or                      {yylval = "Or"; return OR; }

Union                    {yylval = "Union"; return UNION; }
Join                     {yylval = "Join"; return JOIN; }
"\xE2\x8B\x88"           {yylval = "Join"; return JOIN; }
Difference               {yylval = "Difference"; return DIFFERENCE; }
Intersect                {yylval = "Intersect"; return INTERSECT; }
Product                  {yylval = "Product"; return PRODUCT; }

"="                       {yylval = "="; return EQUAL; }
"<"                       {yylval = "<"; return LESS_THAN; }
">"                       {yylval = ">"; return GREATER_THAN; }
"<="                      {yylval = "="; return LESS_THAN_EQAUAL; }
">="                      {yylval = ">="; return GREATER_THAN_EQUAL; }
"<>"                      {yylval = "<>"; return NOT_EQUAL;}

[0-9]+                  { yylval = mystringcopy(yytext); return DIGITS; }
[A-Za-z][A-Za-z0-9_]*   { yylval = mystringcopy(yytext); return ID; }
.                       { yylval = mystringcopy(yytext); return yytext[0]; }
%%

int myLineNumber = 1;
int yywrap(void)
{
    return 1;
}

/* Create a copy if string in its own buffer */
char *mystringcopy( char *s )
{
    char *newS = (char *)malloc( strlen(s)+1 );

    if (newS == NULL)
    {
        fprintf(stderr, "Malloc failure\n");
        exit(1);
    }

    strcpy( newS, s );

    return newS;
}   

/* Cat string b onto a in its own buffer */
char *mystringcat( char *a, char *b )
{
    char *newS = (char *)malloc( strlen(a)+strlen(b)+1 );

    if (newS == NULL)
    {
        fprintf(stderr, "Malloc failure\n");
        exit(1);
    }

    strcpy( newS, a );
    strcat( newS, b );

    return newS;
}   

/* Cat string c onto b onto a in its own buffer */
char *mystringcat3( char *a, char *b, char *c)
{
    char *newS = (char *)malloc( strlen(a)+strlen(b)+strlen(c)+1 );

    if (newS == NULL)
    {
        fprintf(stderr, "Malloc failure\n");
        exit(1);
    }

    strcpy( newS, a );
    strcat( newS, b );
    strcat( newS, c );
    
    return newS;
}   
/* Cat string d onto c onto b onto a in its own buffer */
char *mystringcat4( char *a, char *b, char *c, char *d)
{
    char *newS = (char *)malloc( strlen(a)+strlen(b)+strlen(c)+strlen(d)+1 );

    if (newS == NULL)
    {
        fprintf(stderr, "Malloc failure\n");
        exit(1);
    }

    strcpy( newS, a );
    strcat( newS, b );
    strcat( newS, c );
    strcat( newS, d );
    
    return newS;
}   