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

#define     FARCN_REPLACE(C_Token)  \
    do { fprintf(yyout, C_Token); } while(0)

#if defined(__linux__)
#include <linux/limits.h>
#else
#define NAME_MAX        255
#endif

#endif      /*  __FARCN_LAN_H_ */
