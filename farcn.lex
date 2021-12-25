%option noyywrap

%{
#include <stdio.h>
#include "keywords.h"

#define     FARCN_REPLACE(C_Token)  \
    do { fprintf(yyout, C_Token); } while(0)
%}

%%

 /* Keywords for farCn */
"agar"                  { FARCN_REPLACE(C_IF);      }
"alamatdar"             { FARCN_REPLACE(C_SIGNED);  }
"andazeye"              { FARCN_REPLACE(C_SIZEOF);  }
"anjam bede"            { FARCN_REPLACE(C_DO);      }
"anjoman"               { FARCN_REPLACE(C_UNION);   }
"baraye"                { FARCN_REPLACE(C_FOR);     }
"bargasht"              { FARCN_REPLACE(C_RETURN);  }
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
"mahdood"               { FARCN_REPLACE(C_RESTRICT);}
"mored"                 { FARCN_REPLACE(C_CASE);    }
"payan"                 { FARCN_REPLACE(C_CONST);   }
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

%%

int main(int argc, char **argv)
{
    yylex();
    return 0;
}
