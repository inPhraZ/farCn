%option noyywrap

%{
#include <stdio.h>
#include "keywords.h"

#define     FARCN_REPLACE(C_Token)  \
    do { fprintf(yyout, C_Token); } while(0)
%}

%%

 /* Keywords for farCn */
"agar"
"joz in agar"
"alamatdar"
"andazeye"
"anjam bede"
"anjoman"
"baraye"
"bargasht"
"beshkan"
"bi alamat"
"birooni"
"boro be"
"do barabar"
"edame bede"
"farrar"
"gozine"
"ista"
"joz in"
"khatti"
"khodkar"
"kootah"
"madamike"
"mahdood"
"mored"
"payan"
"pishfarz"
"sabbat"
"sahih"
"sakhtar"
"shenavar"
"shomaresh"
"taarif kon"
"tohi"
"toolani"

 /* PreProcessors */
"payan agar"
"shamelkon"
"taarif"

%%

int main(int argc, char **argv)
{
    yylex();
    return 0;
}
