%{
/* Author: Andrew M. Yuan
* modified from the example lexer.l to recognize tokens in the NPC
* description language
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* token number definitions */
#define EOFnumber             0
#define SEMInumber            101
#define COLONnumber           102
#define COMMAnumber           103
#define DOTnumber             104
#define LPARENnumber          105
#define RPARENnumber          106
#define LBRACKETnumber        107
#define RBRACKETnumber        108
#define NPCnumber             109
#define IDnumber              110
#define BEGINnumber           111
#define ENDnumber             112
#define STATEnumber           113
#define TIMEnumber            114
#define RANDOMTIMEnumber      115
#define NUMnumber             116
#define CHANNELnumber         117
#define STRINGnumber          118
#define RANDOMnumber          119
#define ANIMATIONnumber       120
#define SOUNDnumber           121
#define SAYnumber             122
#define USERDEFINEnumber      123
#define RBEGINnumber          124
#define RENDnumber            125
#define ACTIONnumber          126
#define ICONSTnumber          127
#define RAISEHANDSAYnumber    128

#define TOTAL_LENGTH 200000
#define PRIME 997

struct hash_item {
    int index;
    struct hash_item *next;
};

struct hash_item *hash_table[PRIME];
char string_buff[TOTAL_LENGTH];
int string_index;

int yycolumn=1;
int yyline=1;

int put_string(char *s);
int find_index(char *s);
int hash_insert(char *s);
void lex_init();
void mytoupper(char *s, char *s1);
int hashf(char *s);
void string_convert(char *s, char *s1);
void lex_error(char *s, int line, int column);
int yywrap();

%}
a             [aA]
b             [bB]
c             [cC]
d             [dD]
e             [eE]
f             [fF]
g             [gG]
h             [hH]
i             [iI]
j             [jJ]
k             [kK]
l             [lL]
m             [mM]
n             [nN]
o             [oO]
p             [pP]
q             [qQ]
r             [rR]
s             [sS]
t             [tT]
u             [uU]
v             [vV]
w             [wW]
x             [xX]
y             [yY]
z             [zZ]


/*   int yylval.semantic_value; */
%%
";"                            {yycolumn+=yyleng;
                                return(SEMInumber);
                               }
":"                           {yycolumn+=yyleng;
                               return(COLONnumber);
                               }
","                            {yycolumn+=yyleng;
                                return(COMMAnumber);
                               }
"."                           {yycolumn+=yyleng;
                                return(DOTnumber);
                               }
"("                           {yycolumn+=yyleng;
                                return(LPARENnumber);
                               }
")"                            {yycolumn+=yyleng;
                                return(RPARENnumber);
                               }
"["                            {yycolumn+=yyleng;
                                return(LBRACKETnumber);
                               }
"]"                            {yycolumn+=yyleng;
                                return(RBRACKETnumber);
                               }
{n}{p}{c}                      {yycolumn+=yyleng;
                                return(NPCnumber);
                               }
{b}{e}{g}{i}{n}                {yycolumn+=yyleng;
                                return(BEGINnumber);
                               }
{e}{n}{d}                      {yycolumn+=yyleng;
                                return(ENDnumber);
                               }
{s}{t}{a}{t}{e}                {yycolumn+=yyleng;
                                return(STATEnumber);
                               }
{t}{i}{m}{e}                   {yycolumn+=yyleng;
                                return(TIMEnumber);
                               }
{r}{a}{n}{d}{o}{m}{t}{i}{m}{e} {yycolumn+=yyleng;
                                return(RANDOMTIMEnumber);
                               }
{n}{u}{m}                      {yycolumn+=yyleng;
                                return(NUMnumber);
                               }
{c}{h}{a}{n}{n}{e}{l}          {yycolumn+=yyleng;
                                return(CHANNELnumber);
                               }
{r}{a}{n}{d}{o}{m}             {yycolumn+=yyleng;
                                return(RANDOMnumber);
                               }
{a}{n}{i}{m}{a}{t}{i}{o}{n}    {yycolumn+=yyleng;
                                return(ANIMATIONnumber);
}
{r}{a}{i}{s}{e}{h}{a}{n}{d}{s}{a}{y} {
                                yycolumn += yyleng;
                                return(RAISEHANDSAYnumber);
                               }
{s}{o}{u}{n}{d}                {yycolumn+= yyleng;
                                return(SOUNDnumber);
                               }
{s}{a}{y}                      {yycolumn+=yyleng;
                                return(SAYnumber);
                               }
{u}{s}{e}{r}{d}{e}{f}{i}{n}{e} {yycolumn+=yyleng;
                                return(USERDEFINEnumber);
                               }
{r}{b}{e}{g}{i}{n}             {yycolumn+=yyleng;
                                return(RBEGINnumber);
                               }
{r}{e}{n}{d}                   {yycolumn+=yyleng;
                                return(RENDnumber);
                               }
{a}{c}{t}{i}{o}{n}             {yycolumn+=yyleng;
                                return(ACTIONnumber);
                               }
[a-zA-Z_][a-zA-Z_0-9]*         {
                                yycolumn+=yyleng;
                                yylval.semantic_value=hash_insert(yytext);
                                return(IDnumber);
                               }
[+-][0-9]+                     {yycolumn+=yyleng;
                                sscanf(yytext,"%d",&yylval.semantic_value);
                                return(ICONSTnumber);
                               }
[0-9]+                         {yycolumn+=yyleng;
                                sscanf(yytext,"%d",&yylval.semantic_value);
                                return(ICONSTnumber);
                               }
\"[^\"\n]*                     {
                                 int i,j;
                                 char c, temp[1000];
  
                                 c=input();
                                 if (c!='\"') {
                                    lex_error("unclosed string",yyline,
                                      yycolumn);
                                      unput(c);
                                  } else {
                                    unput(c);
                                    if (yytext[yyleng-1] == '\\') {
                                      yycolumn+=yyleng;
                                      i=yyleng-1; j=0;
                                      while(yytext[i]=='\\'){
                                         i--;j++;}
                                      if (j%2 != 0)
                                        yymore();
                                      else {
                                        input(); yycolumn+=1;
                                        if (yyleng==2) 
                                           lex_error("improper char '\'",
                                            yyline,yycolumn-2);
                                         string_convert(yytext+1, temp);
                                         yylval.semantic_value=put_string(temp);
                                         return(STRINGnumber);
                                      }
                                 }                        
                                 else {
                                   input();yycolumn+=yyleng+1;
                                   string_convert(yytext+1, temp);
                                   yylval.semantic_value=put_string(temp);
                                   return(STRINGnumber);}
                                 }
                               }
"/*"                           {
                                 char c1, c2;
                                 int line, column;
                                 c2 = input();
                                 line = yyline; column = yycolumn;
                                 if (c2 <= 0) {
                                   printf("unended comment, line=%d column=%d\n",
                                   line,column);
                                 } else {
                                   if (c2 == '\n') {
                                     line++; column=1;
                                   } else column ++;
                                   c1 = c2;
                                   c2 = input();
                                   while (((c1 != '*') ||
                                          (c2 != '/')) &&
                                          (c2 > 0)) {
                                     if (c2 == '\n') {
                                       line++; column=1;
                                     } else column ++;
                                     c1 = c2;
                                     c2 = input();
                                   } 
                                   if (c2 <= 0) {
                                     printf("unended comment, line=%d column=%d\n",
                                   line,column);
                                   } else {yyline = line; yycolumn = column;}
                                 }
                               }                                 
\n                             {
                                yyline++;yycolumn=1;
                               }
\t                             yycolumn+=8;
" "                            yycolumn+=1;
.                          { char temp[80];
                             sprintf(temp, "improper character '%s'",yytext);
                             lex_error(temp,yyline,yycolumn);
                             yycolumn+=1;
                           }



%%

void lex_error(char *s, int line, int column)
{
    printf("%s, line=%d column=%d\n",s,line,column);
}


void string_convert(char *s, char *s1)
{
    char *t1,*t2;
    
    t1=s; t2=s1;

    while (*t1 != '\0') {
        if (*t1 != '\\') {
            *t2=*t1;
        } else {
            switch (*(t1+1)) {
                case 'n' : t1++; *t2='\n'; break;
                case 't' : t1++; *t2='\t'; break;
                case '\\' : t1++; *t2='\\'; break;
                case '\"' : t1++; *t2='\"';  break;
                default : *t2=*t1; 
            }
        }
        t1++;t2++;
    }
    *t2='\0';
}

/* hash function */


int hashf(char *s)
{
    char *p;
    unsigned h=0,g;
    for(p=s; *p!='\0'; p++) {
        h = (h << 4) + (*p);
        if (g == (h&0xf0000000)) {
            h = h ^ (g >>24);
            h = h^g;
        }
    }
    return(h % PRIME);
}

/* change the string to uppercase */

void mytoupper(char *s, char *s1)
{
    char *p,*p1;
    p=s;
    p1=s1;
    while(*p!='\0') {
        if ((*p>='a') && (*p<='z')) *p1= *p+'A'-'a';
        else *p1= *p;
        p++;
        p1++;
    }
    *p1='\0';
}

/* init all data type */

void lex_init()
{

    int i,j,k;

    for(i=0; i<PRIME; i++) 
        hash_table[i]=NULL;
    string_index=0;
}

/* search to see if it is in the table
 * if yes, return the position value;
 * else insert item in hash table 
 */

int hash_insert(char *s)     /* string to be find */
{
    int i,j,k;
    int index;
    char *temp;
    struct hash_item *p1;

    temp=(char *)malloc(strlen(s)+1);
    /*mytoupper(s,temp); */
    strcpy(temp, s);
    index=hashf(temp);
    p1=hash_table[index];
    i=1;
    while ((p1!=NULL) && i) {
        if (strcmp(string_buff+p1->index, temp) == 0) 
            i=0;
        else p1=p1->next;
    }

    if (p1==NULL) { /* new item */
        p1=(struct hash_item *)malloc(sizeof(struct hash_item));
        p1->index=string_index;
        strcpy(string_buff+string_index,temp);
        string_index+=strlen(temp)+1;
        p1->next=hash_table[index];
        hash_table[index]=p1;
    }
    free(temp);
    return(p1->index);
}

int find_index(char *s)  /* string to be find */
{
    int i,j,k;
    int index;
    char *temp;
    struct hash_item *p1;

    temp=(char *)malloc(strlen(s)+1);
    /* mytoupper(s,temp); */
    strcpy(temp, s);
    index=hashf(temp);
    p1=hash_table[index];
    i=1;
    while ((p1!=NULL) && i) {
        if (strcmp(string_buff+p1->index, temp) == 0) 
            i=0;
        else p1=p1->next;
    }
    free(temp);
    if (p1 == NULL) return(-1);
    else return(p1->index);
}

int put_string(char *s)
{
    strcpy(string_buff+string_index,s);
    string_index+=strlen(s)+1;
    return(string_index-strlen(s)-1);
}

int yywrap()
{  if (feof(stdin)) return 1;
return 0;
}

