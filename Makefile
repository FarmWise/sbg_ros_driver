#!/bin/bash
# Build recipe for creating a debian
#
# Copyright (C) 2019, FarmWise Labs Inc.
SHELL := /bin/bash

build: src CMakeLists.txt
	mkdir -p $@
	cd build && cmake -D STANDALONE_INSTALL=1 ..
	cd build && cmake --build .

debian: _debian VERSION
.PHONY: debian

_debian: build
	cd build && cpack -G DEB
	mv build/*.deb .
.PHONY: _debian

VERSION:
	cat $(ls *.deb) > $@

clean:
	rm -rf build
	rm -rf *.deb
	rm -rf VERSION
.PHONY: clean
