/*
 * =====================================================================================
 *
 *       Filename:  farcn.h
 *       Author:    Farzin
 *
 * =====================================================================================
 */

#ifndef     __FARCN_LANG_H_
#define     __FARCN_LANG_H_

#if defined(__linux__)
#include <linux/limits.h>
#else
#define NAME_MAX        255
#endif

#define     FARCN_REPLACE(C_Token)  \
    do { fprintf(yyout, C_Token); } while(0)

// lex input fileptr
extern FILE *yyin;
// lex output fileptr
extern FILE *yyout;

// lex routine
extern int yylex();

extern int farcn_main(int argc, char **argv);

#endif      /*  __FARCN_LAN_H_ */
