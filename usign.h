/*
 * usign/signify API header
 * Copyright (C) 2018 Daniel Golle <daniel@makrotopia.org>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3
 * as published by the Free Software Foundation
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

#ifndef _USIGN_H
#define _USIGN_H

/**
 * Verify
 *
 * calls: usign -V ...
 */
int usign_v(const char *msgfile, const char *pubkeyfile,
	    const char *pubkeydir, const char *sigfile, bool quiet);

/**
 * Sign
 *
 * calls: usign -S ...
 */
int usign_s(const char *msgfile, const char *seckeyfile, const char *sigfile, bool quiet);

/**
 * Fingerprint {pubkey, seckey, sig}
 *
 * calls: usign -F ...
 */
int usign_f_pubkey(char *fingerprint, const char *pubkeyfile);

int usign_f_seckey(char *fingerprint, const char *seckeyfile);

int usign_f_sig(char *fingerprint, const char *sigfile);

/**
 * custom extension to check for revokers
 */
int _usign_key_is_revoked(const char *fingerprint, const char *pubkeydir);

#endif /* _USIGN_H */
