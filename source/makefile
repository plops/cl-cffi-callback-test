HARDENFLAGS += -Wformat -Wformat-security -Werror=format-security \
-fstack-protector-strong --param ssp-buffer-size=4 \
-O2 -D_FORTIFY_SOURCE=2 \
-fPIC \
-fPIE \
-fno-strict-overflow \
-Wl,-z,relro,-z,bindnow 

CFLAGS=-ggdb -Wall -Wextra -std=gnu11

CC = gcc

../lib/libwal.so: wal.c
	$(CC) -o ../lib/libwal.so -shared $(CFLAGS) $(HARDENFLAGS)

clean:
	rm ../lib/libwal.so
