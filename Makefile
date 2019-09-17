CC ?= gcc
CXX ?= g++
CMAKE ?= cmake
CMAKE_BUILD_TYPE ?= Release

define build_cross
	-rm -fr build-$(2)
	mkdir build-$(2)
	cd build-$(2) && \
		$(CMAKE) \
			-D CMAKE_BUILD_TYPE=$(CMAKE_BUILD_TYPE) \
			-D CMAKE_TOOLCHAIN_FILE=cmake/$(1)-$(2).cmake \
			..
	make -j$$((nproc+1)) VERBOSE=$(VERBOSE) -C build-$(2)
endef

.PHONY: imx6 ath79

all:
	-rm -fr build
	mkdir build
	cd build && CC=$(CC) CXX=$(CXX) $(CMAKE) \
		-D UCERT_FULL=1 \
		-D UCERT_HOST_BUILD=1 \
		-D CMAKE_BUILD_TYPE=$(CMAKE_BUILD_TYPE) \
		-D CMAKE_PREFIX_PATH=$(STAGING_DIR_HOST) \
		..
	make -j$$((nproc+1)) VERBOSE=$(VERBOSE) -C build

imx6:
	$(call build_cross,openwrt-toolchain,$@)

ath79:
	$(call build_cross,openwrt-toolchain,$@)

clean:
	@-rm -fr build*

test-compile:
	for v in 6 7 8 9; do \
		make clean all imx6 ath79 CXX=g++-$$v CC=gcc-$$v || break; \
	done

-include local.mk
