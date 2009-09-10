#include <stdio.h>
#include <ctype.h>
#include "caseAB/a.h"
#include "b.h"
#include "caseG/g.h"
#include "h.h"

int main(void)
{
	char x;
	printf("Enter a, b, or h: ");
	scanf("%c", &x);
	x = tolower(x);
	switch (x) {
	case 'a':
		a_hello();
		break;
	case 'b':
		b_hello();
		break;
	case 'h':
		h_hello();
		break;
	default:
		goodbye();
		break;
	}
	return 0;
}
