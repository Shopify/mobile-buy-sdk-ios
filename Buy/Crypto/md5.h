/*
 * This is an OpenSSL-compatible implementation of the RSA Data Security, Inc.
 * MD5 Message-Digest Algorithm (RFC 1321).
 *
 * Homepage:
 * http://openwall.info/wiki/people/solar/software/public-domain-source-code/md5
 *
 * Author:
 * Alexander Peslyak, better known as Solar Designer <solar at openwall.com>
 *
 * This software was written by Alexander Peslyak in 2001.  No copyright is
 * claimed, and the software is hereby placed in the public domain.
 * In case this attempt to disclaim copyright and place the software in the
 * public domain is deemed null and void, then the software is
 * Copyright (c) 2001 Alexander Peslyak and it is hereby released to the
 * general public under the following terms:
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted.
 *
 * There's ABSOLUTELY NO WARRANTY, express or implied.
 *
 * See md5.c for more information.
 */

#include <stdlib.h>

/* Any 32-bit or wider unsigned integer data type will do */
typedef unsigned int MD5_Int32;

struct _MD5_CTX {
    MD5_Int32 lo, hi;
    MD5_Int32 a, b, c, d;
    unsigned char buffer[64];
    MD5_Int32 block[16];
};

typedef struct _MD5_CTX MD5_CTX;

extern void MD5_Init(MD5_CTX * _Nonnull ctx);
extern void MD5_Update(MD5_CTX * _Nonnull ctx, const void * _Nonnull data, unsigned long size);
extern void MD5_Final(unsigned char * _Nonnull result, MD5_CTX * _Nonnull ctx);
