/*
 * =====================================================================================
 *
 *       Filename:  farcn.c
 *       Author:    Farzin 
 *
 * =====================================================================================
 */

#include <stdlib.h>
#include <stdio.h>
#include <regex.h>

#include "farcn.h"

// regex for valid filename extensions
static const char *farcn_reg_valid_cext = ".*[.](farcn)$";
static const char *farcn_reg_valid_hext = ".*[.](farhn)$";
static regex_t     farcn_reg_c;
static regex_t     farcn_reg_h;

typedef enum {
    INVALID_FILE = -1,
    SOURCE_FILE,
    HEADER_FILE 
} FTYPE;

// Check if a filename extension is valid
static int farcn_get_extension(const char *str)
{
    if (!regexec(&farcn_reg_c, str, 0, NULL, 0))
        return SOURCE_FILE;
    if (!regexec(&farcn_reg_h, str, 0, NULL, 0))
        return HEADER_FILE;
    return INVALID_FILE;
}

#if 0
static char *farcn_get_ouf_name(const char *inf)
{

}
#endif

// open inf as yyin and ouf as yyout
static int farcn_yyopen_files(const char *inf, const char *ouf)
{
    return 0;
}

int farcn_main(int argc, char **argv)
{
    int i;
    FTYPE ftype;
    char *tmp_inf;
    char *tmp_ouf;

    // Mising source files
    if (argc < 2) {
        fprintf(stderr, "Usage: %s  [FILE(s)]\n", argv[0]);
        return EXIT_FAILURE;
    }

    // Initializing farcn_reg_c
    if (regcomp(&farcn_reg_c, farcn_reg_valid_cext, REG_EXTENDED) ||
            regcomp(&farcn_reg_h, farcn_reg_valid_hext, REG_EXTENDED)) {
        fprintf(stderr, "Inner error\n");
        return EXIT_FAILURE;
    }

    // Loop through input files
    for (i = 1; i < argc; ++i) {
        tmp_inf = argv[i];
        ftype = farcn_get_extension(tmp_inf);
        if (ftype == INVALID_FILE)
            fprintf(stderr, "%s: file format not recognized\n", tmp_inf);
#if 0
        if (is_valid_ext(tmp_inf)) {
            tmp_ouf = farcn_get_ouf_name(tmp_inf);
            if (farcn_yyopen_files(tmp_inf, tmp_ouf))
                yylex();
        }
#endif
    }

    return EXIT_SUCCESS;
}
