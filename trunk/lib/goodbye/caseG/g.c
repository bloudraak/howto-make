#include <stdio.h>
#include "caseG/g.h"

#if   defined( CAPS1 )
#define GOODBYE printf("GoodBye from %s.\n", __FILE__);
#elif defined( CAPS2 )
#define GOODBYE printf("GOODBYE from %s.\n", __FILE__);
#else
#define GOODBYE printf("Goodbye from %s.\n", __FILE__);
#endif

void goodbye(void)
{
	GOODBYE;
}
