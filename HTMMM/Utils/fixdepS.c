/*
 * Copyright 2009, Steven A. Siano
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * This file is fixdepS.c.  It is a simplified fixdep.c.  This simplified
 * version should build on non-POSIX systems since it does not use memory
 * mapping (and does not need to #include <sys/mman.h>).  Also, this simplified
 * version does not include the functionality for dealing with the autoconf
 * issues of the Linux kernel build.
 *
 * The original fixdep.c should be included in this dir and begins with the
 * following documentation:
 *
 * * "Optimize" a list of dependencies as spit out by gcc -MD
 * * for the kernel build
 * * ===========================================================================
 * *
 * * Author       Kai Germaschewski
 * * Copyright    2002 by Kai Germaschewski  <kai.germaschewski@gmx.de>
 * *
 * * This software may be used and distributed according to the terms
 * * of the GNU General Public License, incorporated herein by reference.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define RECORD_LENGTH 1024

char *depfile;
char *target;
char *cmdline;

void usage(void)
{
	fprintf(stderr, "Usage: fixdep <depfile> <target> <cmdline>\n");
	exit(1);
}

/*
 * Print out cmd_<target> := <cmdline>
 */
void print_cmdline(void)
{
	printf("cmd_%s := %s\n\n", target, cmdline);
}

/*
 * Print out:
 *
 * * deps_<target> := \
 * *   <prerequisite1> \
 * *   .
 * *   .
 * *   .
 * *   <prerequisiteN> \
 * *
 * *   <target>: $(deps_<target>)
 * *
 * *   $(deps_<target>):
 *
 * The prerequisites are obtained from the depfile, which is generated by "gcc
 * -MD".
 */
void print_deps(void)
{
	FILE *fp;
	char record[RECORD_LENGTH + 1];

	if ( ( fp = fopen(depfile, "r" ) ) == NULL ) {
		fprintf(stderr, "fixdep: cannot open %s\n", depfile);
		exit(2);
	}
	// The first string from the depfile should be "<target>:", which can be
	// discarded.
	if ( ( fscanf(fp, "%s", record) ) == EOF ) {
		fprintf(stderr, "fixdep: %s is empty\n", depfile);
		fclose(fp);
		return;
	}
	printf("deps_%s := \\\n", target);
	while ( fscanf( fp, "%s", record ) != EOF ) {
		if ( ! strcmp(record, "\\") )
			continue;
		printf("  %s \\\n", record);
	}
	printf("\n%s: $(deps_%s)\n\n", target, target);
	printf("$(deps_%s):\n", target);

	fclose(fp);
}

int main(int argc, char *argv[])
{
	if (argc != 4)
		usage();

	depfile = argv[1];
	target  = argv[2];
	cmdline = argv[3];

	print_cmdline();
	print_deps();

	return 0;
}
