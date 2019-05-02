#
# Makefile 
#

VERSION:= 0.0.1
CC = gcc

#CFLAGS = -c -Wall -O2 -s -DNDEBUG
CFLAGS = -c -O2 -s -DNDEBUG

HEADER = -I/usr/local/include

LIB = -L/usr/local/lib -lwiringPi -lcrypt -lpthread -lm -lrt

EXEC = rpi_i2c_oled
EXEC_VERSION = $(EXEC).$(VERSION)
LOCAL_BIN = /usr/local/bin

SRCS := $(wildcard *.c)
BINS := $(SRCS:.c=.o)

all: $(EXEC)

$(EXEC): $(BINS)
	$(CC) $(BINS) $(LIB) -o $(EXEC_VERSION)
	cp -f $(EXEC_VERSION) $(LOCAL_BIN)
	-rm $(LOCAL_BIN)/$(EXEC) 2>/dev/null || :
	ln -s $(LOCAL_BIN)/$(EXEC_VERSION) $(LOCAL_BIN)/$(EXEC)

%.o: %.c
	$(CC) $(CFLAGS) $(HEADER) $< 

clean:
	rm *.o
	rm $(EXEC)
