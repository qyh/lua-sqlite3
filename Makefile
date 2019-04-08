.PHONY: all lua clean install test SQLITE_SO
# Target files
all:	sub	lua SQLITE_SO
# Which compiler
CC = gcc -std=c99
#CC = c99
CFLAGS = -fPIC -shared
LIBS = -llua -lsqlite3
MAKE = make
LUA_PATH=./lua
LUA_CFLAGS = -fPIC

# Options for development
#CFLAGS = -g -Wall -ansi

SQLITE_SO := sqlite.so

..c.o:	
	$(CC) -c $<
sub:
	git submodule update --init
lua:
	$(MAKE) -C $(LUA_PATH) LOCAL=$(LUA_CFLAGS)

SQLITE_SO:	lua-sqlite.c	
	$(CC) $(CFLAGS)	-o $(SQLITE_SO) $^ $(LIBS)

clean :
	-rm -rf $(SQLITE_SO) && rm -rf $(LUA_PATH)/*.o && rm -rf $(LUA_PATH)/*.so  && rm -rf $(LUA_PATH)/*.a   
