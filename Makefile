VERSION = $(shell perl -ne 'print $$1 if m,<em:version>(.*)</em:version>,' \
	install.rdf)
XPI = DockProgress-$(VERSION).xpi
ZIP = rm -f $(XPI) && zip $(XPI) -r chrome chrome.manifest components \
	defaults install.rdf icon.png -x '*/.DS_Store'
RAKE = $(MAKE) -C src

all: release
release:
	$(RAKE) release
debug:
	$(RAKE) debug

clean:
	$(RAKE) clean
	rm -rf components/*.dylib components/*.xpt chrome/content/*.dylib *.xpi

xpi: release
	$(RAKE) install
	$(ZIP)
xpid: debug
	$(RAKE) install-debug
	$(ZIP)

.PHONY: all release debug clean xpi xpid
