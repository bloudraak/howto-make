#include <stdio.h>
#include <ctype.h>
#include "caseCD/c.h"
#include "caseCD/d.h"
#include "caseG/g.h"

int main(void)
{
#if   defined( ALT1 )
	printf("%s was preprocessed with ALT1 defined.\n", __FILE__);
#elif defined( ALT2 )
	printf("%s was preprocessed with ALT2 defined.\n", __FILE__);
#endif
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
