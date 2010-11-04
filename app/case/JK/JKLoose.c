#include <stdio.h>
#include <ctype.h>
#include "j.h"
#include "k.h"
#include "caseG/g.h"

int main(void)
{
	char x;
	printf("Enter j or k: ");
	scanf("%c", &x);
	x = tolower(x);
	switch (x) {
	case 'j':
		j_hello();
		break;
	case 'k':
		k_hello();
		break;
	default:
		goodbye();
		break;
	}
	return 0;
}
