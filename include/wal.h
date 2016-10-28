struct Big {
unsigned long int i0;
unsigned long int i1;

};

typedef struct Big Big;
enum CallbackResult { RESULT_OK = 0, RESULT_FAIL = 0x80000000};

typedef enum CallbackResult CallbackResult;
typedef CallbackResult (*Callback0)(Big big);
typedef CallbackResult (*Callback1)(Big *big);
Big* allocate_big(unsigned long int a,unsigned long int b);
void free_big(Big* big);
void run0(Callback0 cb,Big big);
void run1(Callback1 cb,Big* big);