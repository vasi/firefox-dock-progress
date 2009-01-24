VERSION = $(shell perl -ne 'print $$1 if m,<em:version>(.*)</em:version>,' \
	install.rdf)
XPI = DockProgress-$(VERSION).xpi

all: universal

native: DockProgress.dylib
universal: DockProgress-universal.dylib

%.dylib:
	$(MAKE) -C src $@ DockProgress.xpt
	mkdir -p components
	ln -f src/DockProgress.xpt components/
	ln -f src/$@ components/DockProgress.dylib

clean:
	$(MAKE) -C src clean
	rm -rf components *.xpi

idl:
	$(MAKE) -C src $@

xpi: universal
	rm -f $(XPI)
	zip $(XPI) -r chrome chrome.manifest components images install.rdf \
		-x '*/.DS_Store'

.PHONY: all native universal clean %.dylib idl xpi