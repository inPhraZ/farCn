%option noyywrap

%{
#include "tokens.h"
#include "farcn.h"
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
"taarifshode"           { FARCN_REPLACE(C_DEFINED); }

 /* Identifier */
[_a-zA-Z][_0-9a-zA-Z]+  { FARCN_REPLACE(yytext);    }

 /* Don't change comments */
\/\/(.*)                { FARCN_REPLACE(yytext);    }   // single line
\/\*(.*\n)*.*\*\/       { FARCN_REPLACE(yytext);    }   // multiline

%%

int main(int argc, char **argv)
{
    return farcn_main(argc, argv);
}
