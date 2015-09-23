CC?=gcc
AR?=ar
override CFLAGS+=-Wall -fPIC -I$(INCLUDE)
override LDFLAGS+=-L.
override LIBCFLAGS+=-shared -fPIC
LDLIBS = -lc
INCLUDE=lib
SYMLINK?=ln -sv
LIBCFLAGS=-shared -fPIC
LDFLAGS=-L.
PROG=journal

LIBMAJOR:=.1
LIBMINOR:=.1
LIBPATCH:=.57

LINKERNAME:=$(PROG)
LINKERFILENAME:=lib$(LINKERNAME).so
SONAME:=$(LINKERFILENAME)$(LIBMAJOR)
REALNAME=$(SONAME)$(LIBMINOR)$(LIBPATCH)

LIBSTATIC=lib$(LINKERNAME).a

LIBOBJ=journal.o

$(PROG): main.o $(LIBSTATIC) $(REALNAME) 
	
	$(CC) -o $@.static $< $(LDFLAGS) -l:$(LIBSTATIC)
	touch $(PROG).log
	$(CC) -o $@.shared $< $(LDFLAGS) -l$(LINKERNAME)
	LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH ./$@.shared
	cat $(PROG).log
	rm -f *.o *$(PROG)*


$(LIBOBJ):$(INCLUDE)/journal.c
	$(CC) -c $^ $(CFLAGS)


$(LIBSTATIC):$(LIBSTATIC)($(LIBOBJ))

$(REALNAME): $(LIBOBJ)
	$(CC) $(LIBCFLAGS) -Wl,-soname,$(SONAME) -o $@ $^ $(LDLIBS)
	$(SYMLINK) $@ $(SONAME)
	$(SYMLINK) $@ $(LINKERFILENAME)




libs:$(LIBSTATIC) $(REALNAME)




clean:
	rm -f *.o *$(PROG)*

