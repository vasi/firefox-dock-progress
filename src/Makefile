# TODO: SDK, Universal

MOZILLA_SDK = /Users/vasi/Downloads/xulrunner-sdk
EXTRA_LIBS = /Library/Fink/permanent/lib

IDL_INCLUDES = $(MOZILLA_SDK)/idl
XPIDL = env DYLD_FALLBACK_LIBRARY_PATH=$(EXTRA_LIBS) $(MOZILLA_SDK)/bin/xpidl \
	-I$(IDL_INCLUDES)

CXX = g++ -Wall -Wno-non-virtual-dtor -Os -fno-rtti -fno-exceptions -fPIC
COMPILE = $(CXX) -DXPCOM_GLUE -DXPCOM_GLUE_USE_NSPR -I$(MOZILLA_SDK)/sdk/include
LINK = $(CXX) -L$(MOZILLA_SDK)/lib -lxpcomglue_s -lxpcom -lnspr4 \
	-Wl,-executable_path,$(MOZILLA_SDK)/bin/xulrunner -bundle

all: DockProgress.dylib DockProgress.xpt

%.h: %.idl
	$(XPIDL) -m header -e $@ $<

%.xpt: %.idl
	$(XPIDL) -m typelib -e $@ $<

%.xpt: I%.xpt
	$(MOZILLA_SDK)/bin/xpt_link $@ $<

idl: IDockProgress.h IDockProgress.xpt

clean:
	rm -f IDockProgress.h DockProgress.dylib *.xpt *.o

%.dylib: %.o %Module.o
	$(LINK) -o $@ $^

%.o: %.cpp IDockProgress.h
	$(COMPILE) -c -o $@ $<

.PHONY: idl clean all

.PRECIOUS: %.o
