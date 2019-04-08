.PHONY: all lua sqlite clean install test SQLITE_SO
# Target files
all:	sub	lua sqlite SQLITE_SO
# Which compiler
CC = gcc -std=c99
#CC = c99
CFLAGS = -fPIC -shared
#LIBS = -llua -lsqlite3
LIBS = -lpthread
MAKE = make
LUA_PATH=./lua
LUA_CFLAGS = -fPIC
SQLITE_PATH = ./sqlite

SQLITE_SO := sqlite.so

sqlite:
	$(MAKE) -C $(SQLITE_PATH)
	cp $(SQLITE_PATH)/.libs/libsqlite3.a ./

#..c.o:	
#	$(CC) -c $<
sub:
	git submodule update --init
lua:
	$(MAKE) -C $(LUA_PATH) LOCAL=$(LUA_CFLAGS)
	cp $(LUA_PATH)/liblua.a ./

SQLITE_SO:	lua-sqlite.c liblua.a libsqlite3.a
	$(CC) $(CFLAGS)	-o $(SQLITE_SO) $^ $(LIBS)

clean :
	-rm -rf $(SQLITE_SO) && rm -rf $(LUA_PATH)/*.o && rm -rf $(LUA_PATH)/*.so  && rm -rf $(LUA_PATH)/*.a  && $(MAKE) clean -C $(SQLITE_PATH)
