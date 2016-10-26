#include <stdint.h>
struct Big {
uint64_t i0;
uint64_t i1;

};

typedef struct Big Big;
enum CallbackResult { RESULT_OK};

typedef enum CallbackResult CallbackResult;
typedef CallbackResult (*Callback0)(Big big);
typedef CallbackResult (*Callback1)(Big *big);