#include <stdio.h>
#include <ctype.h>
#include "lib/h.h"
#include "lib/i.h"

int main(void)
{
	char x;
	printf("Enter h or i: ");
	scanf("%c", &x);
	x = tolower(x);
	switch (x) {
	case 'h':
		h_hello();
		break;
	case 'i':
		i_hello();
		break;
	default:
		printf("You failed to enter h or i.\n");
		break;
	}
	return 0;
}
