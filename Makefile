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
	rm -rf components

.PHONY: all native universal clean %.dylib
