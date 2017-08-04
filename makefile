#_CC=cc -g +DD64
_CC=gcc -g -m64 -fPIC
DEPENDHOME=/crmpdpp/sgwadm/Eai/lua_frame/dependsrc
LUAHOME=$(DEPENDHOME)/lua-5.1.5
CURLHOME=$(DEPENDHOME)/curl
CPROPSHOME=$(DEPENDHOME)/cprops


#SOLIB_FLAG=-b
SOLIB_FLAG=-shared
CINC=  -DENABLE_CJSON_GLOBAL -DLUA_C89_NUMBERS -Dinline= -I$(LUAHOME)/src -I. -I$(CURLHOME)/include -I$(DEPENDHOME) -I$(CPROPSHOME)
CLIB=  -lm -ldl -lpthread -L. -lcjson -L$(LUAHOME)/src -llua

#all:cjson.so iconv.so  mykv.so callhttp.so mytime.so  mylog.so mylib.so
all:cjson.so iconv.so  mykv.so callhttp.so mytime.so  mylog.so

#LIBCC=cc -qkeyword=inline -qlanglvl=extended -q64 -g
#OBJS=dtoa.o g_fmt.o  fpconv.o    lua_cjson.o  strbuf.o
OBJS=fpconv.o strbuf.o lua_cjson.o

cjson.so:$(OBJS)
	#$(LIBCC)  ${SOLIB_FLAG} -o $@ $?
	$(_CC)  ${SOLIB_FLAG} -o $@ $?
	
libcjson.a:$(OBJS)
	$(AR)  $@ $?
	#$(_RANLIB) $@

LUAICONVOBJS=lua_iconv.o
iconv.so:$(LUAICONVOBJS)
	$(_CC)  ${SOLIB_FLAG} -o $@ $?
	
CALLHTTPOBJS=lua_callhttp.o
callhttp.so:$(CALLHTTPOBJS)
	$(_CC)  ${SOLIB_FLAG} -o $@ $? -L$(CURLHOME)/lib -lcurl
	
MYGETKVOBJS=lua_mykv.o
mykv.so:$(MYGETKVOBJS)
	$(_CC)  ${SOLIB_FLAG} -o $@ $? -L$(CPROPSHOME) -lcprops
	#$(_CC)  ${SOLIB_FLAG} -o $@ $? -L/crmpdpp/sgwadm/Eai/cms/lib -lcprops
	
	
MYLOG=lua_mylog.o 
mylog.so:$(MYLOG)
	$(_CC)  ${SOLIB_FLAG} -o $@ $?

MYREDISBJS=lua_myredis.o /inter/Eai/mylua2/publib/libhiredis.a
myredis.so:$(MYREDISBJS) 
	$(_CC)  ${SOLIB_FLAG} -o $@ $?
	
MYTIMEBJS=lua_mytime.o 
mytime.so:$(MYTIMEBJS)
	$(_CC)  ${SOLIB_FLAG} -o $@ $?
	
MYLIBBJS=mylib.o sha1.o
mylib.so:$(MYLIBBJS)
	$(_CC)  ${SOLIB_FLAG} -o $@ $?
	
.c.o:
	@echo "#########Compiling the $<"
	$(_CC) -c $(CINC) $<

clean:
	rm -rf *.o      *.orig *.so *.a luaxx

