#include <stdio.h>
#include "caseG/g.h"

#if   CAPS == 1
#define GOODBYE printf("GoodBye from %s.\n", __FILE__);
#elif CAPS == 2
#define GOODBYE printf("GOODBYE from %s.\n", __FILE__);
#else
#define GOODBYE printf("Goodbye from %s.\n", __FILE__);
#endif

void goodbye(void)
{
	GOODBYE;
}
