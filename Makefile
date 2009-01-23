all:
	$(MAKE) -C src
	mkdir -p components
	ln -fn src/DockProgress.{xpt,dylib} components/

clean:
	$(MAKE) -C src clean
	rm -rf components

.PHONY: all clean
