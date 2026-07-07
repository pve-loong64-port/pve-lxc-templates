BUILD_DATE := $(shell date +%Y%m%d)

BUILD_DIR := build
OUT_DIR := out

.PHONY: all
all: alpine alt gentoo openeuler

.PHONY: clean
clean:
	rm -rf build out

$(OUT_DIR):
	mkdir -pv $(OUT_DIR)

include $(wildcard distros/*.mk)
