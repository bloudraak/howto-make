#include <stdio.h>
#include <ctype.h>
#include "caseAB/a.h"
#include "caseAB/b.h"
#include "caseG/g.h"

int main(void)
{
	char x;
	printf("Enter a or b: ");
	scanf("%c", &x);
	x = (char) tolower((int) x);
	switch (x) {
	case 'a':
		a_hello();
		break;
	case 'b':
		b_hello();
		break;
	default:
		goodbye();
		break;
	}
	return 0;
}
