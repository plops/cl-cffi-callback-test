#include <wal.h>
#include <stdlib.h>
Big make_big(unsigned long int a,unsigned long int b){
  {
  Big big = {a,b};

  return big;
}

}

Big* allocate_big(unsigned long int a,unsigned long int b){
  {
  Big* big = malloc(sizeof(Big));

  big->i0 = a;big->i1 = b;

  return big;
}

}

void free_big(Big* big){
  free(big);
}

void run0(Callback0 cb,Big big){
  cb(big);
}

void run1(Callback1 cb,Big* big){
  cb(big);
}
