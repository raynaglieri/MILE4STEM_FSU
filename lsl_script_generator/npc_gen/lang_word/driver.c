/* #include "token.h" */
union {
  int semantic_value;
  float fvalue;
} yylval, yyval;

#include "lex.yy.c"

char output1[100][20]={"EOFtoken", "SEMItoken", "COLONtoken", "COMMAtoken",
     "DOTtoken", "LPARENtoken", "RPARENtoken", "LBRACKETtoken", 
		       "RBRACKETtoken", "NPCtoken", "IDtoken", "BEGINtoken",
     "ENDtoken", "STATEtoken", "TIMEtoken", 
     "RANDOMTIMEtoken", "NUMtoken", "CHANNELtoken", "STRINGtoken",
     "RANDOMtoken", "ANIMATIONtoken", "SOUNDtoken", 
     "SAYtoken", "USERDEFINEtoken", "RBEGINtoken",
		       "RENDtoken", "ACTIONtoken", "ICONSTtoken", "RAISEHANDSAYtoken"};

int main()
{

    int i;
    while ((i=yylex())!=EOFnumber) {
        switch(i) {
	case IDnumber :
            printf("%14s, %s\n", 
                   output1[i-100], string_buff+yylval.semantic_value);
            break;
	case STRINGnumber:
            printf("%14s, string='%s'\n", 
                   output1[i-100],string_buff+yylval.semantic_value);
            break;
	  case ICONSTnumber :
            printf("%14s, %d\n",output1[i-100],yylval.semantic_value);
            break;
          default :
            printf("%14s\n",output1[i-100]);
	}       
    }
    printf("%14s\n","EOFtoken");
    return 0;
}

