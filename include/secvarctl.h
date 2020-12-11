#ifndef SECVARCTL_H
#define SECVARCTL_H
#include <stdint.h> //for uint_16 stuff like that
#include "err.h"
#include "prlog.h"
#include "../backends/edk2-compat/include/edk2-svc.h"


enum backends {
	UNKNOWN_BACKEND = 0,
	EDK2_COMPAT
};

static struct backend {
	char name[32];
	size_t countCmds;
	struct command *commands;
} backends [] = {
	{ .name = "ibm,edk2-compat-v1", .countCmds = sizeof(edk2_compat_command_table) / sizeof(struct command), .commands = edk2_compat_command_table },
};

extern int verbose;


#endif
