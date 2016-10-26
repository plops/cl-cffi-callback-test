#include <wal.h>
Big big = {1,2};

void run0(Callback0 cb){
  cb(big);
}

void run1(Callback1 cb){
  cb(&big);
}
