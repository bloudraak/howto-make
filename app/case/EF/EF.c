#include <stdio.h>
#include <ctype.h>
#include "caseEF/e.h"
#include "caseEF/f.h"
#include "caseG/g.h"

int main(void)
{
	char x;
	printf("Enter e or f: ");
	scanf("%c", &x);
	x = (char) tolower((int) x);
	switch (x) {
	case 'e':
		e_hello();
		break;
	case 'f':
		f_hello();
		break;
	default:
		goodbye();
		break;
	}
	return 0;
}
