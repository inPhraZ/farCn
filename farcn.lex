%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>

#include "keywords.h"

#define     FARCN_REPLACE(C_Token)  \
    do { fprintf(yyout, C_Token); } while(0)

#ifndef     NAME_MAX
#define     NAME_MAX    255
#endif

%}

%%

 /* Keywords for farCn */
"agar"                  { FARCN_REPLACE(C_IF);      }
"alamatdar"             { FARCN_REPLACE(C_SIGNED);  }
"andazeye"              { FARCN_REPLACE(C_SIZEOF);  }
"anjam bede"            { FARCN_REPLACE(C_DO);      }
"anjoman"               { FARCN_REPLACE(C_UNION);   }
"asli"                  { FARCN_REPLACE(C_MAIN);    }
"baraye"                { FARCN_REPLACE(C_FOR);     }
"bargard"               { FARCN_REPLACE(C_RETURN);  }
"beshkan"               { FARCN_REPLACE(C_BREAK);   }
"bi alamat"             { FARCN_REPLACE(C_UNSIGNED);}
"birooni"               { FARCN_REPLACE(C_EXTERN);  }
"boro be"               { FARCN_REPLACE(C_GOTO);    }
"do barabar"            { FARCN_REPLACE(C_DOUBLE);  }
"edame bede"            { FARCN_REPLACE(C_CONTINUE);}
"farrar"                { FARCN_REPLACE(C_VOLATILE);}
"gozine"                { FARCN_REPLACE(C_SWITCH);  }
"ista"                  { FARCN_REPLACE(C_STATIC);  }
"joz in agar"           { FARCN_REPLACE(C_ELSEIF);  }
"joz in"                { FARCN_REPLACE(C_ELSE);    }
"khatti"                { FARCN_REPLACE(C_INLINE);  }
"khodkar"               { FARCN_REPLACE(C_AUTO);    }
"kootah"                { FARCN_REPLACE(C_SHORT);   }
"madamike"              { FARCN_REPLACE(C_WHILE);   }
"monhaser"              { FARCN_REPLACE(C_RESTRICT);}
"mored"                 { FARCN_REPLACE(C_CASE);    }
"payani"                { FARCN_REPLACE(C_CONST);   }
"pishfarz"              { FARCN_REPLACE(C_DEFAULT); }
"sabbat"                { FARCN_REPLACE(C_REGISTER);}
"sahih"                 { FARCN_REPLACE(C_INT);     }
"sakhtar"               { FARCN_REPLACE(C_STRUCT);  }
"shenavar"              { FARCN_REPLACE(C_FLOAT);   }
"shomaresh"             { FARCN_REPLACE(C_ENUM);    }
"taarif kon"            { FARCN_REPLACE(C_TYPEDEF); }
"tohi"                  { FARCN_REPLACE(C_VOID);    }
"toolani"               { FARCN_REPLACE(C_LONG);    }

 /* PreProcessors */
"payan agar"            { FARCN_REPLACE(C_ENDIF);   }
"shamelkon"             { FARCN_REPLACE(C_INCLUDE); }
"taarif"                { FARCN_REPLACE(C_DEFINE);  }

 /* Identifier */
[_a-zA-Z][_0-9a-zA-Z]+  { FARCN_REPLACE(yytext);    }

 /* Don't change comments */
\/\/(.*)                { FARCN_REPLACE(yytext);    }   // single line
\/\*(.*\n)*.*\*\/       { FARCN_REPLACE(yytext);    }   // multiline

%%

int yyopen_files(const char *inf, const char *ouf)
{
    yyin = fopen(inf, "r");
    if (!yyin) {
        perror(inf);
        return 1;
    }

    yyout = fopen(ouf, "w");
    if (!yyout) {
        perror(ouf);
        return 1;
    }
    return 0;
}

int main(int argc, char **argv)
{
    
    if (!argv[1]) {
        printf("Usage: %s  [input file]\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    char *index;
    char *inf = argv[1];
    index = strstr(inf, ".farcn");
    if (!index) {
        fprintf(stderr, "file format not recognized\n");
        exit(EXIT_FAILURE);
    }

    char *ouf = (char *)malloc(NAME_MAX);
    if (!ouf) {
        perror("malloc");
        exit(EXIT_FAILURE);
    }
    memset(ouf, 0, NAME_MAX);
    memmove(ouf, inf, index - inf);
    strncat(ouf, ".c", 3);

    if (yyopen_files(inf, ouf))
        exit(EXIT_FAILURE);

    yylex();
    return 0;
}
