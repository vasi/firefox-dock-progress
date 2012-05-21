RAKE := $(shell drake -V >&/dev/null && echo drake || echo rake)

%:
	@$(RAKE) $@
all:
	@$(RAKE) release
.PHONY: all
