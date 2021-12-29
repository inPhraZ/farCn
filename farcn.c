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
static const char *farcn_reg_valid_ext = ".*[.](farcn|farhn)$";
static regex_t     farcn_reg_t;

// Check if a filename extension is valid
static int is_valid_ext(const char *str)
{
    if (regexec(&farcn_reg_t, str, 0, NULL, 0))
        return 0;
    return 1;
}

static int farcn_yyopen_files(const char *inf, const char *ouf)
{
    return 0;
}

int farcn_main(int argc, char **argv)
{
    int i;
    char *tmp_inf;
    char *tmp_ouf;

    // Mising source files
    if (argc < 2) {
        fprintf(stderr, "Usage: %s  [FILE(s)]\n", argv[0]);
        return EXIT_FAILURE;
    }

    // Initializing farcn_reg_t
    if (regcomp(&farcn_reg_t, farcn_reg_valid_ext, REG_EXTENDED)) {
        fprintf(stderr, "Inner error\n");
        return EXIT_FAILURE;
    }

    // Loop through input files
    for (i = 1; i < argc; ++i) {
        tmp_inf = argv[i];
        if (is_valid_ext(tmp_inf)) {
#if 0
            if (farcn_yyopen_files(tmp_inf, tmp_ouf))
                yylex();
#endif
            continue;
        }
        fprintf(stderr, "%s: file format not recognized\n", tmp_inf);
    }

    return EXIT_SUCCESS;
}
