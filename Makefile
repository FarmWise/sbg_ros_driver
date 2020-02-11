#!/bin/bash
# Build recipe for creating a debian
#
# Copyright (C) 2019, FarmWise Labs Inc.
SHELL := /bin/bash

build: src CMakeLists.txt
	mkdir -p $@
	cd build && cmake -D STANDALONE_INSTALL=1 ..
	cd build && cmake --build .

debian: build
	mkdir -p $@
	cd build && cpack -G DEB
	mv build/*.deb $@

clean:
	rm -r build
	rm -r debian
.PHONY: clean
