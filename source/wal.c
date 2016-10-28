#include <wal.h>
Big make_big(unsigned long int a,unsigned long int b){
  {
  Big big = {a,b};

  return big;
}

}

void run0(Callback0 cb,Big big){
  cb(big);
}

void run1(Callback1 cb,Big* big){
  cb(big);
}
