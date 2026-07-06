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

ALPINE_RELEASE = 3.24
ALPINE_TARGET = alpine-$(ALPINE_RELEASE)-default_$(BUILD_DATE)_loong64

$(OUT_DIR)/$(ALPINE_TARGET).tar.xz: | $(BUILD_DIR) $(OUT_DIR)
	./build-loong64-lxc $(CURDIR)/lxc-ci/images/alpine.yaml \
		-o image.release=$(ALPINE_RELEASE) \
		-o image.variant=default \
		-o image.architecture=loongarch64
	mv $(BUILD_DIR)/rootfs.tar.xz $@

$(OUT_DIR)/$(ALPINE_TARGET).aplinfo: $(OUT_DIR)/$(ALPINE_TARGET).tar.xz
	./gen-aplinfo alpine $(ALPINE_RELEASE) $(BUILD_DATE) $(OUT_DIR) $(ALPINE_TARGET).tar.xz $@

.PHONY: alpine
alpine: $(OUT_DIR)/$(ALPINE_TARGET).aplinfo

GENTOO_RELEASE = current
GENTOO_TARGET = gentoo-$(GENTOO_RELEASE)-openrc_$(BUILD_DATE)_loong64

$(OUT_DIR)/$(GENTOO_TARGET).tar.xz: | $(BUILD_DIR) $(OUT_DIR)
	./build-loong64-lxc $(CURDIR)/lxc-ci/images/gentoo.yaml \
		-o source.variant=openrc \
		-o image.variant=openrc \
		-o image.architecture=loongarch64
	mv $(BUILD_DIR)/rootfs.tar.xz $@

$(OUT_DIR)/$(GENTOO_TARGET).aplinfo: $(OUT_DIR)/$(GENTOO_TARGET).tar.xz
	./gen-aplinfo gentoo $(GENTOO_RELEASE) $(BUILD_DATE) $(OUT_DIR) $(GENTOO_TARGET).tar.xz $@

.PHONY: gentoo
gentoo: $(OUT_DIR)/$(GENTOO_TARGET).aplinfo
