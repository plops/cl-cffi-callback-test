#include <stddef.h>
struct Big {
uint64_t i0;
uint64_t i1;

};

enum CallbackResult { RESULT_OK};

typedef CallbackResult (*Callback0)(Big big);
typedef CallbackResult (*Callback1)(Big *big);