MOZILLA_SDK = /Users/vasi/Downloads/xulrunner-sdk
EXTRA_LIBS = /Library/Fink/permanent/lib
MAC_SDK = /Developer/SDKs/MacOSX10.4u.sdk


COMPONENT = DockProgress

ARCHES = i386 ppc
NATIVE = $(shell arch)
ARCH_FLAG = $(if $(ARCH),-arch $(ARCH),)
ARCH_POST = $(if $(filter-out $(NATIVE),$(ARCH)),-$(ARCH),)
ARCH_MOZ_SDK = $(MOZILLA_SDK)$(ARCH_POST)


IDL_INCLUDES = $(MOZILLA_SDK)/idl
XPIDL = env DYLD_FALLBACK_LIBRARY_PATH=$(EXTRA_LIBS) $(MOZILLA_SDK)/bin/xpidl \
	-I$(IDL_INCLUDES)

OPT = -g
#OPT = -Os
CXX = g++ -Wall -Wno-non-virtual-dtor $(OPT) $(ARCH_FLAG) \
	-fno-rtti -fno-exceptions -fPIC -fno-strict-aliasing -fpascal-strings \
	-fno-common -fshort-wchar
COMPILE = $(CXX) -DXPCOM_GLUE -DXPCOM_GLUE_USE_NSPR \
	-isysroot $(MAC_SDK) -I$(ARCH_MOZ_SDK)/sdk/include
LINK = $(CXX) -Wl,-syslibroot,$(MAC_SDK) -L$(ARCH_MOZ_SDK)/lib \
	-lxpcomglue_s -lxpcom -lnspr4 -framework Cocoa \
	-Wl,-executable_path,$(ARCH_MOZ_SDK)/bin/xulrunner -bundle

all: universal

native: $(COMPONENT).dylib $(COMPONENT).xpt

universal: $(COMPONENT)-universal.dylib $(COMPONENT).xpt

$(COMPONENT)-universal.dylib: $(COMPONENT).dylib
	for arch in $(filter-out $(NATIVE),$(ARCHES)); do \
		$(MAKE) ARCH=$$arch $(COMPONENT)-$$arch.dylib; \
	done
	lipo -create -output $@ $(COMPONENT).dylib \
		$(foreach arch,$(filter-out $(NATIVE),$(ARCHES)), \
			$(COMPONENT)-$(arch).dylib)

%.h: %.idl
	$(XPIDL) -m header -e $@ $<

%.xpt: %.idl
	$(XPIDL) -m typelib -e $@ $<

%.xpt: I%.xpt
	$(MOZILLA_SDK)/bin/xpt_link $@ $<

idl: I$(COMPONENT).h I$(COMPONENT).xpt

clean:
	rm -f I$(COMPONENT).h *.dylib *.xpt *.o

%.dylib: %.o Module%.o
	$(LINK) -o $@ $^

%$(ARCH_POST).o: %.mm I$(COMPONENT).h
	$(COMPILE) -c -o $@ $<

%$(ARCH_POST).o: %.cpp I$(COMPONENT).h
	$(COMPILE) -c -o $@ $<

.PHONY: idl clean native universal

.PRECIOUS: %$(ARCH_POST).o

