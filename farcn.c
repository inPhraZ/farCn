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

static const char *farcn_reg_valid_ext = ".*[.](c|h|farcn|farhn)$";
static regex_t     farcn_reg_t;

// check if a filename extension is valid
static int is_valid_ext(const char *str)
{
    if (regexec(&farcn_reg_t, str, 0, NULL, 0))
        return 0;
    return 1;
}

int farcn_main(int argc, char **argv)
{
    int i;

    if (argc < 2) {
        fprintf(stderr, "Usage: %s  [FILE(s)]\n", argv[0]);
        return EXIT_FAILURE;
    }

    if (regcomp(&farcn_reg_t, farcn_reg_valid_ext, REG_EXTENDED)) {
        fprintf(stderr, "Inner error\n");
        return EXIT_FAILURE;
    }

    for (i = 1; i < argc; ++i) {
        if (is_valid_ext(argv[i])) {
            printf("%s has valid extension\n", argv[i]);
            continue;
        }
        fprintf(stderr, "%s: file format not recognized\n", argv[i]);
    }
    return EXIT_SUCCESS;
}
