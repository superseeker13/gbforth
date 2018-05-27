SHELL := /bin/bash

export DMGFORTH_PATH := $(shell pwd)/lib

LIB_FILES=lib/*.fs
SOURCE_FILES=dmgforth src/*.fs
TESTS=test/test-asm-sub.gb test/test-dup.gb test/test-swap.gb test/test-drop.gb test/test-memget.gb test/test-memset.gb test/test-plus.gb test/test-quadruple.gb

.PHONY: all examples tests

# Pattern rule to build dmg-forth roms
%.gb: %.fs $(SOURCE_FILES) $(LIB_FILES)
	./dmgforth $< $@

all: examples

#
# Examples
#
examples: \
	examples/hello-world-asm/hello.gb \
	examples/hello-world/hello.gb

examples/hello-world-asm/hello.gb: examples/hello-world-asm/hello.fs $(SOURCE_FILES) $(LIB_FILES)
	./dmgforth --no-kernel $< $@
	@cd examples/hello-world-asm/ && shasum -c hello.gb.sha

#
# Tests
#
check: tests
	gforth src/asm.spec.fs -e bye
	node test/test.js

tests: $(TESTS)

clean:
	-rm -f examples/hello-world-asm/hello.gb
	-rm -f examples/hello-world/hello.gb
	-rm -f test/test-asm-sub.gb
	-rm -f test/test-dup.gb
	-rm -f test/test-swap.gb
	-rm -f test/test-drop.gb
	-rm -f test/test-memget.gb
	-rm -f test/test-memset.gb
	-rm -f test/test-plus.gb
	-rm -f test/test-quadruple.gb
