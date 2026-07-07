BUILD_DATE := $(shell date +%Y%m%d)

BUILD_DIR := build
OUT_DIR := out

.PHONY: all
all:

.PHONY: clean
clean:
	rm -rf build out

$(BUILD_DIR):
	mkdir -pv $(BUILD_DIR)

$(OUT_DIR):
	mkdir -pv $(OUT_DIR)

include $(wildcard distros/*.mk)
