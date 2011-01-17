
#include <string.h>
#include "gprolog.h"


Bool square(long n, FIOArg *squaren) {
    if (!squaren->is_var) {
        return n * n == squaren->value.l;
    }

    squaren->value.l = n * n;

    return TRUE;
}
