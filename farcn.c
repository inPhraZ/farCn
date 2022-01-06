/*
 * =====================================================================================
 *
 *       Filename:  farcn.c
 *       Author:    Farzin 
 *
 * =====================================================================================
 */

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>
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

static char *farcn_get_ouf_name(const char *inf, const FTYPE ftype)
{
    char *ouf, *ext;
    if (!inf)
        return NULL;

    size_t infs = strnlen(inf, NAME_MAX);
    ext = strrchr(inf, '.');
    ouf = (char *)malloc(infs);
    if (!ouf || !ext)
        return NULL;

    memset(ouf, 0, infs);
    memmove(ouf, inf, ext - inf);
    if (ftype == SOURCE_FILE)
        strncat(ouf, ".c", 3);
    else if (ftype == HEADER_FILE)
        strncat(ouf, ".h", 3);
    else
        return NULL;
    return ouf;
}

// open inf as yyin and ouf as yyout
static int farcn_yyopen_files(const char *inf, const char *ouf)
{
    char response[32];

    if (access(inf, F_OK) == -1) {
        perror(inf);
        return -1;
    }

    if (access(ouf, F_OK) == 0) {
        // don't overwrite existing file
        fprintf(stderr, "Warning: %s allready exist\n", ouf);
        return -1;
    }

    // open inf as yyin
    yyin = fopen(inf, "r");
    if (!yyin) {
        perror(inf);
        return -1;
    }

    // open ouf as yyout
    yyout = fopen(ouf, "w");
    if (!yyout) {
        perror(ouf);
        return -1;
    }

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

    // Initializing regex_t
    if (regcomp(&farcn_reg_c, farcn_reg_valid_cext, REG_EXTENDED) ||
            regcomp(&farcn_reg_h, farcn_reg_valid_hext, REG_EXTENDED)) {
        fprintf(stderr, "Inner error\n");
        return EXIT_FAILURE;
    }

    // Loop through input files
    for (i = 1; i < argc; ++i) {
        tmp_inf = argv[i];
        ftype = farcn_get_extension(tmp_inf);
        if (ftype == INVALID_FILE) {
            fprintf(stderr, "%s: file format not recognized\n", tmp_inf);
            continue;
        }
        tmp_ouf = farcn_get_ouf_name(tmp_inf, ftype);
        printf("Converting %s to %s\n", tmp_inf, tmp_ouf);
        if (farcn_yyopen_files(tmp_inf, tmp_ouf) != -1) {
            yylex();
            fclose(yyin);
            fclose(yyout);
        }
        free(tmp_ouf);
    }

    // Free regex_t
    regfree(&farcn_reg_c);
    regfree(&farcn_reg_h);

    return EXIT_SUCCESS;
}
