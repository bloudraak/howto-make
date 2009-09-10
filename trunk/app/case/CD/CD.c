#include <stdio.h>
#include <ctype.h>
#include "caseCD/c.h"
#include "caseCD/d.h"
#include "caseG/g.h"

int main(void)
{
	char x;
	printf("Enter c or d: ");
	scanf("%c", &x);
	x = tolower(x);
	switch (x) {
	case 'c':
		c_hello();
		break;
	case 'd':
		d_hello();
		break;
	default:
		goodbye();
		break;
	}
	return 0;
}
