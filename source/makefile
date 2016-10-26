HARDENFLAGS += -Wformat -Wformat-security -Werror=format-security \
-fstack-protector-strong --param ssp-buffer-size=4 \
-O2 \
-fPIC \
-fPIE \
-fno-strict-overflow -Wl,-z,relro,-z,bindnow 

#-D_FORTIFY_SOURCE=2 

CFLAGS=-ggdb -Wall -Wextra -std=gnu11 -I../include

CC = gcc

../lib/libwal.so: wal.c
	$(CC) wal.c -o ../lib/libwal.so -shared $(CFLAGS) $(HARDENFLAGS)

clean:
	rm ../lib/libwal.so
